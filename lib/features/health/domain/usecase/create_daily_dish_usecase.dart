import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/health/data/model/request/daily_dish_params.dart';
import 'package:starter_application/features/health/domain/entity/daily_dish_entity.dart';
import 'package:starter_application/features/health/domain/repository/ihealth_repository.dart';

@singleton
class CreateDailyDishUsecase extends UseCase<DailyDishEntity, DailyDishParams> {
  final IHealthRepository iHealthRepository;

  CreateDailyDishUsecase(this.iHealthRepository);

  @override
  Future<Result<AppErrors, DailyDishEntity>> call(DailyDishParams param) {
    return iHealthRepository.createDailyDish(param);
  }
}
