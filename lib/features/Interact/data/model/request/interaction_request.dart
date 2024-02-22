import 'package:starter_application/core/params/base_params.dart';

class InteractRequest extends BaseParams {
  InteractRequest({
    required this.refId,
    required this.refType,
    required this.interactionType,
  });

  final String refId;
  final int refType;
  final int interactionType;

  factory InteractRequest.fromMap(Map<String, dynamic> json) => InteractRequest(
        refId: json["refId"] == null ? null : json["refId"],
        refType: json["refType"] == null ? null : json["refType"],
        interactionType:
            json["interactionType"] == null ? null : json["interactionType"],
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['refId'] = refId;
    map['refType'] = refType;
    map['interactionType'] = interactionType;
    return map;
  }
}
