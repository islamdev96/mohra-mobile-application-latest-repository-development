import 'package:starter_application/core/entities/base_entity.dart';

class MyRunningEventsListEntity extends BaseEntity {
  final int? totalCount;
  final List<MyRunningEventEntity> items;
  MyRunningEventsListEntity({
    required this.totalCount,
    required this.items,
  });

  @override
  List<Object?> get props => [totalCount, items];
}

class MyRunningEventEntity extends BaseEntity {
  final String? value;
  final String? text;
  MyRunningEventEntity({
    required this.value,
    required this.text,
  });

  @override
  List<Object?> get props => [value, text];
}
