import 'package:starter_application/core/params/base_params.dart';

class CommentRequest extends BaseParams {
  CommentRequest({
    required this.text,
    required this.refId,
    required this.refType,
  });

  final String text;
  final String refId;
  final int refType;

  factory CommentRequest.fromMap(Map<String, dynamic> json) => CommentRequest(
        text: json["text"] == null ? null : json["text"],
        refId: json["refId"] == null ? null : json["refId"],
        refType: json["refType"] == null ? null : json["refType"],
      );

  Map<String, dynamic> toMap() => {
        "text": text,
        "refId": refId,
        "refType": refType,
      };
}
