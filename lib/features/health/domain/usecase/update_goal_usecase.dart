import 'package:starter_application/core/usecases/usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/health/data/model/request/update_goal.dart';
import 'package:starter_application/features/health/domain/entity/health_profile_entity.dart';
import 'package:starter_application/features/health/domain/repository/ihealth_repository.dart';

@singleton
class UpdateGoalUsecase extends UseCase<HealthProfileEntity, UpdateGoalParams> {
  final IHealthRepository iHealthRepository;

  UpdateGoalUsecase(this.iHealthRepository);

  @override
  Future<Result<AppErrors, HealthProfileEntity>> call(UpdateGoalParams param) {
    return iHealthRepository.updateGoal(param);
  }
}
