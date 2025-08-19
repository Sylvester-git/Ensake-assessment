import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ensake/app/app_init.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/bloc_observer.dart';
import 'services/config_services.dart';

void main() async {
  AppInit.preRun();
  await ConfigServices.loadConfig();
  log(ConfigServices.isLoaded.toString());
  Bloc.observer = MyBlocObserver();
  runApp(RootApp());
}
