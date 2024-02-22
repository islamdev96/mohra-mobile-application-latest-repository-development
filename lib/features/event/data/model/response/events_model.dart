import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/event/data/model/response/event_model.dart';
import 'package:starter_application/features/event/domain/entity/events_entity.dart';

class EventsModel extends BaseModel<EventsEntity> {
  EventsModel({
    this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<EventModel> items;

  factory EventsModel.fromMap(Map<String, dynamic> json) => EventsModel(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        items: json["items"] == null
            ? []
            : List<EventModel>.from(
                json["items"].map((x) => EventModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount == null ? null : totalCount,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };

  @override
  EventsEntity toEntity() {
    return EventsEntity(
      totalCount: totalCount,
      items: items.toListEntity(),
    );
  }
}
