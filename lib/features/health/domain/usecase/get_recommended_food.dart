import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/health/data/model/request/all_sessions_params.dart';
import 'package:starter_application/features/health/domain/entity/recommended_food_entity.dart';
import 'package:starter_application/features/health/domain/entity/session_entity.dart';
import 'package:starter_application/features/health/domain/repository/ihealth_repository.dart';

@singleton
class GetRecommendedFood extends UseCase<RecommendedFoodIListEntity, NoParams> {
  final IHealthRepository iHealthRepository;

  GetRecommendedFood(this.iHealthRepository);

  @override
  Future<Result<AppErrors, RecommendedFoodIListEntity>> call(NoParams param) {
    return iHealthRepository.getRecommendedFood(param);
  }
}
