import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/presentation/pages/home/home_page.dart';

import 'go_router_observer.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final routes = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  observers: [GoRouterObserver()],
  routes: [
    GoRoute(
      path: '/home/settings',
      builder: (context, state) => Container(
        color: Colors.orange,
      ),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomePage(),
    )
  ],
);

