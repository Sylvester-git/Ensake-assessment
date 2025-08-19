import 'package:equatable/equatable.dart';

class CustomerModel extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;

  const CustomerModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [id, firstName, lastName, email, phoneNumber];
}
