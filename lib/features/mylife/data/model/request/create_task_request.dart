import 'package:starter_application/core/params/base_params.dart';

class CreateTaskRequest extends BaseParams {
  String title;
  String date;
  String fromHour;
  String toHour;
  int priority;

  CreateTaskRequest(
      {required this.title,
      required this.date,
      required this.toHour,
      required this.fromHour,
      required this.priority});

  @override
  Map<String, dynamic> toMap() => {
        "title": title,
        "date": date,
        "priority": priority,
      };
}
