import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/counter/presentation/counter_screen.dart';
import '../../features/home/presentation/home_screen.dart';

/// Centralised declarative router for the application.
class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: HomeScreen.routePath,
    routes: [
      GoRoute(
        path: HomeScreen.routePath,
        name: HomeScreen.routeName,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const NoTransitionPage(child: HomeScreen()),
      ),
      GoRoute(
        path: CounterScreen.routePath,
        name: CounterScreen.routeName,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const NoTransitionPage(child: CounterScreen()),
      ),
    ],
  );
}
