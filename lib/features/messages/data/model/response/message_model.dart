import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/messages/domain/entity/message_entity.dart';

import 'conversation_model.dart';
import 'group_model.dart';

class MessageModel extends BaseModel<MessageEntity> {
  MessageModel({
    required this.text,
    this.senderId,
    this.conversationId,
    this.conversation,
    this.groupId,
    this.group,
    required this.creationTime,
    required this.isRead,
    this.id,
  });

  final String text;
  final int? senderId;
  final int? conversationId;
  final ConversationModel? conversation;
  final int? groupId;
  final GroupModel? group;
  final DateTime creationTime;
  final bool isRead;
  final int? id;

  factory MessageModel.fromMap(Map<String, dynamic> json) => MessageModel(
        text: stringV(json["text"]),
        senderId: json["senderId"] == null ? null : json["senderId"],
        conversationId:
            json["conversationId"] == null ? null : json["conversationId"],
        conversation: json["conversation"] == null
            ? null
            : ConversationModel.fromMap(json["conversation"]),
        groupId: json["groupId"] == null ? null : json["groupId"],
        group: json["group"] == null ? null : GroupModel.fromMap(json["group"]),
        creationTime:  DateTime.parse(json["creationTime"]),
        isRead: boolV(json["isRead"]),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "text": text,
        "senderId": senderId == null ? null : senderId,
        "conversationId": conversationId == null ? null : conversationId,
        "conversation": conversation == null ? null : conversation?.toMap(),
        "groupId": groupId == null ? null : groupId,
        "group": group == null ? null : group?.toMap(),
        "creationTime":  creationTime.toIso8601String(),
        "isRead": isRead,
        "id": id == null ? null : id,
      };

  @override
  MessageEntity toEntity() {
    return MessageEntity(
        text: text,
        isRead: isRead,
        creationTime: creationTime.toLocal(),
        id: id,
        groupId: groupId,
        conversationId: conversationId,
        senderId: senderId,
        conversation: conversation?.toEntity(),
        group: group?.toEntity());
  }
}
