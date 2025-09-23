import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/presentation/core/page_config.dart';
import 'package:todo_app/presentation/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:todo_app/presentation/pages/detail/todo_detail_page.dart';
import 'package:todo_app/presentation/pages/home/blocs/navigation_todo_cubit.dart';

import '../dashboard/dashboard_page.dart';
import '../overview/overview_page.dart';
import '../settings/settings_page.dart';

class HomePage extends StatefulWidget {
  final int index;

  HomePage({
    super.key,
    required String tab,
  }) : index = HomePage.tabs.indexWhere((element) => element.name == tab);

  static const PageConfig pageConfig = PageConfig(
    icon: Icons.home,
    name: 'home',
  );
  static const tabs = [
    DashboardPage.pageConfig,
    OverviewPage.pageConfig,
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
                leading: IconButton(
                  key: Key('create-todo-collection'),
                  onPressed: () {
                    context.pushNamed(CreateTodoCollectionPage.pageConfig.name);
                  },
                  icon: Icon(CreateTodoCollectionPage.pageConfig.icon),
                  tooltip: 'Create Todo Collection',
                ),
                trailing: IconButton(
                    onPressed: () =>
                        context.pushNamed(SettingsPage.pageConfig.name),
                    icon: Icon(SettingsPage.pageConfig.icon)),
                selectedIconTheme: IconThemeData(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                unselectedIconTheme: IconThemeData(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withAlpha(95)),
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
              builder: widget.index != 1
                  ? null
                  : (context) => BlocBuilder<NavigationToDoCubit,
                          NavigationToDoCubitState>(
                        builder: (context, state) {
                          final selectedId = state.selectedCollectionId;
                          final isSecondBodyDisplayed =
                              Breakpoints.mediumAndUp.isActive(context);
                          context
                              .read<NavigationToDoCubit>()
                              .secondBodyHasChanged(
                                  isSecondBodyDisplayed: isSecondBodyDisplayed);
                          if (selectedId == null) return const Placeholder();
                          return ToDoDetailPageProvider(
                            key: Key(selectedId.value),
                            collectionId: selectedId,
                          );
                        },
                      ),
            )
          }),
        ),
      ),
    );
  }

  void _tapOnNavigationDestination(BuildContext context, int index) =>
      context.goNamed(HomePage.pageConfig.name,
          pathParameters: {'tab': HomePage.tabs[index].name});
}
