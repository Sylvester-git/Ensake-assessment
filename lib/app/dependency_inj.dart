import 'package:get_it/get_it.dart';

import '../features/auth/cubit/login_cubit.dart';

final instance = GetIt.instance;

Future<void> initDependencyInj() async {
  //Cubit
  instance.registerLazySingleton<LoginCubit>(() => LoginCubit());
}
