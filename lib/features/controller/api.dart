import 'package:ensake/features/auth/cubit/login/login_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApiController {
  static void login({
    required BuildContext context,
    required String email,
    required String password,
  }) => context.read<LoginCubit>().login(email: email, password: password);


}
