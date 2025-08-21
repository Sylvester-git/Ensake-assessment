import 'dart:async';

import 'package:ensake/features/auth/pages/login.dart';
import 'package:ensake/utils/color.dart';
import 'package:ensake/utils/storage.dart';
import 'package:flutter/material.dart';
import '../utils/global.dart';
import '../utils/route.dart';
import '../utils/theme.dart';
import 'provider.dart';

class RootApp extends StatefulWidget {
  const RootApp._();

  static final instance = RootApp._();

  factory RootApp() => instance;

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> with WidgetsBindingObserver {
  late Timer _timer;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((time) {
      _startTimer();
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    Storage storage = StorageImpl();
    storage.storeData(key: "activeTime", value: DateTime.now());
    int timeoutInSeconds = 300; // 5 minutes
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (timeoutInSeconds == 0) {
        timer.cancel();
        _timeoutAction();
      } else {
        timeoutInSeconds--;
      }
    });
  }

  void _resetTimer() {
    _timer.cancel();
    _startTimer();
  }

  void _timeoutAction() async {
    Storage storage = StorageImpl();
    final token = await storage.getToken();
    if (token != null) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          backgroundColor: AppColors.primary,
          content: Center(
            child: Text(
              "Session expired, login to continue",
              style: getLightTheme().textTheme.bodyMedium?.copyWith(
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
      storage.clearStorage();
      route.go("/${LoginPage.routeName}");
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    Storage storage = StorageImpl();
    if (state == AppLifecycleState.paused) {
      _resetTimer();
    } else if (state == AppLifecycleState.resumed) {
      storage.getData(key: "activeTime").then((value) {
        if (DateTime.now()
                .difference(DateTime.parse(value.toString()))
                .inMinutes >
            5) {
          _timeoutAction();
        } else {
          _resetTimer();
        }
      });
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return getProvider(
      child: MaterialApp.router(
        scaffoldMessengerKey: scaffoldMessengerKey,
        theme: getLightTheme(),
        debugShowCheckedModeBanner: false,
        routeInformationParser: route.routeInformationParser,
        routerDelegate: route.routerDelegate,
        routeInformationProvider: route.routeInformationProvider,
      ),
    );
  }
}
