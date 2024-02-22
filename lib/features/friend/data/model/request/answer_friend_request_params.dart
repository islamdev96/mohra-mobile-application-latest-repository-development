import 'package:starter_application/core/params/base_params.dart';

class AnswerFriendRequestParams extends BaseParams {
  AnswerFriendRequestParams({
    required this.id,
  });

  final int id;

  factory AnswerFriendRequestParams.fromMap(Map<String, dynamic> json) =>
      AnswerFriendRequestParams(
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
      };
}
