import 'package:ensake/features/auth/model/customer.dart';
import 'package:ensake/features/home/model/reward.dart';
import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  /// Extension for quickly accessing app [ColorScheme]
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Extension for quickly accessing app [TextTheme]
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Extension for quickly accessing app [Theme]
  ThemeData get theme => Theme.of(this);

  /// Extension for quickly accessing screen size
  Size get screenSize => MediaQuery.sizeOf(this);
}

extension SizeBoxWidget on num {
  Widget get width => SizedBox(width: double.parse(toString()));
  Widget get height => SizedBox(height: double.parse(toString()));
}

extension ConvertloginresponseToCustomer on Map<String, dynamic> {
  CustomerModel toCustomerModel() {
    return CustomerModel(
      id: this['id'],
      firstName: this['first_name'],
      lastName: this['last_name'],
      email: this['email'],
      phoneNumber: this['phone_number'],
    );
  }
}

extension ConvertToRewardResponseModel on Map<String, dynamic> {
  RewardResponseModel toRewardResponseModel() {
    return RewardResponseModel(
      customerPoints: this['customer_points'],
      rewards:
          ((this['rewards'] as List)
              .cast<Map<String, dynamic>>()
              .map((data) => data.toRewardModel())
              .toList()),
    );
  }
}

extension ConvertToRewardModel on Map<String, dynamic> {
  RewardModel toRewardModel() {
    return RewardModel(
      id: this['id'],
      point: this['points'],
      brandModel: (this['brand'] as Map<String, dynamic>).toBrandModel(),
      description: this['description'],
      claimed: this['claimed'],
    );
  }
}

extension ConvertToBrandModel on Map<String, dynamic> {
  BrandModel toBrandModel() {
    return BrandModel(
      id: this['id'],
      name: this['name'],
      logo: this['logo'],
      address: this['address'],
    );
  }
}
