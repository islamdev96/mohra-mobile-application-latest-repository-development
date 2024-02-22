// To parse this JSON data, do
//
//     final groupMessageNotificationEntity = groupMessageNotificationEntityFromMap(jsonString);

import 'dart:convert';

import 'package:starter_application/core/common/type_validators.dart';

ReceivingFriendRequestEntity otherTypeNotificationEntityFromMap(
    String str) =>
    ReceivingFriendRequestEntity.fromMap(json.decode(str));


class ReceivingFriendRequestEntity {
  ReceivingFriendRequestEntity({
    required this.notificationType,
    required this.ArMessage,
    required this.EnMessage,
    required this.FriendRequestId,
    required this.ReceiverId,
    required this.SenderFullName,
    required this.SenderId,
    required this.SenderImageUrl,
    this.receiverType,

  });

  final int notificationType;
  final int? receiverType;
  final int FriendRequestId;
  final int SenderId;
  final int ReceiverId;
  final String SenderImageUrl;
  final String SenderFullName;
  final String ArMessage;
  final String EnMessage;

  factory ReceivingFriendRequestEntity.fromMap(Map<String, dynamic> json) =>
      ReceivingFriendRequestEntity(
        notificationType: json["NotificationType"] != null ? int.parse(json["NotificationType"]): 10,
        receiverType: json["ReceiverType"] != null ? int.parse(json["NotificationType"]) : 0,
        FriendRequestId: json["FriendRequestId"],
        SenderId: json["SenderId"],
        ReceiverId: json["ReceiverId"],
        SenderImageUrl: stringV(json["SenderImageUrl"]),
        SenderFullName: stringV(json["SenderFullName"]),
        ArMessage: stringV(json["ArMessage"]),
        EnMessage:  stringV(json["EnMessage"]),
      );

}
