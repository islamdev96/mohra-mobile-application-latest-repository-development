import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/messages/domain/entity/friends_entity.dart';

import 'friend_model.dart';

class FriendsModel extends BaseModel<FriendsEntity> {
  FriendsModel({
    this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<FriendModel> items;

  factory FriendsModel.fromMap(Map<String, dynamic> json) => FriendsModel(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        items: json["items"] == null
            ? []
            : List<FriendModel>.from(
                json["items"].map((x) => FriendModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount == null ? null : totalCount,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };

  @override
  FriendsEntity toEntity() {
    return FriendsEntity(
        items: items.map((e) => e.toEntity()).toList(), totalCount: totalCount);
  }
}
