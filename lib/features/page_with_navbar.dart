import 'package:ensake/features/model/btm_nav_bar_item.dart';
import 'package:ensake/utils/assets.dart';
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
      body: SafeArea(child: Stack(children: [navigationShell])),
    );
  }
}

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
          color: Colors.white,
          child: BottomBar(
            items: [
              BtmNavBarItem(svgIcon: SvgAssets.home, name: "Home"),
              BtmNavBarItem(svgIcon: SvgAssets.qrcode, name: 'QR Code'),
              BtmNavBarItem(svgIcon: SvgAssets.reward, name: "Rewards"),
              BtmNavBarItem(svgIcon: SvgAssets.profile, name: "Profile"),
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
