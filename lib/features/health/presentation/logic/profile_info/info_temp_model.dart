class HealthProfileInfoTempModel{
  int? gender;
  String? birthDate;
  double? weight;
  int? min_weight;
  int? max_weight;
  double? height;
  int? healthSituation;
  double? goalWeight;
  double? BMIValue;
  int? difficulty;

  HealthProfileInfoTempModel({
    this.gender,
    this.birthDate,
    this.weight,
    this.height,
    this.healthSituation,
    this.goalWeight,
    this.BMIValue,
    this.difficulty,
  });

  @override
  String toString() {
    return 'HealthProfileInfoTempModel{gender: $gender, birthDate: $birthDate, weight: $weight, min_weight: $min_weight, max_weight: $max_weight, height: $height, healthSituation: $healthSituation, recommendedWeight: $goalWeight, BMIValue: $BMIValue, difficulty: $difficulty}';
  }
}