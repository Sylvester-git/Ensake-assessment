import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../features/page_with_navbar.dart';
import '../features/splash_screen.dart';

final rootNavigation = GlobalKey<NavigatorState>();
final _shellHomeNavigationKey = GlobalKey<NavigatorState>(debugLabel: 'home');

final route = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => SplashScreen()),
    StatefulShellRoute.indexedStack(
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellHomeNavigationKey,
          routes: [
            //!
          ],
        ),
      ],
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavigation(navigationShell: navigationShell);
      },
    ),
  ],
);
