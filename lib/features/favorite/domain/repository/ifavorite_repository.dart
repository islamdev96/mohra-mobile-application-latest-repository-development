import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/favorite/data/model/request/create_favorite_params.dart';
import 'package:starter_application/features/favorite/data/model/request/delete_favorites_by_ref_params.dart';
import 'package:starter_application/features/favorite/data/model/request/delete_favorites_params.dart';
import 'package:starter_application/features/favorite/data/model/request/get_favorites_params.dart';
import 'package:starter_application/features/favorite/domain/entity/favorite_entity.dart';
import 'package:starter_application/features/favorite/domain/entity/favorites_entity.dart';

import '../../../../core/repositories/repository.dart';

abstract class IFavoriteRepository extends Repository {
  Future<Result<AppErrors, FavoritesEntity>> getFavorites(
      GetFavoritesParams param);
  Future<Result<AppErrors, FavoriteEntity>> createFavorite(
      CreateFavoriteParams param);
  Future<Result<AppErrors, EmptyResponse>> deleteFavorite(
      DeleteFavoriteParams param);

  Future<Result<AppErrors, EmptyResponse>> deleteFavoriteByRef(
      DeleteFavoriteByRefParams param);
}
