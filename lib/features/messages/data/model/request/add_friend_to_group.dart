import 'package:starter_application/core/params/base_params.dart';

class AddFriendToGroupParams extends BaseParams {
  AddFriendToGroupParams({
    required this.groupId,
    required this.friendIds,
  });

  final int groupId;
  final List<int> friendIds;

  factory AddFriendToGroupParams.fromMap(Map<String, dynamic> json) =>
      AddFriendToGroupParams(
        groupId: json["groupId"] == null ? null : json["groupId"],
        friendIds: json["friendIds"] == null
            ? []
            : List<int>.from(json["friendIds"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "groupId": groupId,
         if(friendIds.length > 0)
        "friendIds": List<dynamic>.from(friendIds.map((x) => x)),
      };
}
