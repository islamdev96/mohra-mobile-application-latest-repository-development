import 'package:starter_application/core/entities/base_entity.dart';

class TaskEntity extends BaseEntity {
  final List<TaskItemEntity>? items;
  final int? achievedTasksCount;
  final int? totalTasksCount;

  TaskEntity({this.items, this.achievedTasksCount, this.totalTasksCount});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TaskItemEntity extends BaseEntity {
  TaskItemEntity(
      {this.title,
      this.id,
      this.priority,
      this.date,
      this.clientId,
      required this.isAchieved,
        this.isSelected=false,});

  final String? title;
  final String? date;
  final int? clientId;
  final int? priority;
   bool isAchieved;
  final int? id;
   bool isSelected;

  @override
  List<Object?> get props => [];
}

