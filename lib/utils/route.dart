import 'package:ensake/features/home/pages/home.dart';
import 'package:ensake/features/profile/pages/profile.dart';
import 'package:ensake/features/qrcode/pages/qrcode.dart';
import 'package:ensake/features/re_route_page.dart';
import 'package:ensake/features/rewards/pages/rewards.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/pages/login.dart';
import '../features/page_with_navbar.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellHomeNavigationKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _shellQrcodeNavigationKey = GlobalKey<NavigatorState>(
  debugLabel: 'qrcode',
);
final _shellRewardsNavigationKey = GlobalKey<NavigatorState>(
  debugLabel: 'rewards',
);
final _shellProfileNavigationKey = GlobalKey<NavigatorState>(
  debugLabel: 'profile',
);

final route = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => ReRoutePage()),
    GoRoute(
      path: '/${LoginPage.routeName}',
      name: LoginPage.routeName,
      builder: (context, state) => LoginPage(),
    ),
    StatefulShellRoute.indexedStack(
      branches: [
        // Home
        StatefulShellBranch(
          navigatorKey: _shellHomeNavigationKey,
          routes: [
            GoRoute(
              path: "/${HomePage.routeName}",
              name: HomePage.routeName,
              builder: (context, state) => HomePage(),
            ),
          ],
        ),
        // Qr code
        StatefulShellBranch(
          navigatorKey: _shellQrcodeNavigationKey,
          routes: [
            GoRoute(
              path: "/${QrCodePage.routeName}",
              name: QrCodePage.routeName,
              builder: (context, state) => QrCodePage(),
            ),
          ],
        ),
        // Rewards
        StatefulShellBranch(
          navigatorKey: _shellRewardsNavigationKey,
          routes: [
            GoRoute(
              path: "/${RewardsPage.routeName}",
              name: RewardsPage.routeName,
              builder: (context, state) => RewardsPage(),
            ),
          ],
        ),
        // Profile
        StatefulShellBranch(
          navigatorKey: _shellProfileNavigationKey,
          routes: [
            GoRoute(
              path: "/${Profilepage.routeName}",
              name: Profilepage.routeName,
              builder: (context, state) => Profilepage(),
            ),
          ],
        ),
      ],
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavigation(navigationShell: navigationShell);
      },
    ),
  ],
);
