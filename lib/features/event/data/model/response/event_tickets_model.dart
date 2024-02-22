import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/event/domain/entity/event_tickets_entity.dart';

import 'my_tickets_model.dart';

class EventTicketsModel extends BaseModel<EventTicketsEntity> {
  EventTicketsModel({
    this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<MyTicketsModel> items;

  factory EventTicketsModel.fromMap(Map<String, dynamic> json) =>
      EventTicketsModel(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        items: json["items"] == null
            ? []
            : List<MyTicketsModel>.from(
                json["items"].map((x) => MyTicketsModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount == null ? null : totalCount,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };

  @override
  EventTicketsEntity toEntity() {
    return EventTicketsEntity(items: items.map((e) => e.toEntity()).toList());
  }
}
