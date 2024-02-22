import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/base_params.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/health/data/model/request/search_params.dart';
import 'package:starter_application/features/health/domain/entity/food_categories_entity.dart';
import 'package:starter_application/features/health/domain/repository/ihealth_repository.dart';

@singleton
class GetFoodCategoriesUsecase extends UseCase<FoodCategoriesEntity , SearchParam>{

  final IHealthRepository iHealthRepository;
  GetFoodCategoriesUsecase(this.iHealthRepository);

  @override
  Future<Result<AppErrors, FoodCategoriesEntity>> call(SearchParam param) {
    return iHealthRepository.getFoodCategory(param);
  }

}