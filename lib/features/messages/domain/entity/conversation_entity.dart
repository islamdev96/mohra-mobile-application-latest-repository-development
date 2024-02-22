import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart';
import 'package:starter_application/features/messages/domain/entity/message_entity.dart';

import 'last_message_entity.dart';

class ConversationEntity extends BaseEntity {
  ConversationEntity({
    required this.channel,
    this.firstUserId,
    this.firstUser,
    this.secondUserId,
    this.secondUser,
    this.creationTime,
    this.lastMessage,
    this.countMessegesUnreaded,
    required this.isActive,
    required this.arName,
    required this.enName,
    required this.name,
    this.id,
    this.localMessages = const [],
  });

  final String channel;
  final int? firstUserId;
  final ClientEntity? firstUser;
  final int? secondUserId;
  final ClientEntity? secondUser;
  final DateTime? creationTime;
  LastMessageEntity? lastMessage;
  int? countMessegesUnreaded;
  final bool isActive;
  final String arName;
  final String enName;
  final String name;
  final int? id;
  List<MessageEntity> localMessages;

  @override
  List<Object?> get props => [];
}
