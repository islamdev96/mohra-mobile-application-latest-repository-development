import 'package:starter_application/core/entities/base_entity.dart';

import 'conversation_entity.dart';

class ConversationsEntity extends BaseEntity {
  ConversationsEntity({
    this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<ConversationEntity> items;

  @override
  List<Object?> get props => [];
}
