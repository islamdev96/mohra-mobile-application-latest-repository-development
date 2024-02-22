
import 'package:starter_application/core/entities/base_entity.dart';

class ExercisesEntity extends BaseEntity {
  ExercisesEntity({
    required this.totalCount,
    required this.exerciseEntity,
  });

  int totalCount;
  List<OneExerciseEntity> exerciseEntity;

  @override
  // TODO: implement props
  List<Object?> get props => [];


}

class OneExerciseEntity extends BaseEntity{
  OneExerciseEntity({
    required this.arTitle,
    required this.enTitle,
    required this.title,
    required this.amountOfCalories,
    required this.durationInMinutes,
    required this.imageUrl,
    required this.arDescription,
    required this.enDescription,
    required this.description,
    required this.sessionsCount,
    required this.isActive,
    required this.id,
    required this.type,
  });

  String arTitle;
  String enTitle;
  String title;
  double amountOfCalories;
  int durationInMinutes;
  String imageUrl;
  String arDescription;
  String enDescription;
  String description;
  int sessionsCount;
  bool isActive;
  int id;
  int type;

  @override
  // TODO: implement props
  List<Object?> get props => [];


}
