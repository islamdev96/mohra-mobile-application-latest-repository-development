import 'package:dartz/dartz.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/features/favorite/data/model/request/create_favorite_params.dart';
import 'package:starter_application/features/favorite/data/model/request/delete_favorites_by_ref_params.dart';
import 'package:starter_application/features/favorite/data/model/request/delete_favorites_params.dart';
import 'package:starter_application/features/favorite/data/model/request/get_favorites_params.dart';
import 'package:starter_application/features/favorite/data/model/response/favorite_model.dart';
import 'package:starter_application/features/favorite/data/model/response/favorites_model.dart';

import '../../../../core/datasources/remote_data_source.dart';

abstract class IFavoriteRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, FavoriteModel>> createFavorite(
      CreateFavoriteParams param);

  Future<Either<AppErrors, EmptyResponse>> deleteFavorite(
      DeleteFavoriteParams param);

  Future<Either<AppErrors, FavoritesModel>> getFavorites(
      GetFavoritesParams param);

 Future<Either<AppErrors, EmptyResponse>> deleteFavoriteByRef(DeleteFavoriteByRefParams param);
}
