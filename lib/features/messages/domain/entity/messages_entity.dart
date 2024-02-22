import 'package:starter_application/core/entities/base_entity.dart';

import 'message_entity.dart';

class MessagesEntity extends BaseEntity {
  MessagesEntity({
    this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<MessageEntity> items;

  @override
  List<Object?> get props => [];
}
