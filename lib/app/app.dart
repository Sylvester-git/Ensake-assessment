
import 'package:flutter/material.dart';
import '../utils/route.dart';
import '../utils/theme.dart';
import 'provider.dart';


class RootApp extends StatelessWidget {
  const RootApp._();

  static final instance = RootApp._();

  factory RootApp() => instance;

  @override
  Widget build(BuildContext context) {
    return getProvider(
      child: MaterialApp.router(
        theme: getLightTheme(),
        debugShowCheckedModeBanner: false,
        routeInformationParser: route.routeInformationParser,
        routerDelegate: route.routerDelegate,
        routeInformationProvider: route.routeInformationProvider,
      ),
    );
  }
}
