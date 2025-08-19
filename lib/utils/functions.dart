import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

Future<String> getEnsakeDevice() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  String deviceID = "";
  String platform = "";
  String devicename = "";

  // Device ID
  if (Platform.isIOS) {
    deviceID = iosInfo.identifierForVendor ?? "";
  } else if (Platform.isAndroid) {
    deviceID = androidInfo.id;
  }

  //Platform
  if (Platform.isIOS) {
    platform = "ios";
  } else if (Platform.isAndroid) {
    platform = "android";
  }

  //Devicename
  if (Platform.isIOS) {
    devicename = iosInfo.name;
  } else if (Platform.isAndroid) {
    devicename = androidInfo.model;
  }

  return "$deviceID/$platform/$devicename";
}
