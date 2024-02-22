class MainNotificationModel {
  MainNotificationModel({
    required this.type,
    this.payload,
  });

  final String type;
  final Map<String, dynamic>? payload;

  factory MainNotificationModel.fromMap(Map<String, dynamic> json) =>
      MainNotificationModel(
        type: json["type"] == null ? null : json["type"],
        payload: json["payload"] == null ? null : json["payload"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "payload": payload == null ? null : payload,
      };
}
