import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/favorite/data/model/request/get_favorites_params.dart';
import 'package:starter_application/features/favorite/domain/entity/favorites_entity.dart';
import 'package:starter_application/features/favorite/domain/repository/ifavorite_repository.dart';

@injectable
class GetFavoritesUseCase extends UseCase<FavoritesEntity, GetFavoritesParams> {
  IFavoriteRepository favoriteRepository;
  GetFavoritesUseCase(this.favoriteRepository);
  @override
  Future<Result<AppErrors, FavoritesEntity>> call(
      GetFavoritesParams param) async {
    return await favoriteRepository.getFavorites(param);
  }
}
