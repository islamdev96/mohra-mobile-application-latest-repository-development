import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/health/domain/entity/health_result_response_entity.dart';

class HealthResultResponseModel extends BaseModel<HealthResultResponseEntity> {
  HealthResultResponseModel({
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

  factory HealthResultResponseModel.fromJson(Map<String, dynamic> json) =>
      HealthResultResponseModel(
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
  HealthResultResponseEntity toEntity() {
    return HealthResultResponseEntity(
        totalValueOfCalories: totalValueOfCalories,
        difficulty: difficulty,
        activityLevel: activityLevel,
        caloriesToEat: caloriesToEat,
        caloriesToBurn: caloriesToBurn,
        stepsToWalk: stepsToWalk,
        bmi: bmi,
        brm: brm,
        arm: arm);
  }
}
