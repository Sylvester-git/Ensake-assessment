import 'package:bloc/bloc.dart';
import 'package:ensake/features/auth/model/customer.dart';
import 'get_current_user_state.dart';

class GetCurrentUserCubit extends Cubit<GetCurrentUserState> {
  GetCurrentUserCubit() : super(GetCurrentUserState.initial());

  void getCurrentUser({required CustomerModel customer}) {
    emit(state.copyWith(
      customer: customer,
    ));
  }
}
