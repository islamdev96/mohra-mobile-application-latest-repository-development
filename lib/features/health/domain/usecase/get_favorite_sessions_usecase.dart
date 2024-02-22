import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/usecases/usecase.dart';


import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/health/domain/entity/favorite_recipe_entity.dart';
import 'package:starter_application/features/health/domain/entity/favorite_session_entity.dart';
import 'package:starter_application/features/health/domain/repository/ihealth_repository.dart';

@singleton
class GetFavoriteSessionListUsecase extends UseCase<FavoriteSessionListEntity , NoParams>{

  final IHealthRepository iHealthRepository;
  GetFavoriteSessionListUsecase(this.iHealthRepository);

  @override
  Future<Result<AppErrors, FavoriteSessionListEntity>> call(NoParams param) {
    return iHealthRepository.getFavoriteSessions(param);
  }

}
