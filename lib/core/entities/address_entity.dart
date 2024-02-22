import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/core/entities/city_entity.dart';

class AddressEntity extends BaseEntity {
  AddressEntity({
    this.cityId,
    this.city,
    required this.street,
    required this.description,
    this.latitude,
    this.longitude,
    this.id,
    this.isDefault = false,
  });

  final int? cityId;
  final CityEntity? city;
  final String? street;
  final String? description;
  final double? latitude;
  final double? longitude;
  final int? id;
  final bool isDefault;

  @override
  List<Object?> get props => [];
}
