import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/messages/domain/entity/last_message_entity.dart';

class LastMessageModel extends BaseModel<LastMessageEntity> {
  LastMessageModel({
    this.conversationId,
    this.groupId,
    required this.text,
    this.senderId,
    this.creationTime,
    required this.isRead,
    this.id,
  });

  final int? conversationId;
  final int? groupId;
  final String text;
  final int? senderId;
  final DateTime? creationTime;
  final bool isRead;
  final int? id;

  factory LastMessageModel.fromMap(Map<String, dynamic> json) =>
      LastMessageModel(
        conversationId:
            json["conversationId"] == null ? null : json["conversationId"],
        groupId: json["groupId"] == null ? null : json["groupId"],
        text: stringV(json["text"]),
        senderId: json["senderId"] == null ? null : json["senderId"],
        creationTime: json["creationTime"] == null
            ? null
            : DateTime.parse(json["creationTime"]),
        isRead: boolV(json["isRead"]),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "conversationId": conversationId == null ? null : conversationId,
        "groupId": groupId == null ? null : groupId,
        "text": text,
        "senderId": senderId == null ? null : senderId,
        "creationTime":
            creationTime == null ? null : creationTime?.toIso8601String(),
        "isRead": isRead,
        "id": id == null ? null : id,
      };

  @override
  LastMessageEntity toEntity() {
    return LastMessageEntity(
      text: text,
      isRead: isRead,
      creationTime: creationTime?.toLocal(),
      id: id,
      senderId: senderId,
      conversationId: conversationId,
      groupId: groupId,
    );
  }
}
