import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/event/domain/entity/event_categories_entity.dart';

import 'event_category_model.dart';

class EventCategoriesModel extends BaseModel<EventCategoriesEntity> {
  EventCategoriesModel({
    this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<EventCategoryModel> items;

  factory EventCategoriesModel.fromMap(Map<String, dynamic> json) =>
      EventCategoriesModel(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        items: json["items"] == null
            ? []
            : List<EventCategoryModel>.from(
                json["items"].map((x) => EventCategoryModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount == null ? null : totalCount,
        "items": items,
      };

  @override
  EventCategoriesEntity toEntity() {
    return EventCategoriesEntity(items: items.toListEntity());
  }
}
