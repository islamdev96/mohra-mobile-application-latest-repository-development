import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/health/domain/entity/exercises_entity.dart';
import 'package:starter_application/features/health/domain/entity/session_entity.dart';

class DailySessionListEntity extends BaseEntity {
  DailySessionListEntity({
    required this.trainingKcal,
    required this.walkingKcal,
    required this.totalCount,
    required this.items,
  });

  double trainingKcal;
  double walkingKcal;
  int totalCount;
  List<DailySessionItemEntity> items;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class DailySessionItemEntity extends BaseEntity {
  DailySessionItemEntity({
    required this.exerciseSessionId,
    required this.trainingKcal,
    required this.walkingKcal,
    required this.session,
    required this.id,
  });

  int exerciseSessionId;
  double trainingKcal;
  double walkingKcal;
  DailySessionEntity session;
  int id;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class DailySessionEntity extends BaseEntity {
  DailySessionEntity({
    required this.exercises,
    required this.arTitle,
    required this.enTitle,
    required this.title,
    required this.imageUrl,
    required this.timeInMinutes,
    required this.amountOfCalories,
  });

  List<OneExerciseEntity>? exercises;
  String? arTitle;
  String? enTitle;
  String? title;
  String? imageUrl;
  int? timeInMinutes;
  double? amountOfCalories;

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
