import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/common/extensions/either_error_model_extension.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/favorite/data/model/request/create_favorite_params.dart';
import 'package:starter_application/features/favorite/data/model/request/delete_favorites_by_ref_params.dart';
import 'package:starter_application/features/favorite/data/model/request/delete_favorites_params.dart';
import 'package:starter_application/features/favorite/data/model/request/get_favorites_params.dart';
import 'package:starter_application/features/favorite/data/model/response/favorite_model.dart';
import 'package:starter_application/features/favorite/data/model/response/favorites_model.dart';
import 'package:starter_application/features/favorite/domain/entity/favorite_entity.dart';
import 'package:starter_application/features/favorite/domain/entity/favorites_entity.dart';

import '../datasource/../../domain/repository/ifavorite_repository.dart';
import '../datasource/ifavorite_remote.dart';

@Singleton(as: IFavoriteRepository)
class FavoriteRepository extends IFavoriteRepository {
  final IFavoriteRemoteSource iFavoriteRemoteSource;

  FavoriteRepository(this.iFavoriteRemoteSource);

  @override
  Future<Result<AppErrors, FavoriteEntity>> createFavorite(
      CreateFavoriteParams param) async {
    Either<AppErrors, FavoriteModel> remoteResult =
        await iFavoriteRemoteSource.createFavorite(param);
    return remoteResult.result<FavoriteEntity>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> deleteFavorite(
      DeleteFavoriteParams param) async {
    Either<AppErrors, EmptyResponse> remoteResult =
        await iFavoriteRemoteSource.deleteFavorite(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, FavoritesEntity>> getFavorites(
      GetFavoritesParams param) async {
    Either<AppErrors, FavoritesModel> remoteResult =
        await iFavoriteRemoteSource.getFavorites(param);
    return remoteResult.result<FavoritesEntity>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> deleteFavoriteByRef(
      DeleteFavoriteByRefParams param) async {
    final remoteResult = await iFavoriteRemoteSource.deleteFavoriteByRef(param);
    return remoteResult.result<EmptyResponse>();
  }
}
