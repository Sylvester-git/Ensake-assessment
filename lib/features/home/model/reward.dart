import 'package:equatable/equatable.dart';

class RewardModel extends Equatable {
  final int id;
  final int point;
  final BrandModel brandModel;
  final String description;
  final bool claimed;

  const RewardModel({
    required this.id,
    required this.point,
    required this.brandModel,
    required this.description,
    required this.claimed,
  });

  @override
  List<Object?> get props => [id, point, brandModel, description, claimed];
}

class BrandModel extends Equatable {
  final int id;
  final String name;
  final String logo;
  final String address;

  const BrandModel({
    required this.id,
    required this.name,
    required this.logo,
    required this.address,
  });

  @override
  List<Object?> get props => [id, name, logo, address];
}
