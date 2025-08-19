import 'package:bloc/bloc.dart';
import 'package:ensake/features/home/model/reward.dart';
import 'package:ensake/network/api_repo.dart';
import 'package:equatable/equatable.dart';

part 'get_rewards_state.dart';

class GetRewardsCubit extends Cubit<GetRewardsState> {
  final ApiRepo _apiRepo;
  GetRewardsCubit({required ApiRepo apiRepo})
    : _apiRepo = apiRepo,
      super(GetRewardsInitial());

  Future<void> getRewards() async {
    try {
      final res = await _apiRepo.getRewards();
      res.fold(
        (l) {
          emit(ErrorGettingRewards(errormessage: l.message));
        },
        (r) {
          emit(GottenRewards(rewardResponseModel: r));
        },
      );
    } catch (e) {
      emit(ErrorGettingRewards(errormessage: e.toString()));
    }
  }
}
