import 'package:starter_application/core/params/base_params.dart';

class DeleteFriendParams extends BaseParams {
  DeleteFriendParams({
    required this.id,
  });

  final int id;

  factory DeleteFriendParams.fromMap(Map<String, dynamic> json) =>
      DeleteFriendParams(
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
      };
}
