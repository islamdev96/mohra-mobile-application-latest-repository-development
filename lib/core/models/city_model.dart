import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/entities/city_entity.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/core/models/country_model.dart';

class CityModel extends BaseModel<CityEntity> {
  CityModel({
    this.country,
    required this.value,
    required this.text,
  });

  final CountryModel? country;
  final String value;
  final String text;

  factory CityModel.fromMap(Map<String, dynamic> json) => CityModel(
        country: json["country"] == null
            ? null
            : CountryModel.fromMap(json["country"]),
        value: stringV(json["value"]),
        text: stringV(json["text"]),
      );

  Map<String, dynamic> toMap() => {
        "country": country == null ? null : country!.toMap(),
        "value": value,
        "text": text,
      };

  @override
  CityEntity toEntity() {
    return CityEntity(
      value: value,
      text: text,
      country: country?.toEntity(),
    );
  }
}
