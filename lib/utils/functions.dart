import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:ensake/app/dependency_inj.dart';
import 'package:ensake/features/auth/pages/login.dart';
import 'package:ensake/features/home/model/reward.dart';
import 'package:ensake/utils/storage.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';


/// Function to get Ensake device ID 
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

/// Function to logout user when the error response from the api is "You are logged out"
void logOutOnExpiration({
  required String errormessage,
  required BuildContext context,
}) {
  if (errormessage.toLowerCase().contains("logged")) {
    context.go("/${LoginPage.routeName}");

    instance<Storage>().clearStorage();
  }
}


/// Get the list of claimed rewards
List<RewardModel> getClaimedRewards({required List<RewardModel> reviewmodel}) {
  return reviewmodel.where((data) => data.claimed == true).toList();
}


/// Get the available rewards a custoomer can afford with their current points
int getAvailableRewardCount({
  required List<RewardModel> reviewmodel,
  required int points,
}) {
  return reviewmodel
      .where((data) => data.claimed == false && data.point <= points)
      .toList()
      .length;
}

/// Get the list of available rewards
List<RewardModel> getAvailableRewards({
  required List<RewardModel> reviewmodel,
}) {
  return reviewmodel.where((data) => data.claimed == false).toList();
}
