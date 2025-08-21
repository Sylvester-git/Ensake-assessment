import 'package:bloc/bloc.dart';
import 'package:ensake/utils/mapper.dart';
import 'package:ensake/utils/storage.dart';
import 'get_current_user_state.dart';

class GetCurrentUserCubit extends Cubit<GetCurrentUserState> {
  final Storage _storage;
  GetCurrentUserCubit({required Storage storage})
    : _storage = storage,
      super(GetCurrentUserState.initial());

  Future<void> getCurrentUser() async {
    final currentuserAsMap = await _storage.getData(key: "customer");
    if (currentuserAsMap != null) {
      final customer =
          (currentuserAsMap as Map<dynamic, dynamic>)
              .cast<String, dynamic>()
              .toCustomerModel();
      emit(state.copyWith(customer: customer));
    }
  }
}
