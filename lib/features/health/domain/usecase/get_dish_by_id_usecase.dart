import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/health/data/model/request/daily_dish_list_params.dart';
import 'package:starter_application/features/health/data/model/request/get_dish_params.dart';
import 'package:starter_application/features/health/domain/entity/daily_dish_entity.dart';
import 'package:starter_application/features/health/domain/entity/dishes_list_entity.dart';
import 'package:starter_application/features/health/domain/repository/ihealth_repository.dart';

@singleton
class GetDishByIdUsecase extends UseCase<DishEntity , GetDishParams>{

  final IHealthRepository iHealthRepository;
  GetDishByIdUsecase(this.iHealthRepository);

  @override
  Future<Result<AppErrors, DishEntity>> call(GetDishParams param) {
    return iHealthRepository.getDishById(param);
  }

}