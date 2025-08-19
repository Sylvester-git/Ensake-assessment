import 'dart:async';

import 'package:ensake/app/dependency_inj.dart';
import 'package:ensake/features/auth/pages/login.dart';
import 'package:ensake/features/home/pages/home.dart';
import 'package:ensake/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReRoutePage extends StatefulWidget {
  const ReRoutePage({super.key});

  @override
  State<ReRoutePage> createState() => _ReRoutePageState();
}

class _ReRoutePageState extends State<ReRoutePage> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    reRoute();
  }

  reRoute() {
    timer = Timer(const Duration(seconds: 1), () async {
      final token = await instance<Storage>().getToken();
      if (token == null) {
        context.go("/${LoginPage.routeName}");
      } else {
        context.go("/${HomePage.routeName}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
