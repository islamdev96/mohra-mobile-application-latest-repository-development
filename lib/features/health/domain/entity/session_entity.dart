import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/health/data/model/response/get_all_exercies_model.dart';
import 'package:starter_application/features/health/domain/entity/exercises_entity.dart';


class SessionsEntity extends BaseEntity {
  SessionsEntity({
    required this.totalCount,
    required this.sessionList,
  });

  int totalCount;
  List<OneSessionEntity> sessionList;

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class OneSessionEntity extends BaseEntity {
  OneSessionEntity({
    required this.timeInMinutes,
    required this.amountOfCalories,
    required this.arTitle,
    required this.enTitle,
    required this.title,
    required this.imageUrl,
    required this.arDescription,
    required this.enDescription,
    required this.description,
    required this.exercises,
    required this.isActive,
    required this.favoriteId,
    required this.isFavorite,
    required this.id,
  });

  int? timeInMinutes;
  double? amountOfCalories;
  String? arTitle;
  String? enTitle;
  String? title;
  String? imageUrl;
  String? arDescription;
  String? enDescription;
  String? description;
  List<OneExerciseEntity> exercises;
  int? favoriteId;
  bool? isFavorite;
  bool isActive;
  int? id;

  @override
  // TODO: implement props
  List<Object?> get props => [];

}
/*
class SessionExerciseEntity extends BaseEntity {
  SessionExerciseEntity({
    required this.id,
    required this.name,
    required this.durationInMinutes,
    required this.amountOfCalories,
    required this.type,
  });

  int id;
  String name;
  int durationInMinutes;
  double amountOfCalories;
  int type;




  @override
  // TODO: implement props
  List<Object?> get props => [];
}*/
