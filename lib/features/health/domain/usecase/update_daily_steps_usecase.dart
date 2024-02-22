import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/health/data/model/request/update_daily_steps_request_model.dart';
import 'package:starter_application/features/health/domain/repository/ihealth_repository.dart';

@singleton
class UpdateDailyStepsUsecase extends UseCase<EmptyResponse, UpdateDailyStepsParams> {
  final IHealthRepository iHealthRepository;

  UpdateDailyStepsUsecase(this.iHealthRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(UpdateDailyStepsParams param) {
      return iHealthRepository.updateDailySteps(param);
  }
}