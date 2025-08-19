import 'package:bloc/bloc.dart';
import 'package:ensake/network/api_repo.dart';
import 'package:equatable/equatable.dart';

part 'claim_reward_state.dart';

class ClaimRewardCubit extends Cubit<ClaimRewardState> {
  final ApiRepo _apiRepo;
  ClaimRewardCubit({required ApiRepo apiRepo})
    : _apiRepo = apiRepo,
      super(ClaimRewardInitial());

  Future<void> claimReward({required int rewardID}) async {
    emit(ClaimingReward(rewardId: rewardID));
    try {
      final res = await _apiRepo.claimRewards(rewardID: rewardID);
      res.fold(
        (l) {
          emit(ErrorClaimingReward(errormessage: l.message));
        },
        (r) {
          emit(ClaimedReward());
        },
      );
    } catch (e) {
      emit(ErrorClaimingReward(errormessage: e.toString()));
    }
  }
}
