import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/friend/domain/entity/send_friend_request_entity.dart';

class SendFriendRequestsEntity extends BaseEntity {
  SendFriendRequestsEntity({
    this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<SendFriendRequestEntity> items;

  @override
  List<Object?> get props => [];
}
