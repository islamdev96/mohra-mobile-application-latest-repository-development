import 'package:starter_application/core/params/base_params.dart';

class CreateDailySessionParams extends BaseParams {
  int exerciseSessionId;
  String creationTime;

  CreateDailySessionParams({
    required this.exerciseSessionId,
    required this.creationTime,
  });

  @override
  Map<String, dynamic> toMap() => {
        'exerciseSessionId': exerciseSessionId,
        'creationTime': creationTime,
      };
}
