import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/health/domain/entity/check_health_profile_entity.dart';
import 'package:starter_application/features/health/domain/repository/ihealth_repository.dart';

@singleton
class CheckHealthProfileUsecase extends UseCase<CheckHealthProfileEntity, NoParams> {
  final IHealthRepository iHealthRepository;

  CheckHealthProfileUsecase(this.iHealthRepository);

  @override
  Future<Result<AppErrors, CheckHealthProfileEntity>> call(NoParams param) {
    return iHealthRepository.checkHealthProfile(param);
  }

}
