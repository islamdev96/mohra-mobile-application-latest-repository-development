import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/usecases/usecase.dart';


import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/health/domain/entity/favorite_dish_entity.dart';
import 'package:starter_application/features/health/domain/repository/ihealth_repository.dart';

@singleton
class GetFavoriteDishesUseCase extends UseCase<FavortieDishListEntity , NoParams>{

  final IHealthRepository iHealthRepository;
  GetFavoriteDishesUseCase(this.iHealthRepository);

  @override
  Future<Result<AppErrors, FavortieDishListEntity>> call(NoParams param) {
    return iHealthRepository.getFavoriteDishes(param);
  }

}
