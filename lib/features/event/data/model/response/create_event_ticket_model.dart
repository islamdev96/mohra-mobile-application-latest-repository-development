import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/event/data/model/response/event_ticket_model.dart';
import 'package:starter_application/features/event/domain/entity/create_event_ticket_entity.dart';

class CreateEventTicketModel extends BaseModel<CreateEventTicketEntity> {
  CreateEventTicketModel({
    required this.tickets,
  });

  final List<EventTicketModel> tickets;

  factory CreateEventTicketModel.fromMap(Map<String, dynamic> json) =>
      CreateEventTicketModel(
        tickets: json["tickets"] == null
            ? []
            : List<EventTicketModel>.from(
                json["tickets"].map((x) => EventTicketModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "tickets": List<dynamic>.from(tickets.map((x) => x.toMap())),
      };

  @override
  CreateEventTicketEntity toEntity() {
    return CreateEventTicketEntity(
        tickets: tickets.map((e) => e.toEntity()).toList());
  }
}
