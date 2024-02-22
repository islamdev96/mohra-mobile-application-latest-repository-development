import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/params/base_params.dart';

class CreateBroadCastMessageParams extends BaseParams {
  CreateBroadCastMessageParams({
    this.receiverId,
    this.groupId,
    required this.text,
  });

  final List<int>? receiverId;
  final List<int>? groupId;
  final String? text;

  factory CreateBroadCastMessageParams.fromMap(Map<String, dynamic> json) =>
      CreateBroadCastMessageParams(
        receiverId: json["receiverIds"] == null ? null : json["receiverIds"],
        groupId: json["groupIds"] == null ? null : json["groupIds"],
        text: stringV(json["text"]),
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (receiverId != null) map['receiverIds'] = receiverId;
    if (groupId != null) map['groupIds'] = groupId;
    if (text != null) map['text'] = text;
    return map;
  }
}
