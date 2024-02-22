import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/params/base_params.dart';

class CreateMessageParams extends BaseParams {
  CreateMessageParams({
    this.receiverId,
    this.groupId,
    required this.channel,
    required this.text,
  });

  final int? receiverId;
  final int? groupId;
  final String? channel;
  final String? text;

  factory CreateMessageParams.fromMap(Map<String, dynamic> json) =>
      CreateMessageParams(
        receiverId: json["receiverId"] == null ? null : json["receiverId"],
        groupId: json["groupId"] == null ? null : json["groupId"],
        channel: stringV(json["channel"]),
        text: stringV(json["text"]),
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (receiverId != null) map['receiverId'] = receiverId;
    if (groupId != null) map['groupId'] = groupId;
    if (channel != null) map['channel'] = channel;
    if (text != null) map['text'] = text;
    return map;
  }
}
