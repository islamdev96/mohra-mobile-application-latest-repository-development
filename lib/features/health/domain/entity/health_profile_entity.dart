import 'package:starter_application/core/entities/base_entity.dart';

class HealthProfileEntity extends BaseEntity{
  int gender;
  DateTime birthDate;
  double weight;
  double weightGoal;
  double length;
  double bmi;
  int healthSituation;
  int difficulty;
  int minWeight;
  int maxWeight;
  int id;

  HealthProfileEntity({
    required this.gender,
    required this.birthDate,
    required this.weight,
    required this.weightGoal,
    required this.length,
    required this.healthSituation,
    required this.difficulty,
    required this.id,
    required this.minWeight,
    required this.maxWeight,
    required this.bmi,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [];
}