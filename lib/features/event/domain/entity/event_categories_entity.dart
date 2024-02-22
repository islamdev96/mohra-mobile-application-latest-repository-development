import 'package:starter_application/core/entities/base_entity.dart';

import 'event_category_entity.dart';

class EventCategoriesEntity extends BaseEntity {
  EventCategoriesEntity({
    this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<EventCategoryEntity> items;

  @override
  List<Object?> get props => [];
}
