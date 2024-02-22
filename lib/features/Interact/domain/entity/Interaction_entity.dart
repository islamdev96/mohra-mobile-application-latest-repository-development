import 'package:starter_application/core/entities/base_entity.dart';

import 'Interaction_client_entity.dart';

class InteractionEntity extends BaseEntity {
  InteractionEntity({
    required this.refId,
    this.refType,
    this.creationTime,
    this.clientId,
    this.client,
    this.id,
    this.interactionType

  });

  final String refId;
  final int? refType;
  final DateTime? creationTime;
  final int? clientId;
  final InteractionClientEntity? client;
  final int? id;
  final int? interactionType;

  @override
  List<Object?> get props => [];
}
