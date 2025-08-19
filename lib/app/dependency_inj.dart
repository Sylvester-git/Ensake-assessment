import 'package:ensake/features/auth/cubit/current_user/get_current_user_cubit.dart';
import 'package:ensake/features/home/cubit/claim_reward/claim_reward_cubit.dart';
import 'package:ensake/network/dio.dart';
import 'package:get_it/get_it.dart';

import '../features/auth/cubit/login/login_cubit.dart';
import '../features/home/cubit/get_rewards/get_rewards_cubit.dart';
import '../network/api_ds.dart';
import '../network/api_repo.dart';
import '../utils/storage.dart';

final instance = GetIt.instance;

Future<void> initDependencyInj() async {
  //API
  instance.registerLazySingleton<Api>(() => Api());
  //Datasoure
  instance.registerLazySingleton<ApiDs>(() => ApiDsImpl(api: instance()));
  //Storage
  instance.registerLazySingleton<Storage>(() => StorageImpl());
  //Repo
  instance.registerLazySingleton<ApiRepo>(
    () => ApiRepoImpl(instance(), apiDs: instance()),
  );
  //Cubit
  instance.registerLazySingleton<GetCurrentUserCubit>(
    () => GetCurrentUserCubit(),
  );
  instance.registerLazySingleton<GetRewardsCubit>(
    () => GetRewardsCubit(apiRepo: instance()),
  );
  instance.registerLazySingleton<ClaimRewardCubit>(
    () => ClaimRewardCubit(apiRepo: instance()),
  );
  instance.registerLazySingleton<LoginCubit>(
    () => LoginCubit(apiRepo: instance(), currentUserCubit: instance()),
  );
}
