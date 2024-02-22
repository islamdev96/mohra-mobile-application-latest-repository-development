// To parse this JSON data, do
//
//     final contactUsParams = contactUsParamsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:starter_application/core/params/base_params.dart';

class ContactUsParams extends BaseParams {
  ContactUsParams({
    required this.textTicket,
    required this.replyTiket,
    required this.status,
    required this.connectUsTicketTypeId,
    required this.closingDate,
    required this.userId,
  });

  final String textTicket;
  final String replyTiket;
  final int status;
  final int connectUsTicketTypeId;
  final DateTime closingDate;
  final int userId;

  factory ContactUsParams.fromMap(Map<String, dynamic> json) => ContactUsParams(
    textTicket: json["textTicket"],
    replyTiket: json["replyTiket"],
    status: json["status"],
    connectUsTicketTypeId: json["connectUsTicketTypeId"],
    closingDate: json["closingDate"],
    userId: json["userId"],
  );

  Map<String, dynamic> toMap() => {
    "textTicket": textTicket,
    "replyTiket": replyTiket,
    "status": status,
    "connectUsTicketTypeId": connectUsTicketTypeId,
    "closingDate": closingDate,
    "userId": userId,
  };
}
