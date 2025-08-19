import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/auth/cubit/login_cubit.dart';
import 'dependency_inj.dart';

MultiBlocProvider getProvider({required Widget child}) {
  return MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => instance<LoginCubit>(),
   
    )
  ], child: child);
}
