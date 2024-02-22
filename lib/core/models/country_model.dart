import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/entities/country_entity.dart';
import 'package:starter_application/core/models/base_model.dart';

class CountryModel extends BaseModel<CountryEntity> {
  CountryModel({
    required this.flag,
    required this.value,
    required this.text,
  });

  final String flag;
  final String value;
  final String text;

  factory CountryModel.fromMap(Map<String, dynamic> json) => CountryModel(
        flag: stringV(json["flag"]),
        value: stringV(json["value"]),
        text: stringV(json["text"]),
      );

  Map<String, dynamic> toMap() => {
        "flag": flag,
        "value": value,
        "text": text,
      };

  @override
  CountryEntity toEntity() {
    return CountryEntity(
      flag: flag,
      value: value,
      text: text,
    );
  }
}
