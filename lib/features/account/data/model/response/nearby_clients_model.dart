import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/account/domain/entity/nearby_clients_entity.dart';

import 'nearby_client_model.dart';

class NearbyClientsModel extends BaseModel<NearbyClientsEntity> {
  NearbyClientsModel({
    this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<NearbyClientModel> items;

  factory NearbyClientsModel.fromMap(Map<String, dynamic> json) =>
      NearbyClientsModel(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        items: json["items"] == null
            ? []
            : List<NearbyClientModel>.from(
                json["items"].map((x) => NearbyClientModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount == null ? null : totalCount,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };

  @override
  NearbyClientsEntity toEntity() {
    return NearbyClientsEntity(
        items: items.map((e) => e.toEntity()).toList(), totalCount: totalCount);
  }
}
