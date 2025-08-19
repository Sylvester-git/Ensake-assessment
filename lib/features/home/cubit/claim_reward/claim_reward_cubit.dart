import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'claim_reward_state.dart';

class ClaimRewardCubit extends Cubit<ClaimRewardState> {
  ClaimRewardCubit() : super(ClaimRewardInitial());
}
