part of 'get_rewards_cubit.dart';

abstract class GetRewardsState extends Equatable {
  const GetRewardsState();

  @override
  List<Object> get props => [];
}

class GetRewardsInitial extends GetRewardsState {}

class GettingRewards extends GetRewardsState {}

class ErrorGettingRewards extends GetRewardsState {
  final String errormessage;

  const ErrorGettingRewards({required this.errormessage});
  @override
  List<Object> get props => [errormessage];
}

class GottenRewards extends GetRewardsState {
  final RewardResponseModel rewardResponseModel;

  const GottenRewards({required this.rewardResponseModel});

  @override
  List<Object> get props => [rewardResponseModel];
}
