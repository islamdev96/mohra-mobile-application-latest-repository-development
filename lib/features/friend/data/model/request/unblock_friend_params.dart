import 'package:starter_application/core/params/base_params.dart';

class UnblockFriendParams extends BaseParams {
  UnblockFriendParams({
    required this.id,
  });

  final int id;

  factory UnblockFriendParams.fromMap(Map<String, dynamic> json) =>
      UnblockFriendParams(
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
      };
}
