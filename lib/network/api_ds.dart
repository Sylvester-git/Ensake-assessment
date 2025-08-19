import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ensake/network/dio.dart';
import 'package:ensake/utils/endpoints.dart';

abstract class ApiDs {
  Future<Map<String, dynamic>> login({
    required String password,
    required String email,
  });
  Future<Map<String, dynamic>> getRewards();
  Future<void> claimReward({required int rewardID});
}

class ApiDsImpl implements ApiDs {
  final Api _api;

  ApiDsImpl({required Api api}) : _api = api;
  @override
  Future<void> claimReward({required int rewardID}) async {
    try {
      final res = await _api.dio.post(
        AppEndpoints.rewards,
        data: {"reward_id": rewardID},
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        return;
      } else {
        throw Exception();
      }
    } on DioException {
      rethrow;
    } catch (e) {
      log(e.toString(), name: "claim reward err");
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getRewards() async {
    try {
      final res = await _api.dio.get(AppEndpoints.rewards);
      if (res.statusCode == 200 || res.statusCode == 201) {
        return res.data;
      } else {
        throw Exception();
      }
    } on DioException {
      rethrow;
    } catch (e) {
      log(e.toString(), name: "claim reward err");
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> login({
    required String password,
    required String email,
  }) async {
    try {
      final res = await _api.dio.post(
        AppEndpoints.login,
        data: {"email": email, "password": password},
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        return res.data['customer'];
      } else {
        throw Exception();
      }
    } on DioException {
      rethrow;
    } catch (e) {
      log(e.toString(), name: "claim reward err");
      rethrow;
    }
  }
}
