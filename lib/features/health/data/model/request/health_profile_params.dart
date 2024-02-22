import 'package:starter_application/core/params/base_params.dart';

class HealthProfileParams extends BaseParams{
  int gender ,healthSituation,difficulty,minRecommendedWeight,maxRecommendedWeight;
  int ?id ,activityLevel;
  String birthDay;
  double weight , length ,weightGoal,bmi;

  HealthProfileParams({
    required this.gender,
    required this.healthSituation,
    required this.difficulty,
    required this.birthDay,
    required this.weight,
    required this.length,
    required this.weightGoal,
    required this.bmi,
    required this.maxRecommendedWeight,
    required this.minRecommendedWeight,
     this.activityLevel,
    this.id,
  });

  @override
  Map<String, dynamic> toMap() {
    Map<String , dynamic> map = {
      'gender':gender,
      'birthDate':birthDay,
      'weight':weight,
      'weightGoal':weightGoal,
      'length':length,
      'healthSituation':healthSituation,
      'difficulty':difficulty,
      'bmi':bmi,
      'minRecommendedWeight':minRecommendedWeight,
      'maxRecommendedWeight':maxRecommendedWeight,
      'id':id,
    };
    if(activityLevel != null) map['activityLevel'] = activityLevel;
    return map;
  }

  @override
  String toString() {
    return 'HealthProfileParams{gender: $gender, healthSituation: $healthSituation, difficulty: $difficulty, minRecommendedWeight: $minRecommendedWeight, maxRecommendedWeight: $maxRecommendedWeight, activityLevel: $activityLevel, id: $id, birthDay: $birthDay, weight: $weight, length: $length, weightGoal: $weightGoal, bmi: $bmi}';
  }
}