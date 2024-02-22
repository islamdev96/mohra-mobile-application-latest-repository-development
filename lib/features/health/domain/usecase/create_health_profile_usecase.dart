import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/base_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/health/data/model/request/daily_dish_params.dart';
import 'package:starter_application/features/health/data/model/request/health_profile_params.dart';
import 'package:starter_application/features/health/domain/entity/daily_dish_entity.dart';
import 'package:starter_application/features/health/domain/entity/health_profile_entity.dart';
import 'package:starter_application/features/health/domain/repository/ihealth_repository.dart';

@singleton
class CreateHealthProfileUsecase extends UseCase<HealthProfileEntity, HealthProfileParams> {
  final IHealthRepository iHealthRepository;

  CreateHealthProfileUsecase(this.iHealthRepository);

  @override
  Future<Result<AppErrors, HealthProfileEntity>> call(HealthProfileParams param) {
    return iHealthRepository.createHealthProfile(param);
  }
}
