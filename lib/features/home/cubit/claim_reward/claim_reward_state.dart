part of 'claim_reward_cubit.dart';

abstract class ClaimRewardState extends Equatable {
  const ClaimRewardState();

  @override
  List<Object> get props => [];
}

class ClaimRewardInitial extends ClaimRewardState {}

class ErrorClaimingReward extends ClaimRewardState {
  final String errormessage;

  const ErrorClaimingReward({required this.errormessage});
  @override
  List<Object> get props => [errormessage];
}

class ClaimedReward extends ClaimRewardState {}

class ClaimingReward extends ClaimRewardState {
  final int rewardId;

  const ClaimingReward({required this.rewardId});
  @override
  List<Object> get props => [rewardId];
}
