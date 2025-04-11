import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projet_flutter/features/charts/charts_screen.dart';
import 'package:projet_flutter/features/favorites/favorites_screen.dart';
import 'package:projet_flutter/features/home/home_screen.dart';
import 'package:projet_flutter/features/search/search_screen.dart';

// Définition des routes de l'application
class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/charts',
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return HomeScreen(child: child);
        },
        routes: [
          GoRoute(
            path: '/charts',
            name: 'charts',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const ChartsScreen(),
            ),
          ),
          GoRoute(
            path: '/search',
            name: 'search',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: SearchScreen(),
            ),
          ),
          GoRoute(
            path: '/favorites',
            name: 'favorites',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const FavoritesScreen(),
            ),
          ),
        ],
      ),
    ],
  );
} 