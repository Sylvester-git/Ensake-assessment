import 'package:ensake/features/auth/cubit/current_user/get_current_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/auth/cubit/login/login_cubit.dart';
import 'dependency_inj.dart';

MultiBlocProvider getProvider({required Widget child}) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => instance<LoginCubit>()),
      BlocProvider(create: (context) => instance<GetCurrentUserCubit>()),
    ],
    child: child,
  );
}
