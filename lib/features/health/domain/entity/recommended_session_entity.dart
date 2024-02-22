import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/health/domain/entity/session_entity.dart';

class RecommendedSessionListEntity extends BaseEntity{
  List<OneSessionEntity> items;

  RecommendedSessionListEntity({
    required this.items,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();


}