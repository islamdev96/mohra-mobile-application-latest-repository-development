import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/like/domain/entity/like_entity.dart';

import 'like_client_model.dart';

class LikeModel extends BaseModel<LikeEntity> {
  LikeModel({
    required this.refId,
    this.refType,
    this.creationTime,
    this.clientId,
    this.client,
    this.id,
  });

  final String refId;
  final int? refType;
  final DateTime? creationTime;
  final int? clientId;
  final LikeClientModel? client;
  final int? id;

  factory LikeModel.fromMap(Map<String, dynamic> json) => LikeModel(
        refId: stringV(json["refId"]),
        refType: json["refType"] == null ? null : json["refType"],
        creationTime: json["creationTime"] == null
            ? null
            : DateTime.parse(json["creationTime"]),
        clientId: json["clientId"] == null ? null : json["clientId"],
        client: json["client"] == null
            ? null
            : LikeClientModel.fromMap(json["client"]),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "refId": refId,
        "refType": refType == null ? null : refType,
        "creationTime":
            creationTime == null ? null : creationTime?.toIso8601String(),
        "clientId": clientId == null ? null : clientId,
        "client": client == null ? null : client?.toMap(),
        "id": id == null ? null : id,
      };

  @override
  LikeEntity toEntity() {
    return LikeEntity(
        refId: refId,
        refType: refType,
        client: client?.toEntity(),
        clientId: clientId,
        creationTime: creationTime,
        id: id);
  }
}
