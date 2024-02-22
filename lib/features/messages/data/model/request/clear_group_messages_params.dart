import 'package:starter_application/core/params/base_params.dart';

class ClearGroupMessagesParams extends BaseParams {
  ClearGroupMessagesParams({
    required this.id,
  });

  final int id;

  factory ClearGroupMessagesParams.fromMap(Map<String, dynamic> json) =>
      ClearGroupMessagesParams(
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
      };
}
