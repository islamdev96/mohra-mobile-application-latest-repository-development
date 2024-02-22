import 'package:starter_application/features/event/domain/entity/create_event_ticket_entity.dart';
import 'package:starter_application/features/event/domain/entity/my_tickets_entity.dart';

class TicketDetailsScreenParams {
  CreateEventTicketEntity? createEventTicketEntity;
  MyTicketsEntity? myTicketsEntity;
  int? id;
  TicketDetailsScreenParams(
      {this.createEventTicketEntity, this.id, this.myTicketsEntity});
}
