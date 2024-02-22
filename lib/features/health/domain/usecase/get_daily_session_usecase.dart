import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/health/data/model/request/daily_dish_list_params.dart';
import 'package:starter_application/features/health/data/model/request/date_params.dart';
import 'package:starter_application/features/health/data/model/request/get_dish_params.dart';
import 'package:starter_application/features/health/domain/entity/daily_dish_entity.dart';
import 'package:starter_application/features/health/domain/entity/daily_session_entity.dart';
import 'package:starter_application/features/health/domain/entity/dishes_list_entity.dart';
import 'package:starter_application/features/health/domain/repository/ihealth_repository.dart';

@singleton
class GetDailySessionUsecase extends UseCase<DailySessionListEntity , DateParams>{

  final IHealthRepository iHealthRepository;
  GetDailySessionUsecase(this.iHealthRepository);

  @override
  Future<Result<AppErrors, DailySessionListEntity>> call(DateParams param) {
    return iHealthRepository.getDailySessions(param);
  }

}