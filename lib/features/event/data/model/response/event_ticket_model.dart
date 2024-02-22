import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/event/domain/entity/event_ticket_entity.dart';

import 'event_client_model.dart';
import 'event_model.dart';

class EventTicketModel extends BaseModel<EventTicketEntity> {
  EventTicketModel({
    required this.number,
    required this.name,
    required this.phoneNumber,
    required this.emailAddress,
    this.clientId,
    this.client,
    this.eventId,
    this.event,
    this.type,
    this.date,
    this.price,
    required this.bookingId,
    required this.qrCode,
    this.id,
    required this.scanned,
  });

  final String number;
  final String name;
  final String phoneNumber;
  final String emailAddress;
  final int? clientId;
  final EventClientModel? client;
  final int? eventId;
  final EventModel? event;
  final int? type;
  final double? price;
  final DateTime? date;
  final String bookingId;
  final String qrCode;
  final int? id;
  final bool scanned;

  factory EventTicketModel.fromMap(Map<String, dynamic> json) =>
      EventTicketModel(
        number: stringV(json["number"]),
        name: stringV(json["name"]),
        phoneNumber: stringV(json["phoneNumber"]),
        emailAddress:
            json["emailAddress"] == null ? null : json["emailAddress"],
        clientId: json["clientId"] == null ? null : json["clientId"],
        client: json["client"] == null
            ? null
            : EventClientModel.fromMap(json["client"]),
        eventId: json["eventId"] == null ? null : json["eventId"],
        event: json["event"] == null ? null : EventModel.fromMap(json["event"]),
        type: json["type"] == null ? null : json["type"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        bookingId: stringV(json["bookingId"]),
        price: numV(json["price"]),
        qrCode: stringV(json["qrCode"]),
        id: json["id"] == null ? null : json["id"],
        scanned: boolV(json["scanned"]),
      );

  Map<String, dynamic> toMap() => {
        "number": number,
        "name": name,
        "phoneNumber": phoneNumber,
        "emailAddress": emailAddress,
        "clientId": clientId == null ? null : clientId,
        "client": client == null ? null : client!.toMap(),
        "eventId": eventId == null ? null : eventId,
        "event": event == null ? null : event!.toMap(),
        "type": type == null ? null : type,
        "date": date == null ? null : date!.toIso8601String(),
        "bookingId": bookingId,
        "qrCode": qrCode,
        "id": id == null ? null : id,
        "scanned": scanned == null ? null : scanned,
      };

  @override
  EventTicketEntity toEntity() {
    return EventTicketEntity(
      number: number,
      name: name,
      phoneNumber: phoneNumber,
      emailAddress: emailAddress,
      bookingId: bookingId,
      qrCode: qrCode,
      id: id,
      clientId: clientId,
      type: type,
      date: date,
      client: client?.toEntity(),
      eventId: eventId,
      event: event?.toEntity(),
      scanned: scanned,
      price: price,
    );
  }
}
