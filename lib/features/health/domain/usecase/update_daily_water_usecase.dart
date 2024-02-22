import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/health/data/model/request/update_daily_water.dart';
import 'package:starter_application/features/health/domain/repository/ihealth_repository.dart';

@singleton
class UpdateDailyWaterUsecase extends UseCase<EmptyResponse, UpdateDailyWaterParams> {
  final IHealthRepository iHealthRepository;

  UpdateDailyWaterUsecase(this.iHealthRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(UpdateDailyWaterParams param) {
    return iHealthRepository.updateDailyWater(param);
  }
}
