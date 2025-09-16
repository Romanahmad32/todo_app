import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/presentation/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:todo_app/presentation/pages/home/home_page.dart';
import 'package:todo_app/presentation/pages/overview/overview_page.dart';
import 'package:todo_app/presentation/pages/settings/settings_page.dart';

import '../../presentation/pages/detail/todo_detail_page.dart';
import '../../presentation/pages/home/blocs/navigation_todo_cubit.dart';
import 'go_router_observer.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

const String _basePath = '/home';
final routes = GoRouter(
  initialLocation: '$_basePath/dashboard',
  navigatorKey: _rootNavigatorKey,
  observers: [GoRouterObserver()],
  routes: [
    GoRoute(
        name: SettingsPage.pageConfig.name,
        path: '$_basePath/${SettingsPage.pageConfig.name}',
        builder: (context, state) => const SettingsPage()),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => child,
      routes: [
        GoRoute(
          name: HomePage.pageConfig.name,
          path: '$_basePath/:tab',
          builder: (context, state) => HomePage(
            key: state.pageKey,
            tab: state.pathParameters['tab'] ?? 'dashboard',
          ),
        ),
      ],
    ),
    GoRoute(
      path: '$_basePath/overview/${CreateTodoCollectionPage.pageConfig.name}',
      name: CreateTodoCollectionPage.pageConfig.name,
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text('details'),
          leading: BackButton(
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.goNamed(
                  HomePage.pageConfig.name,
                  pathParameters: {'tab': OverviewPage.pageConfig.name},
                );
              }
            },
          ),
        ),
        body: SafeArea(child: CreateTodoCollectionPage.pageConfig.child!),
      ),
    ),
    GoRoute(
      name: ToDoDetailPage.pageConfig.name,
      path: '$_basePath/overview/:collectionId',
      builder: (context, state) =>
          BlocListener<NavigationToDoCubit, NavigationToDoCubitState>(
        listenWhen: (previous, current) =>
            previous.isSecondBodyDisplayed != current.isSecondBodyDisplayed,
        listener: (context, state) {
          if (context.canPop() && (state.isSecondBodyDisplayed ?? false)) {
            context.pop();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('details'),
            leading: BackButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.goNamed(
                    HomePage.pageConfig.name,
                    pathParameters: {'tab': OverviewPage.pageConfig.name},
                  );
                }
              },
            ),
          ),
          body: ToDoDetailPageProvider(
            collectionId: CollectionId.fromUniqueString(
              state.pathParameters['collectionId'] ?? '',
            ),
          ),
        ),
      ),
    ),
  ],
);
