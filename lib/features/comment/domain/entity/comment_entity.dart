import 'package:starter_application/core/entities/base_entity.dart';

import 'comment_client_entity.dart';

class CommentEntity extends BaseEntity {
  CommentEntity({
    required this.text,
    required this.refId,
    this.refType,
    this.creationTime,
    this.clientId,
    this.client,
    this.id,
  });

  final String text;
  final String refId;
  final int? refType;
  final DateTime? creationTime;
  final int? clientId;
  CommentClientEntity? client;
  final int? id;

  @override
  List<Object?> get props => [];
}
