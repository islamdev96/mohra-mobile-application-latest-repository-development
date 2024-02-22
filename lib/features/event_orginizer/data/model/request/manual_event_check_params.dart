// To parse this JSON data, do
//
//     final manualCheckEventParams = manualCheckEventParamsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:starter_application/core/params/base_params.dart';

ManualCheckEventParams manualCheckEventParamsFromJson(String str) => ManualCheckEventParams.fromJson(json.decode(str));

String manualCheckEventParamsToJson(ManualCheckEventParams data) => json.encode(data.toJson());

class ManualCheckEventParams extends BaseParams {
  ManualCheckEventParams({
    required this.eventId,
    required this.ticketNumber,
    required this.isScanned,
  });

  final int eventId;
  final String ticketNumber;
  final bool isScanned;

  factory ManualCheckEventParams.fromJson(Map<String, dynamic> json) => ManualCheckEventParams(
    eventId: json["eventId"],
    ticketNumber: json["ticketNumber"],
    isScanned: json["isScanned"],
  );

  Map<String, dynamic> toJson() => {
    "eventId": eventId,
    "ticketNumber": ticketNumber,
    "isScanned": isScanned,
  };

  @override
  Map<String, dynamic> toMap() {
   return{
     "eventId": eventId,
     "ticketNumber": ticketNumber,
     "isScanned": isScanned,
   };
  }
}
