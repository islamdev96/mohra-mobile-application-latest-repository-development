import 'package:starter_application/core/params/base_params.dart';

class AllExercisesParams extends BaseParams{

  int maxResultCount;

  AllExercisesParams({
    required this.maxResultCount,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'MaxResultCount':maxResultCount
    };
  }
  }
