import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart';

import 'message_entity.dart';

class GroupEntity extends BaseEntity {
  GroupEntity({
    required this.name,
    required this.imageUrl,
    this.creatorId,
    this.creator,
    required this.details,
    this.creationTime,
    required this.friends,
    this.lastMessage,
    this.countMessegesUnreaded,
    this.id,
    this.localMessages = const [],
  });

  final String name;
  final String imageUrl;
  final int? creatorId;
  final ClientEntity? creator;
  final String details;
  final DateTime? creationTime;
  final List<ClientEntity> friends;
  MessageEntity? lastMessage;
  int? countMessegesUnreaded;
  final int? id;
  List<MessageEntity> localMessages;

  @override
  List<Object?> get props => [];
}
