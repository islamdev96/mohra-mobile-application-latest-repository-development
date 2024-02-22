// To parse this JSON data, do
//
//     final groupMessageNotificationEntity = groupMessageNotificationEntityFromMap(jsonString);

import 'dart:convert';

import 'package:starter_application/core/common/type_validators.dart';

GroupMessageNotificationEntity groupMessageNotificationEntityFromMap(
        String str) =>
    GroupMessageNotificationEntity.fromMap(json.decode(str));

String groupMessageNotificationEntityToMap(
        GroupMessageNotificationEntity data) =>
    json.encode(data.toMap());

class GroupMessageNotificationEntity {
  GroupMessageNotificationEntity({
    this.notificationType,
    this.groupId,
    this.senderId,
    required this.senderFullName,
    required this.senderImageUrl,
    required this.message,
    required this.groupName,
    required this.groupImage,
    this.receiverType,
    required this.arMessage,
    required this.enMessage,
  });

  final int? notificationType;
  final int? groupId;
  final int? senderId;
  final String senderFullName;
  final String senderImageUrl;
  final String message;
  final String groupName;
  final String groupImage;
  final int? receiverType;
  final String arMessage;
  final String enMessage;

  factory GroupMessageNotificationEntity.fromMap(Map<String, dynamic> json) =>
      GroupMessageNotificationEntity(
        notificationType:
            json["NotificationType"] == null ? null : json["NotificationType"],
        groupId: json["GroupId"] == null ? null : json["GroupId"],
        senderId: json["SenderId"] == null ? null : json["SenderId"],
        senderFullName: stringV(json["SenderFullName"]),
        senderImageUrl: stringV(json["SenderImageUrl"]),
        message: stringV(json["Message"]),
        groupName: stringV(json["GroupName"]),
        groupImage: stringV(json["GroupImage"]),
        receiverType:
            json["ReceiverType"] == null ? null : json["ReceiverType"],
        arMessage: stringV(json["ArMessage"]),
        enMessage: stringV(json["EnMessage"]),
      );

  Map<String, dynamic> toMap() => {
        "NotificationType": notificationType == null ? null : notificationType,
        "GroupId": groupId == null ? null : groupId,
        "SenderId": senderId == null ? null : senderId,
        "SenderFullName": senderFullName,
        "SenderImageUrl": senderImageUrl,
        "Message": message,
        "GroupName": groupName,
        "GroupImage": groupImage,
        "ReceiverType": receiverType == null ? null : receiverType,
        "ArMessage": arMessage,
        "EnMessage": enMessage,
      };
}
