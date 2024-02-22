class CallNotificationModel {
  CallNotificationModel({
    required this.withVideo,
    required this.token,
    required this.channel,
    required this.name,
    required this.isGroup,
  });

  final bool withVideo;
  final String token;
  final String channel;
  final String name;
  final bool isGroup;

  factory CallNotificationModel.fromMap(Map<String, dynamic> json) =>
      CallNotificationModel(
        withVideo: json["with_video"] == null ? false : json["with_video"],
        token: json["token"] == null ? false : json["token"],
        channel: json["channel"] == null ? false : json["channel"],
        name: json["name"] == null ? false : json["name"],
        isGroup: json["isGroup"] == null ? false : json["isGroup"],
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> json = {};
    json["with_video"] = withVideo;
    json["token"] = token;
    json["channel"] = channel;
    json["name"] = name;
    json["isGroup"] = isGroup;
    return json;
  }
}
