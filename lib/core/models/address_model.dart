import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/entities/address_entity.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/core/models/city_model.dart';

class AddressModel extends BaseModel<AddressEntity> {
  AddressModel({
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
  final CityModel? city;
  final String street;
  final String description;
  final double? latitude;
  final double? longitude;
  final int? id;
  final bool isDefault;

  factory AddressModel.fromMap(Map<String, dynamic> json) => AddressModel(
        cityId: json["cityId"] == null ? null : json["cityId"],
        city: json["city"] == null ? null : CityModel.fromMap(json["city"]),
        street: stringV(json["street"]),
        description: stringV(json["description"]),
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        id: json["id"] == null ? null : json["id"],
        isDefault:  json["isDefault"] == null ? false : json["isDefault"],
      );

  Map<String, dynamic> toMap() => {
        "cityId": cityId == null ? null : cityId,
        "city": city == null ? null : city?.toMap(),
        "street": street,
        "description": description,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "id": id == null ? null : id,
      };

  @override
  AddressEntity toEntity() {
    return AddressEntity(
      street: street,
      description: description,
      id: id,
      cityId: cityId,
      latitude: latitude,
      longitude: longitude,
      city: city?.toEntity(),
      isDefault: isDefault,
    );
  }
}
