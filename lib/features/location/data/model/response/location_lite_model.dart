import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/location/domain/entity/location_lite_entity.dart';

class LocationLiteModel extends BaseModel<LocationLiteEntity> {
  LocationLiteModel({
    required this.value,
    required this.text,
  });

  final String value;
  final String text;

  factory LocationLiteModel.fromMap(Map<String, dynamic> json) =>
      LocationLiteModel(
        value: stringV(json["value"]),
        text: stringV(json["text"]),
      );

  Map<String, dynamic> toMap() => {
        "value": value,
        "text": text,
      };

  @override
  LocationLiteEntity toEntity() {
    return LocationLiteEntity(value: value, text: text);
  }
}
