// To parse this JSON data, do
//
//     final eventTickets = eventTicketsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/event/domain/entity/event_client_entity.dart';



class EventTicketssEntity extends BaseEntity {
  EventTicketssEntity({
    required this.totalCount,
    required this.items,
  });

  final int totalCount;
  final List<EventTickettEntity> items;

  factory EventTicketssEntity.fromJson(Map<String, dynamic> json) => EventTicketssEntity(
    totalCount: json["totalCount"],
    items: List<EventTickettEntity>.from(json["items"].map((x) => EventTickettEntity.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EventTickettEntity extends BaseEntity {
  EventTickettEntity({
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
  final EventClientEntity? client;
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

  factory EventTickettEntity.fromJson(Map<String, dynamic> json) => EventTickettEntity(
    number: json["number"],
    name: json["name"],
    phoneNumber: json["phoneNumber"],
    emailAddress: json["emailAddress"],
    clientId: json["clientId"],
    clientName: json["clientName"],
    clientSurname: json["clientSurname"],
    clientImage: json["clientImage"],
    eventId: json["eventId"],
    type: json["type"],
    date: DateTime.parse(json["date"]),
    bookingId: json["bookingId"],
    qrCode: json["qrCode"],
    scanned: json["scanned"],
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
  // TODO: implement props
  List<Object?> get props => [];
}
