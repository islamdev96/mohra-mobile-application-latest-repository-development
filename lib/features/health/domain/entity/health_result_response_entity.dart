import 'package:starter_application/core/entities/base_entity.dart';

class HealthResultResponseEntity extends BaseEntity {
  HealthResultResponseEntity({
    required this.totalValueOfCalories,
    required this.difficulty,
    required this.activityLevel,
    required this.caloriesToEat,
    required this.caloriesToBurn,
    required this.stepsToWalk,
    required this.bmi,
    required this.brm,
    required this.arm,
  });

  final double totalValueOfCalories;
  final int difficulty;
  final int activityLevel;
  final double? caloriesToEat;
  final double? caloriesToBurn;
  final int? stepsToWalk;
  final double bmi;
  final double brm;
  final double arm;

  factory HealthResultResponseEntity.fromJson(Map<String, dynamic> json) => HealthResultResponseEntity(
    totalValueOfCalories: json["totalValueOfCalories"].toDouble(),
    difficulty: json["difficulty"],
    activityLevel: json["activityLevel"],
    caloriesToEat: json["caloriesToEat"],
    caloriesToBurn: json["caloriesToBurn"],
    stepsToWalk: json["stepsToWalk"],
    bmi: json["bmi"].toDouble(),
    brm: json["brm"].toDouble(),
    arm: json["arm"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "totalValueOfCalories": totalValueOfCalories,
    "difficulty": difficulty,
    "activityLevel": activityLevel,
    "caloriesToEat": caloriesToEat,
    "caloriesToBurn": caloriesToBurn,
    "stepsToWalk": stepsToWalk,
    "bmi": bmi,
    "brm": brm,
    "arm": arm,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
