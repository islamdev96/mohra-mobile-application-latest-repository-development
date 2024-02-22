import 'package:starter_application/core/entities/base_entity.dart';

import 'like_client_entity.dart';

class LikeEntity extends BaseEntity {
  LikeEntity({
    required this.refId,
    this.refType,
    this.creationTime,
    this.clientId,
    this.client,
    this.id,
  });

  final String refId;
  final int? refType;
  final DateTime? creationTime;
  final int? clientId;
  final LikeClientEntity? client;
  final int? id;

  @override
  List<Object?> get props => [];
}
