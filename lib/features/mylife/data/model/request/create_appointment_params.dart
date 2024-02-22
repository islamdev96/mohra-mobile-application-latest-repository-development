import 'package:starter_application/core/params/base_params.dart';

class CreateAppointmentRequest extends BaseParams {
  String title;
  String note;
  String startDate;
  String endDate;
  String fromHour;
  String toHour;
  int priority;
  int repeat;
  int reminder;
  List<int> clients;
  bool isAllDays;

  CreateAppointmentRequest(
      {required this.title,
      required this.startDate,
      required this.endDate,
      required this.toHour,
      required this.fromHour,
      required this.reminder,
      required this.repeat,
      required this.clients,
      required this.isAllDays,
      required this.note,
      required this.priority});

  @override
  Map<String, dynamic> toMap() => {
        "title": title,
        "note": note,
        "startDate": startDate,
        "endDate": endDate,
        "fromHour": fromHour,
        "toHour": toHour,
        "priority": priority,
        "repeat": repeat,
        "reminder": reminder,
        "clients": clients,
        "allDays": isAllDays
      };

  @override
  String toString() {
    return 'CreateAppointmentRequest{title: $title, note: $note, startDate: $startDate, endDate: $endDate, fromHour: $fromHour, toHour: $toHour, priority: $priority, repeat: $repeat, reminder: $reminder, clients: $clients, isAllDays: $isAllDays}';
  }
}
