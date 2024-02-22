import 'package:starter_application/core/params/base_params.dart';

class BlockFriendParams extends BaseParams {
  BlockFriendParams({
    required this.id,
  });

  final int id;

  factory BlockFriendParams.fromMap(Map<String, dynamic> json) =>
      BlockFriendParams(
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
      };
}
