import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/base_params.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/health/data/model/request/daily_dish_list_params.dart';
import 'package:starter_application/features/health/domain/entity/daily_dish_entity.dart';
import 'package:starter_application/features/health/domain/entity/food_categories_entity.dart';
import 'package:starter_application/features/health/domain/repository/ihealth_repository.dart';

@singleton
class GetDailyDishListUsecase extends UseCase<DailyDishListEntity , DailyDishListParamms>{

  final IHealthRepository iHealthRepository;
  GetDailyDishListUsecase(this.iHealthRepository);

  @override
  Future<Result<AppErrors, DailyDishListEntity>> call(DailyDishListParamms param) {
    return iHealthRepository.getDailyDishList(param);
  }

}