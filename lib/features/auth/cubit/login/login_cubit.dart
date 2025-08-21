import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ensake/features/auth/model/customer.dart';
import 'package:ensake/network/api_repo.dart';
import 'package:equatable/equatable.dart';

import '../current_user/get_current_user_cubit.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final ApiRepo _apiRepo;
  final GetCurrentUserCubit _currentUserCubit;
  LoginCubit({
    required ApiRepo apiRepo,
    required GetCurrentUserCubit currentUserCubit,
  }) : _apiRepo = apiRepo,
       _currentUserCubit = currentUserCubit,
       super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoggingIn());
    try {
      final res = await _apiRepo.login(email: email, password: password);
      res.fold(
        (l) {
          log("Error in cubit");
          emit(ErrorLoggingIn(errormessage: l.message));
        },
        (r) {
          log("Success");
          emit(LoggedIn(customer: r));
          _currentUserCubit.getCurrentUser();
        },
      );
    } catch (e, s) {
      log(s.toString(), name: "Login stacktrace");
      emit(ErrorLoggingIn(errormessage: e.toString()));
    }
  }
}
