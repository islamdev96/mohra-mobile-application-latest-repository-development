import 'package:starter_application/core/entities/base_entity.dart';

import 'conversation_entity.dart';
import 'group_entity.dart';

class MessageEntity extends BaseEntity {
  MessageEntity({
    required this.text,
    this.senderId,
    this.conversationId,
    this.conversation,
    this.groupId,
    this.group,
    required this.creationTime,
    required this.isRead,
    this.id,
  });

  final String text;
  final int? senderId;
  final int? conversationId;
  final ConversationEntity? conversation;
  final int? groupId;
  final GroupEntity? group;
  final DateTime creationTime;
  bool isRead;
  final int? id;

  @override
  List<Object?> get props => [creationTime];
}
