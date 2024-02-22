import 'package:starter_application/core/entities/base_entity.dart';

import 'event_entity.dart';

class EventsEntity extends BaseEntity {
  EventsEntity({
    this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<EventEntity> items;

  @override
  List<Object?> get props => [];
}
