import 'package:starter_application/core/entities/base_entity.dart';

class AppointmentEntity extends BaseEntity {
  final List<AppointmentItemEntity>? items;
  final int? doneAppointmentsCount;
  final int? totalAppointmentsCount;
  final int? totalCount;

  AppointmentEntity(
      {this.items,
      this.totalCount,
      this.doneAppointmentsCount,
      this.totalAppointmentsCount});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AppointmentItemEntity extends BaseEntity {
  AppointmentItemEntity(
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
        this.isSelected=false,
      this.id});

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
  bool isSelected;
  @override
  List<Object?> get props => [];
}
