import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/location/domain/entity/locations_lite_entity.dart';

import 'location_lite_model.dart';

class LocationsLiteModel extends BaseModel<LocationsLiteEntity> {
  LocationsLiteModel({
    this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<LocationLiteModel> items;

  factory LocationsLiteModel.fromMap(Map<String, dynamic> json) =>
      LocationsLiteModel(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        items: json["items"] == null
            ? []
            : List<LocationLiteModel>.from(
                json["items"].map((x) => LocationLiteModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount == null ? null : totalCount,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };

  @override
  LocationsLiteEntity toEntity() {
    return LocationsLiteEntity(
        items: items.map((e) => e.toEntity()).toList(), totalCount: totalCount);
  }
}
