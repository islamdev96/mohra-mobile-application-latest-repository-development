// To parse this JSON data, do
//
//     final groupMessageNotificationEntity = groupMessageNotificationEntityFromMap(jsonString);

import 'dart:convert';

import 'package:starter_application/core/common/type_validators.dart';

OtherTypeNotificationEntity otherTypeNotificationEntityFromMap(
    String str) =>
    OtherTypeNotificationEntity.fromMap(json.decode(str));


class OtherTypeNotificationEntity {
  OtherTypeNotificationEntity({
    required this.notificationType,
    this.receiverType,
    required this.arMessage,
    required this.enMessage,
    required this.arContent,
    required this.enContent,
  });

  final int notificationType;
  final int? receiverType;
  final String arMessage;
  final String enMessage;
  final String enContent;
  final String arContent;

  factory OtherTypeNotificationEntity.fromMap(Map<String, dynamic> json) =>
      OtherTypeNotificationEntity(
        notificationType: json["NotificationType"] != null ? int.parse(json["NotificationType"]): 10,
        receiverType: json["ReceiverType"] != null ? int.parse(json["NotificationType"]) : 0,
        arMessage: stringV(json["ArMessage"]),
        enMessage: stringV(json["EnMessage"]),
        arContent: stringV(json["EnContent"]),
        enContent:  stringV(json["ArContent"]),
      );

}
