import 'package:starter_application/core/params/base_params.dart';

class ReadMessagesParams extends BaseParams {
  ReadMessagesParams({
    this.conversationId,
    this.groupId,
  });

  final int? conversationId;
  final int? groupId;

  factory ReadMessagesParams.fromMap(Map<String, dynamic> json) =>
      ReadMessagesParams(
        conversationId:
            json["conversationId"] == null ? null : json["conversationId"],
        groupId: json["groupId"] == null ? null : json["groupId"],
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (conversationId != null) map['conversationId'] = conversationId;
    if (groupId != null) map['groupId'] = groupId;
    return map;
  }
}
