import 'package:starter_application/core/entities/base_entity.dart';

class FavoriteEntity extends BaseEntity {
  FavoriteEntity({
    required this.refId,
    this.refType,
    this.creationTime,
    this.clientId,
    this.id,
  });

  final String refId;
  final int? refType;
  final DateTime? creationTime;
  final int? clientId;
  final int? id;

  @override
  List<Object?> get props => [];
}
