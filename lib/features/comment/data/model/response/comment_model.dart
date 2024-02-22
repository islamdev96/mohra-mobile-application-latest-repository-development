import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/comment/domain/entity/comment_entity.dart';

import 'comment_client_model.dart';

class CommentModel extends BaseModel<CommentEntity> {
  CommentModel({
    required this.text,
    required this.refId,
    this.refType,
    this.creationTime,
    this.clientId,
    this.client,
    this.id,
  });

  final String text;
  final String refId;
  final int? refType;
  final DateTime? creationTime;
  final int? clientId;
  final CommentClientModel? client;
  final int? id;

  factory CommentModel.fromMap(Map<String, dynamic> json) => CommentModel(
        text: stringV(json["text"]),
        refId: stringV(json["refId"]),
        refType: json["refType"] == null ? null : json["refType"],
        creationTime: json["creationTime"] == null
            ? null
            : DateTime.parse(json["creationTime"]),
        clientId: json["clientId"] == null ? null : json["clientId"],
        client: json["client"] == null
            ? null
            : CommentClientModel.fromMap(json["client"]),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "text": text,
        "refId": refId,
        "refType": refType == null ? null : refType,
        "creationTime":
            creationTime == null ? null : creationTime?.toIso8601String(),
        "clientId": clientId == null ? null : clientId,
        "client": client == null ? null : client?.toMap(),
        "id": id == null ? null : id,
      };

  @override
  CommentEntity toEntity() {
    return CommentEntity(
        text: text,
        refId: refId,
        id: id,
        creationTime: creationTime,
        clientId: clientId,
        client: client?.toEntity(),
        refType: refType);
  }
}
