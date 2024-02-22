import 'package:starter_application/core/params/base_params.dart';

class UpdateGoalParams extends BaseParams {
  double goal;

  UpdateGoalParams({
    required this.goal,
  });

  @override
  Map<String, dynamic> toMap() => {
    'goal':goal,
  };


}
