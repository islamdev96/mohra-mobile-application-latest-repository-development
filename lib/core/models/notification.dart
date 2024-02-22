import 'package:starter_application/core/constants/enums/notification_type.dart';

class Notifications {
  String? id;
  String? notificationName;
  NotificationType? type;
  String? message;
  String? dateTime;
  int? relatedId;

  Notifications(
      {this.id,
        this.notificationName,
        this.type,
        this.message,
        this.dateTime,
        this.relatedId});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notificationName = json['notificationName'];
    if(json['type'] != null)
    type = NotificationType.values[json['type']];
    message = json['message'];
    dateTime = json['dateTime'];
    relatedId = json['relatedId'];
  }
  Notifications.fromFCM(Map<String, dynamic> json) {
    type = NotificationType.values[ int.parse(json['type'] ) ];
    relatedId = int.parse(json['relatedId']);
    dateTime = json['time'];
  }

}
