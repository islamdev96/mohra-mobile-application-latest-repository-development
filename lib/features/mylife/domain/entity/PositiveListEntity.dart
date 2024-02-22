import 'package:starter_application/core/entities/base_entity.dart';

class PositiveListEntity extends BaseEntity{
  PositiveListEntity({
    required this.todayHabitsCount,
    required this.totalHabitsCount,
    required this.totalCount,
    required this.items,
  });

  int todayHabitsCount;
  int totalHabitsCount;
  int totalCount;
  List<PositiveEntity> items;

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PositiveEntity extends BaseEntity{
  PositiveEntity({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.clientId,
    required this.date,
    required this.id
  });

  String title;
  String description;
  String imageUrl;
  int clientId;
  DateTime date;
  int id;

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
