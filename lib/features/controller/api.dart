import 'package:ensake/features/auth/cubit/login/login_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/cubit/claim_reward/claim_reward_cubit.dart';
import '../home/cubit/get_rewards/get_rewards_cubit.dart';

class ApiController {
  static void login({
    required BuildContext context,
    required String email,
    required String password,
  }) => context.read<LoginCubit>().login(email: email, password: password);

  static void getRewards({required BuildContext context}) =>
      context.read<GetRewardsCubit>().getRewards();

  static void claimReward({
    required BuildContext context,
    required int rewardID,
  }) => context.read<ClaimRewardCubit>().claimReward(rewardID: rewardID);

}
