import 'package:starter_application/core/usecases/usecase.dart';


import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/health/data/model/request/get_dish_list_params.dart';
import 'package:starter_application/features/health/domain/entity/dishes_list_entity.dart';
import 'package:starter_application/features/health/domain/entity/recipe_list_entity.dart';
import 'package:starter_application/features/health/domain/repository/ihealth_repository.dart';

@singleton
class GetRecipeListByCategoryUsecase extends UseCase<RecipesEntity , GetDishListParams>{

  final IHealthRepository iHealthRepository;
  GetRecipeListByCategoryUsecase(this.iHealthRepository);

  @override
  Future<Result<AppErrors, RecipesEntity>> call(GetDishListParams param) {
    return iHealthRepository.getRecipesByCategory(param);
  }

}
