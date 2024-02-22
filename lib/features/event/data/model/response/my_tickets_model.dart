import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/event/data/model/response/event_model.dart';
import 'package:starter_application/features/event/data/model/response/event_ticket_model.dart';
import 'package:starter_application/features/event/domain/entity/my_tickets_entity.dart';

class MyTicketsModel extends BaseModel<MyTicketsEntity> {
  MyTicketsModel({
    this.eventId,
    this.event,
    this.date,
    this.price,
    required this.bookingId,
    required this.tickets,
  });

  final int? eventId;
  final EventModel? event;
  final DateTime? date;
  final String bookingId;
  final double? price;
  final List<EventTicketModel> tickets;

  factory MyTicketsModel.fromMap(Map<String, dynamic> json) {
    return MyTicketsModel(
      eventId: json["eventId"] == null ? null : json["eventId"],
      event: json["event"] == null ? null : EventModel.fromMap(json["event"]),
      date: json["date"] == null ? null : DateTime.parse(json["date"]),
      bookingId: stringV(json["bookingId"]),
      price: numV(json["price"]),
      tickets: json["tickets"] == null
          ? []
          : List<EventTicketModel>.from(
          json["tickets"].map((x) => EventTicketModel.fromMap(x))),
    );
  }

  Map<String, dynamic> toMap() => {
        "eventId": eventId == null ? null : eventId,
        "event": event == null ? null : event!.toMap(),
        "date": date == null ? null : date!.toIso8601String(),
        "bookingId": bookingId,
        "tickets": List<dynamic>.from(tickets.map((x) => x.toMap())),
      };

  @override
  MyTicketsEntity toEntity() {
    return MyTicketsEntity(
        bookingId: bookingId,
        tickets: tickets.map((e) => e.toEntity()).toList(),
        date: date,
        price: price,
        eventId: eventId,
        event: event?.toEntity());
  }
}
