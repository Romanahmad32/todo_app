import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/presentation/pages/home/home_page.dart';

import 'go_router_observer.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');
final routes = GoRouter(
  initialLocation: '/home/dashboard',
  navigatorKey: _rootNavigatorKey,
  observers: [GoRouterObserver()],
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => child,
      routes: [
        GoRoute(
          path: '/home/:tab',
          builder: (context, state) => HomePage(
            key: state.pageKey,
            tab:  state.pathParameters['tab']?? 'dashboard',
          ),
        )
      ],
    ),
  ],
);
