import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/Interact/domain/entity/Interaction_entity.dart';
import 'package:starter_application/features/like/domain/entity/like_entity.dart';

import 'Interaction_client_model.dart';

class InteractModel extends BaseModel<InteractionEntity> {
  InteractModel(
      {required this.refId,
      this.refType,
      this.creationTime,
      this.clientId,
      this.client,
      this.id,
      this.interactionType});

  final String refId;
  final int? refType;
  final int? interactionType;
  final DateTime? creationTime;
  final int? clientId;
  final InteractionClientModel? client;
  final int? id;

  factory InteractModel.fromMap(Map<String, dynamic> json) => InteractModel(
        refId: stringV(json["refId"]),
        refType: json["refType"] == null ? null : json["refType"],
        creationTime: json["creationTime"] == null
            ? null
            : DateTime.parse(json["creationTime"]),
        clientId: json["clientId"] == null ? null : json["clientId"],
        client: json["client"] == null
            ? null
            : InteractionClientModel.fromMap(json["client"]),
        interactionType: json['interactionType'],
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
  InteractionEntity toEntity() {
    return InteractionEntity(
        refId: refId,
        refType: refType,
        client: client?.toEntity(),
        clientId: clientId,
        creationTime: creationTime,
        interactionType: interactionType,
        id: id);
  }
}
