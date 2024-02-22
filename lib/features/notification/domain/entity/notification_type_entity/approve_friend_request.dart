// To parse this JSON data, do
//
//     final groupMessageNotificationEntity = groupMessageNotificationEntityFromMap(jsonString);

import 'dart:convert';

import 'package:starter_application/core/common/type_validators.dart';

ApproveFriendRequestEntity otherTypeNotificationEntityFromMap(
    String str) =>
    ApproveFriendRequestEntity.fromMap(json.decode(str));


class ApproveFriendRequestEntity {
  ApproveFriendRequestEntity({
    required this.notificationType,
    required this.ArMessage,
    required this.EnMessage,
    required this.FriendRequestId,
    required this.ReceiverId,
    required this.SenderFullName,
    required this.SenderId,
    required this.SenderImageUrl,
    required this.ReceiverImageUrl,
    this.receiverType,

  });

  final int notificationType;
  final int? receiverType;
  final int FriendRequestId;
  final int SenderId;
  final int ReceiverId;
  final String SenderImageUrl;
  final String ReceiverImageUrl;
  final String SenderFullName;
  final String ArMessage;
  final String EnMessage;

  factory ApproveFriendRequestEntity.fromMap(Map<String, dynamic> json) =>
      ApproveFriendRequestEntity(
        notificationType: json["NotificationType"] != null ? int.parse(json["NotificationType"]): 10,
        receiverType: json["ReceiverType"] != null ? int.parse(json["NotificationType"]) : 0,
        FriendRequestId: json["FriendRequestId"],
        SenderId: json["SenderId"],
        ReceiverId: json["ReceiverId"],
        SenderImageUrl: stringV(json["SenderImageUrl"]),
        ReceiverImageUrl: stringV(json["ReceiverImageUrl"]),
        SenderFullName: stringV(json["SenderFullName"]),
        ArMessage: stringV(json["ArMessage"]),
        EnMessage:  stringV(json["EnMessage"]),
      );

}
