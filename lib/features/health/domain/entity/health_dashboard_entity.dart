import 'package:starter_application/core/entities/base_entity.dart';

class HealthDashboardEntity extends BaseEntity{
  HealthDashboardEntity({
    required this.intakeKcal,
    required this.trainingKcal,
    required this.totalCupsOfWater,
    required this.totalValueOfCalories,
    required this.carbs,
    required this.protein,
    required this.fat,
  });

  double intakeKcal;
  double trainingKcal;
  int totalCupsOfWater;
  double carbs;
  double protein;
  double totalValueOfCalories;
  double fat;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();



}