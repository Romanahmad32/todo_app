import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';

import '../dashboard/dashboard_page.dart';
import '../overview/overview_page.dart';
import '../settings/settings_page.dart';

class HomePage extends StatefulWidget {
  final int index;

  HomePage({
    super.key,
    required String tab,
  }) : index = HomePage.tabs.indexWhere((element) => element.name == tab);

  static const tabs = [
    DashboardPage.pageConfig,
    OverviewPage.pageConfig,
    SettingsPage.pageConfig
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final destinations = HomePage.tabs
      .map((page) =>
          NavigationDestination(icon: Icon(page.icon), label: page.name))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AdaptiveLayout(
          primaryNavigation: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.mediumAndUp: SlotLayout.from(
              key: Key('primary-navigation-medium'),
              builder: (context) => AdaptiveScaffold.standardNavigationRail(
                selectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.onBackground),
                unselectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.onBackground.withAlpha(95)),
                selectedIndex: widget.index,
                destinations: destinations
                    .map(
                      (e) => AdaptiveScaffold.toRailDestination(e),
                    )
                    .toList(),
                onDestinationSelected: (index) =>
                    _tapOnNavigationDestination(context, index),
              ),
            )
          }),
          bottomNavigation: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.small: SlotLayout.from(
                key: Key('bottom-navigation-small'),
                builder: (context) =>
                    AdaptiveScaffold.standardBottomNavigationBar(
                  currentIndex: widget.index,
                  destinations: destinations,
                  onDestinationSelected: (index) =>
                      _tapOnNavigationDestination(context, index),
                ),
              )
            },
          ),
          body: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.smallAndUp: SlotLayout.from(
              key: const Key('primary-body'),
              builder: (context) =>
                  HomePage.tabs[widget.index].child ?? Placeholder(),
            )
          }),
          secondaryBody: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.mediumAndUp: SlotLayout.from(
              key: const Key('secondary-body'),
              builder: AdaptiveScaffold.emptyBuilder,
            )
          }),
        ),
      ),
    );
  }

  void _tapOnNavigationDestination(BuildContext context, int index) =>
      context.go('/home/${HomePage.tabs[index].name}');
}
