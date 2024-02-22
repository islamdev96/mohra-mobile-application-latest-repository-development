import 'package:starter_application/core/entities/base_entity.dart';

import 'event_entity.dart';
import 'event_ticket_entity.dart';

class MyTicketsEntity extends BaseEntity {
  MyTicketsEntity({
    this.eventId,
    this.event,
    this.date,
    this.price,
    required this.bookingId,
    required this.tickets,
  });

  final int? eventId;
  final EventEntity? event;
  final DateTime? date;
  final String bookingId;
  final double? price;
  final List<EventTicketEntity> tickets;

  @override
  List<Object?> get props => [];
}
