import 'package:starter_application/core/entities/base_entity.dart';

import 'friend_entity.dart';

class FriendsEntity extends BaseEntity {
  FriendsEntity({
    this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<FriendEntity> items;

  @override
  List<Object?> get props => [items];
}
