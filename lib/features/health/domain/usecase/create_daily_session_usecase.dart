import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/health/data/model/request/answer_params.dart';
import 'package:starter_application/features/health/data/model/request/create_daily_session_params.dart';
import 'package:starter_application/features/health/domain/repository/ihealth_repository.dart';

@singleton
class CreateDailySessionUseCase extends UseCase<EmptyResponse, CreateDailySessionParams> {
  final IHealthRepository iHealthRepository;

  CreateDailySessionUseCase(this.iHealthRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(CreateDailySessionParams param) {
    return iHealthRepository.createDailySession(param);
  }
}