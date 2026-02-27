import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/counter/presentation/counter_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';

/// Centralised declarative router for the application with custom transitions.
class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: HomeScreen.routePath,
    routes: [
      GoRoute(
        path: HomeScreen.routePath,
        name: HomeScreen.routeName,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: CounterScreen.routePath,
        name: CounterScreen.routeName,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const CounterScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.95, end: 1.0)
                    .animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
                child: child,
              ),
            );
          },
        ),
      ),
      GoRoute(
        path: ProfileScreen.routePath,
        name: ProfileScreen.routeName,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ProfileScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: SlideTransition(
                position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
                    .animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
                child: child,
              ),
            );
          },
        ),
      ),
    ],
  );
}
