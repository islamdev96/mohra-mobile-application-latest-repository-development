import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/favorite/domain/entity/favorite_entity.dart';

class FavoriteModel extends BaseModel<FavoriteEntity> {
  FavoriteModel({
    required this.refId,
    this.refType,
    this.creationTime,
    this.clientId,
    this.id,
  });

  final String refId;
  final int? refType;
  final DateTime? creationTime;
  final int? clientId;
  final int? id;

  factory FavoriteModel.fromMap(Map<String, dynamic> json) => FavoriteModel(
        refId: stringV(json["refId"]),
        refType: json["refType"] == null ? null : json["refType"],
        creationTime: json["creationTime"] == null
            ? null
            : DateTime.parse(json["creationTime"]),
        clientId: json["clientId"] == null ? null : json["clientId"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "refId": refId,
        "refType": refType == null ? null : refType,
        "creationTime":
            creationTime == null ? null : creationTime!.toIso8601String(),
        "clientId": clientId == null ? null : clientId,
        "id": id == null ? null : id,
      };

  @override
  FavoriteEntity toEntity() {
    return FavoriteEntity(
        refId: refId,
        id: id,
        refType: refType,
        creationTime: creationTime,
        clientId: clientId);
  }
}
