import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart';

class ClientProfileEntity extends BaseEntity {
  ClientProfileEntity({
    this.client,
    required this.isFriend,
    required this.isMuted,
    required this.isBlocked,
    required this.hasFriendRequest,
  });

  final ClientEntity? client;
  final bool isFriend;
  final bool isBlocked;
  final bool isMuted;
  final bool hasFriendRequest;

  @override
  List<Object?> get props => [];
}
