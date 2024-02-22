import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart';

class FriendEntity extends BaseEntity {
  FriendEntity({
    required this.clientId,
    required this.client,
    required this.friendId,
    required this.friendInfo,
    required this.id,
    required this.isBlock,
  });

  final int? clientId;
  final ClientEntity? client;
  final int? friendId;
  final ClientEntity? friendInfo;
  final int? id;
  bool isBlock;

  @override
  List<Object?> get props => [id,clientId];
}
