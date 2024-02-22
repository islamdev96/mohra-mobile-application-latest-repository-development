import 'package:starter_application/core/usecases/usecase.dart';


import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/health/data/model/request/get_dish_list_params.dart';
import 'package:starter_application/features/health/domain/entity/dishes_list_entity.dart';
import 'package:starter_application/features/health/domain/repository/ihealth_repository.dart';

@singleton
class GetDishedListByCategoryUsecase extends UseCase<DishesEntity , GetDishListParams>{

  final IHealthRepository iHealthRepository;
  GetDishedListByCategoryUsecase(this.iHealthRepository);

  @override
  Future<Result<AppErrors, DishesEntity>> call(GetDishListParams param) {
    return iHealthRepository.getDishesByCategory(param);
  }

}
