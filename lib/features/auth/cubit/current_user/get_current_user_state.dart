import '/features/auth/model/customer.dart';
import 'package:equatable/equatable.dart';

class GetCurrentUserState extends Equatable {
  final CustomerModel? customer;

  const GetCurrentUserState({required this.customer});

  factory GetCurrentUserState.initial() {
    return GetCurrentUserState(customer: null);
  }

  GetCurrentUserState copyWith({CustomerModel? customer}) {
    return GetCurrentUserState(customer: customer ?? this.customer);
  }

  @override
  List<Object?> get props => [customer];
}
