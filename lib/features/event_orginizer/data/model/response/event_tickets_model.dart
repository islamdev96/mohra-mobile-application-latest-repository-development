// To parse this JSON data, do
//
//     final eventTickets = eventTicketsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/event/data/model/response/event_client_model.dart';
import 'package:starter_application/features/event/domain/entity/event_ticket_entity.dart';
import 'package:starter_application/features/event/domain/entity/event_tickets_entity.dart';
import '../../../domain/entity/event_tickets_entity.dart';
import '/core/common/extensions/base_model_list_extension.dart';

EventTicketsss eventTicketsFromJson(String str) => EventTicketsss.fromJson(json.decode(str));

String eventTicketsToJson(EventTicketsss data) => json.encode(data.toJson());


class EventTicketsss extends BaseModel<EventTicketssEntity>{
  EventTicketsss({
    required this.totalCount,
    required this.items,
  });

  final int totalCount;
  final List<EventTickettModel> items;

  factory EventTicketsss.fromJson(Map<String, dynamic> json) => EventTicketsss(
    totalCount: json["totalCount"],
    items: List<EventTickettModel>.from(json["items"].map((x) => EventTickettModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };

  @override
  EventTicketssEntity toEntity() {
    return EventTicketssEntity(totalCount: totalCount, items: items.toListEntity());
  }


}

class EventTickettModel extends BaseModel<EventTickettEntity>{
  EventTickettModel({
    required this.number,
    required this.name,
    required this.phoneNumber,
    required this.emailAddress,
    required this.clientId,
     this.client,
    required this.clientName,
    required this.clientSurname,
    required this.clientImage,
    required this.eventId,
    required this.type,
    required this.date,
    required this.bookingId,
    required this.qrCode,
    required this.scanned,
    required this.price,
    required this.id,
  });

  final String number;
  final String name;
  final String phoneNumber;
  final String emailAddress;
  final int clientId;
  final EventClientModel? client;
  final String clientName;
  final String clientSurname;
  final String clientImage;
  final int eventId;
  final int type;
  final DateTime date;
  final String bookingId;
  final String qrCode;
  final bool scanned;
  final double price;
  final int id;

  factory EventTickettModel.fromJson(Map<String, dynamic> json) => EventTickettModel(
    number: json["number"]??"",
    name: json["name"]??"",
    phoneNumber: json["phoneNumber"]??"",
    emailAddress: json["emailAddress"]??"",
    clientId: json["clientId"]??0,
    client:json["client"] != null ? EventClientModel.fromMap(json["client"]) : null,
    clientName: json["clientName"]??"",
    clientSurname: json["clientSurname"]??"",
    clientImage: json["clientImage"]??"",
    eventId: json["eventId"]??0,
    type: json["type"]??-1,
    date: DateTime.parse(json["date"]),
    bookingId: json["bookingId"]??0,
    qrCode: json["qrCode"]??"",
    scanned: json["scanned"]??false,
    price: json["price"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "name": name,
    "phoneNumber": phoneNumber,
    "emailAddress": emailAddress,
    "clientId": clientId,
    "clientName": clientName,
    "clientSurname": clientSurname,
    "clientImage": clientImage,
    "eventId": eventId,
    "type": type,
    "date": date.toIso8601String(),
    "bookingId": bookingId,
    "qrCode": qrCode,
    "scanned": scanned,
    "price": price,
    "id": id,
  };

  @override
  EventTickettEntity toEntity() {
    return EventTickettEntity(client: client != null ? client!.toEntity() : null,number: number, name: name, phoneNumber: phoneNumber, emailAddress: emailAddress, clientId: clientId, clientName: clientName, clientSurname: clientSurname, clientImage: clientImage, eventId: eventId, type: type, date: date, bookingId: bookingId, qrCode: qrCode, scanned: scanned, id: id, price: price);
  }


}
