import 'package:dartz/dartz.dart';
import 'package:ensake/features/home/model/reward.dart';
import 'package:ensake/network/api_ds.dart';
import 'package:ensake/utils/error_handler.dart';
import 'package:ensake/utils/failure.dart';
import 'package:ensake/utils/mapper.dart';
import 'package:ensake/utils/storage.dart';

import '../features/auth/model/customer.dart';

abstract class ApiRepo {
  Future<Either<Failure, CustomerModel>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> claimRewards({required int rewardID});

  Future<Either<Failure, RewardResponseModel>> getRewards();
}

class ApiRepoImpl implements ApiRepo {
  final ApiDs _apiDs;
  final Storage _storage;

  ApiRepoImpl(this._storage, {required ApiDs apiDs}) : _apiDs = apiDs;
  @override
  Future<Either<Failure, void>> claimRewards({required int rewardID}) async {
    try {
      final res = await _apiDs.claimReward(rewardID: rewardID);
      return right(res);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, RewardResponseModel>> getRewards() async {
    try {
      final res = await _apiDs.getRewards();
      final val = res.toRewardResponseModel();
      return right(val);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, CustomerModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _apiDs.login(password: password, email: email);
      await _storage.saveToken(token: res['customer']['token']);
      await _storage.storeData(key: "customer", value: res['customer']);
      final val = res.toCustomerModel();
      return right(val);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }
}
