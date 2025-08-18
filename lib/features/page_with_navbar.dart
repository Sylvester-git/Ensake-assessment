import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widgets/nav_btm_bar.dart';

class ScaffoldWithNavigation extends StatelessWidget {
  const ScaffoldWithNavigation({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;
  static final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: _NavigationBar(navigationShell: navigationShell),
      body: Stack(children: [navigationShell]),
    );
  }
}

// class _ScaffoldWithNavigationRail extends StatefulWidget {
//   const _ScaffoldWithNavigationRail(this.navigationShell);
//   final StatefulNavigationShell navigationShell;

//   @override
//   State<_ScaffoldWithNavigationRail> createState() =>
//       _ScaffoldWithNavigationRailState();
// }

// class _ScaffoldWithNavigationRailState
//     extends State<_ScaffoldWithNavigationRail> {

// }

class _NavigationBar extends StatelessWidget {
  const _NavigationBar({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          color: Theme.of(context).colorScheme.primary.withOpacity(.9),
          child: BottomBar(
            items: [
              // BottomNavigationBarItem(
              //   icon: SvgPicture.asset(
              //     KaysovaUserAsset.homeInactivesvg,
              //     color: Theme.of(
              //       context,
              //     ).colorScheme.onPrimary.withOpacity(.5),
              //     colorBlendMode: BlendMode.srcIn,
              //     height: 24,
              //   ),
              //   activeIcon: SvgPicture.asset(
              //     KaysovaUserAsset.homeActivesvg,
              //     color: Theme.of(context).colorScheme.onPrimary,
              //     colorBlendMode: BlendMode.srcIn,
              //     height: 24,
              //   ),
              //   label: 'Home',
              // ),
            ],
            currentIndex: navigationShell.currentIndex,
            onTap: (index) {
              navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              );
            },
          ),
        ),
      ],
    );
  }
}
