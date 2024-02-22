import 'package:starter_application/features/messages/domain/entity/friend_entity.dart';

class GroupDetailsScreenParams {
  final List<FriendEntity> friends;
  final bool isEditGroup;
  final String? image;
  final String? name;
  final String? details;
  final int? id;
  GroupDetailsScreenParams(
      {this.isEditGroup = false,
      this.id,
      this.image,
      this.name,
      this.details,
      required this.friends});
}
