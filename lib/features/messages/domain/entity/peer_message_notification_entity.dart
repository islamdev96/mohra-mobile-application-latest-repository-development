// To parse this JSON data, do

import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/entities/base_entity.dart';

class PeerMessageNotificationEntity extends BaseEntity {
  PeerMessageNotificationEntity({
    this.notificationType,
    this.conversationId,
    this.senderId,
    required this.senderFullName,
    required this.senderImageUrl,
    required this.message,
    this.receiverId,
    this.receiverType,
    required this.arMessage,
    required this.enMessage,
  });

  final int? notificationType;
  final int? conversationId;
  final int? senderId;
  final String senderFullName;
  final String? senderImageUrl;
  final String message;
  final int? receiverId;
  final int? receiverType;
  final String arMessage;
  final String enMessage;

  factory PeerMessageNotificationEntity.fromMap(Map<String, dynamic> json) =>
      PeerMessageNotificationEntity(
        notificationType:
            json["NotificationType"] == null ? null : int.parse(json['NotificationType']),
        conversationId:
            json["ConversationId"] == null ? null : int.parse(json["ConversationId"]),
        senderId: json["SenderId"] == null ? null :int.parse(json["SenderId"]),
        senderFullName: stringV(json["SenderFullName"]),
        senderImageUrl: json["SenderImageUrl"],
        message: stringV(json["Message"]),
        receiverId: json["ReceiverId"] == null ? null : int.parse(json["ReceiverId"]),
        receiverType:
            json["ReceiverType"] == null ? null :int.parse(json["ReceiverType"]),
        arMessage: stringV(json["ArMessage"]),
        enMessage: stringV(json["EnMessage"]),
      );

  Map<String, dynamic> toMap() => {
        "NotificationType": notificationType == null ? null : notificationType,
        "ConversationId": conversationId == null ? null : conversationId,
        "SenderId": senderId == null ? null : senderId,
        "SenderFullName": senderFullName,
        "SenderImageUrl": senderImageUrl,
        "Message": message,
        "ReceiverId": receiverId == null ? null : receiverId,
        "ReceiverType": receiverType == null ? null : receiverType,
        "ArMessage": arMessage,
        "EnMessage": enMessage,
      };

  @override
  List<Object?> get props => [];
}
