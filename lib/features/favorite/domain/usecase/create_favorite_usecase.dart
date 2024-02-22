import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/favorite/data/model/request/create_favorite_params.dart';
import 'package:starter_application/features/favorite/domain/entity/favorite_entity.dart';
import 'package:starter_application/features/favorite/domain/repository/ifavorite_repository.dart';

@injectable
class CreateFavoriteUseCase
    extends UseCase<FavoriteEntity, CreateFavoriteParams> {
  IFavoriteRepository favoriteRepository;
  CreateFavoriteUseCase(this.favoriteRepository);
  @override
  Future<Result<AppErrors, FavoriteEntity>> call(
      CreateFavoriteParams param) async {
    return await favoriteRepository.createFavorite(param);
  }
}
