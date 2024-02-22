import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/event/domain/entity/event_ticket_entity.dart';

class CreateEventTicketEntity extends BaseEntity {
  CreateEventTicketEntity({
    required this.tickets,
  });

  final List<EventTicketEntity> tickets;

  @override
  List<Object?> get props => [];
}
