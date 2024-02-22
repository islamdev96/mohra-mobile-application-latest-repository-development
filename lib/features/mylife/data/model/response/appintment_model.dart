import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/mylife/domain/entity/appointment_entity.dart';
import 'package:starter_application/features/mylife/domain/entity/task_entity.dart';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';

class AppointmentModel extends BaseModel<AppointmentEntity> {
  final List<AppointmentItem> items;
  final int doneAppointmentsCount;
  final int totalAppointmentsCount;
  final int totalCount;

  AppointmentModel(
      {required this.items,
      required this.totalCount,
      required this.doneAppointmentsCount,
      required this.totalAppointmentsCount});

  factory AppointmentModel.fromMap(Map<String, dynamic> json) =>
      AppointmentModel(
        items: json["items"] == null
            ? []
            : List<AppointmentItem>.from(
                json["items"].map((x) => AppointmentItem.fromMap(x))),
        doneAppointmentsCount: json['doneAppointmentsCount'],
        totalAppointmentsCount: json['totalAppointmentsCount'],
        totalCount: json['totalCount'],
      );

  @override
  AppointmentEntity toEntity() {
    return AppointmentEntity(
      items: items.toListEntity(),
      totalCount: totalCount,
      doneAppointmentsCount: doneAppointmentsCount,
      totalAppointmentsCount: totalAppointmentsCount,
    );
  }
}

class AppointmentItem extends BaseModel<AppointmentItemEntity> {
  String? title;
  String? note;
  String? startDate;
  String? endDate;
  String? fromHour;
  String? toHour;
  int? priority;
  int? repeat;
  int? reminder;
  int? clientId;
  int? creatorUserId;
  String? createdBy;
  String? creationTime;
  bool? isDone;
  int? id;

  AppointmentItem(
      {this.title,
      this.note,
      this.startDate,
      this.endDate,
      this.fromHour,
      this.toHour,
      this.priority,
      this.repeat,
      this.reminder,
      this.clientId,
      this.creatorUserId,
      this.createdBy,
      this.creationTime,
      this.isDone,
      this.id});

  factory AppointmentItem.fromMap(Map<String, dynamic> json) => AppointmentItem(
        id: json['id'],
        title: json['title'],
        note: json['note'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        fromHour: json['fromHour'],
        toHour: json['toHour'],
        priority: json['priority'],
        repeat: json['repeat'],
        reminder: json['reminder'],
        clientId: json['clientId'],
        creatorUserId: json['creatorUserId'],
        createdBy: json['createdBy'],
        creationTime: json['creationTime'],
        isDone: json['isDone'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['note'] = this.note;
    data['date'] = this.startDate;
    data['fromHour'] = this.fromHour;
    data['toHour'] = this.toHour;
    data['priority'] = this.priority;
    data['repeat'] = this.repeat;
    data['reminder'] = this.reminder;
    data['clientId'] = this.clientId;
    data['creatorUserId'] = this.creatorUserId;
    data['createdBy'] = this.createdBy;
    data['creationTime'] = this.creationTime;
    data['isDone'] = this.isDone;
    data['id'] = this.id;
    return data;
  }

  @override
  AppointmentItemEntity toEntity() {
    return AppointmentItemEntity(
        id: id,
        startDate: startDate,
        endDate: endDate ,
        clientId: clientId,
        fromHour: fromHour,
        toHour: toHour,
        priority: priority,
        title: title,
        creationTime: creationTime,
        isDone: isDone,
        reminder: reminder,
        repeat: repeat,
        note: note,
        creatorUserId: creatorUserId);
  }
}
