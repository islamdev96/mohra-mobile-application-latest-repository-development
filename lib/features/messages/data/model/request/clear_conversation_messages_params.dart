import 'package:starter_application/core/params/base_params.dart';

class ClearConversationMessagesParams extends BaseParams {
  ClearConversationMessagesParams({
    required this.id,
  });

  final int id;

  factory ClearConversationMessagesParams.fromMap(Map<String, dynamic> json) =>
      ClearConversationMessagesParams(
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
      };
}
