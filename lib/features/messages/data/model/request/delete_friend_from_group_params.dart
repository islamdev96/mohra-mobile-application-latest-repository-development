import 'package:starter_application/core/params/base_params.dart';

class DeleteFriendFromGroupParams extends BaseParams {
  DeleteFriendFromGroupParams({
    required this.groupId,
    required this.friendId,
  });

  final int groupId;
  final int friendId;

  factory DeleteFriendFromGroupParams.fromMap(Map<String, dynamic> json) =>
      DeleteFriendFromGroupParams(
        groupId: json["groupId"] == null ? null : json["groupId"],
        friendId: json["friendId"] == null ? null : json["friendId"],
      );

  Map<String, dynamic> toMap() => {
        "groupId": groupId,
        "friendId": friendId,
      };
}
