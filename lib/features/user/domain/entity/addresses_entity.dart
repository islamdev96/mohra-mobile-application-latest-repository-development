import 'package:starter_application/core/entities/base_entity.dart';

class AddressListEntity extends BaseEntity  {
  AddressListEntity({
    required this.totalCount,
    required this.addresses,
  });

  int totalCount;
  List<AddressEntity> addresses;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class AddressEntity extends BaseEntity {
  AddressEntity({
    required this.cityName,
    required this.street,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.isDefault,
    required this.id,
  });

  String? cityName;
  String? street;
  String? description;
  double? latitude;
  double? longitude;
  bool? isDefault;
  int? id;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class CityEntity extends BaseEntity {
  CityEntity({
    required this.value,
    required this.text,
  });

  String value;
  String text;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}