import 'package:starter_application/core/params/base_params.dart';

class UpdateDailyStepsParams extends BaseParams{
  int stepsToWalk;
  DateTime day;

  UpdateDailyStepsParams({
    required this.day,
    required this.stepsToWalk,
});

  @override
  Map<String, dynamic> toMap() {
    return {
      "stepsToWalk": stepsToWalk,
      "day": '${day}'
    };
  }



}