import 'package:starter_application/core/usecases/usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/health/data/model/request/all_exercises_params.dart';
import 'package:starter_application/features/health/data/model/request/all_sessions_params.dart';
import 'package:starter_application/features/health/domain/entity/exercises_entity.dart';
import 'package:starter_application/features/health/domain/entity/session_entity.dart';
import 'package:starter_application/features/health/domain/repository/ihealth_repository.dart';

@singleton
class GetSessionsUsecase extends UseCase<SessionsEntity, AllSessionsParams> {
  final IHealthRepository iHealthRepository;

  GetSessionsUsecase(this.iHealthRepository);

  @override
  Future<Result<AppErrors, SessionsEntity>> call(AllSessionsParams param) {
    return iHealthRepository.getAllSessions(param);
  }
}
