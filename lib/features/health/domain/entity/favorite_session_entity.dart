import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/health/domain/entity/session_entity.dart';

class FavoriteSessionListEntity extends BaseEntity {
  FavoriteSessionListEntity({
    required this.totalCount,
    required this.items,
  });

  int totalCount;
  List<FavoriteSessionItemEntity> items;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();


}

class FavoriteSessionItemEntity extends BaseEntity {
  FavoriteSessionItemEntity({
    required this.sessionId,
    required this.session,
    required this.id,
    required this.clientId,
  });

  int sessionId;
  OneSessionEntity session;
  int id;
  int clientId;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();


}