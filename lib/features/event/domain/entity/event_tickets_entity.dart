import 'package:starter_application/core/entities/base_entity.dart';

import 'my_tickets_entity.dart';

class EventTicketsEntity extends BaseEntity {
  EventTicketsEntity({
    this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<MyTicketsEntity> items;

  @override
  List<Object?> get props => [];
}
