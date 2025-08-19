import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:ensake/app/dependency_inj.dart';
import 'package:ensake/common/toast.dart';
import 'package:ensake/features/auth/pages/login.dart';
import 'package:ensake/utils/storage.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

Future<String> getEnsakeDevice() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String deviceID = "";
  String platform = "";
  String devicename = "";

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
    deviceID = androidDeviceInfo.id;
    platform = "android";
    devicename = androidDeviceInfo.model;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
    deviceID = iosDeviceInfo.identifierForVendor ?? "";
    platform = "ios";
    devicename = iosDeviceInfo.name;
  }
  return "$deviceID/$platform/$devicename";
}

void logOutOnExpiration({
  required String errormessage,
  required BuildContext context,
}) {
  if (errormessage.toLowerCase().contains("logged")) {
    context.go("/${LoginPage.routeName}");
    
    instance<Storage>().clearStorage();
  }
}
