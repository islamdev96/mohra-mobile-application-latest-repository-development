import 'package:starter_application/core/entities/base_entity.dart';

class LastMessageEntity extends BaseEntity {
  LastMessageEntity({
    this.conversationId,
    this.groupId,
    required this.text,
    this.senderId,
    this.creationTime,
    required this.isRead,
    this.id,
  });

  final int? conversationId;
  final int? groupId;
  final String text;
  final int? senderId;
  final DateTime? creationTime;
  final bool isRead;
  final int? id;

  @override
  List<Object?> get props => [];
}
