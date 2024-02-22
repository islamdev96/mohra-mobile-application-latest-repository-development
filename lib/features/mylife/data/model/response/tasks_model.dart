import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/mylife/domain/entity/task_entity.dart';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';

class TaskModel extends BaseModel<TaskEntity> {
  final List<TaskItem> items;
  final int achievedTasksCount;
  final int totalTasksCount;

  TaskModel(
      {required this.items,
      required this.totalTasksCount,
      required this.achievedTasksCount});

  factory TaskModel.fromMap(Map<String, dynamic> json) => TaskModel(
        items: json["items"] == null
            ? []
            : List<TaskItem>.from(
                json["items"].map((x) => TaskItem.fromMap(x))),
        totalTasksCount: json['totalTasksCount'],
        achievedTasksCount: json['achievedTasksCount'],
      );

  @override
  TaskEntity toEntity() {
    return TaskEntity(
      items: items.toListEntity(),
      totalTasksCount: totalTasksCount,
      achievedTasksCount: achievedTasksCount,
    );
  }
}

class TaskItem extends BaseModel<TaskItemEntity> {
  String? title;
  String? date;
  int? clientId;
  int? priority;
  bool isAchieved;
  int? id;

  TaskItem(
      {this.title,
      this.date,

      this.clientId,
      this.priority,
      required this.isAchieved,
      this.id});

  factory TaskItem.fromMap(Map<String, dynamic> json) => TaskItem(
      id: json['id'],
      title: json['title'],
      date: json['date'],
      clientId: json['clientId'],
      isAchieved: json['isAchieved'],
      priority: json['priority'],

  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['date'] = this.date;
    data['clientId'] = this.clientId;
    data['priority'] = this.priority;
    data['isAchieved'] = this.isAchieved;
    data['id'] = this.id;
    return data;
  }

  @override
  TaskItemEntity toEntity() {
    return TaskItemEntity(
        id: id,
        title: title,
        priority: priority,
        isAchieved: isAchieved,
        clientId: clientId,
        date: date);
  }
}

