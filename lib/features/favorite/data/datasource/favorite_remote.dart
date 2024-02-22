import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/constants/enums/http_method.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/net/api_url.dart';
import 'package:starter_application/core/net/create_model_interceptor/null_response_model_interceptor.dart';
import 'package:starter_application/features/favorite/data/model/request/create_favorite_params.dart';
import 'package:starter_application/features/favorite/data/model/request/delete_favorites_by_ref_params.dart';
import 'package:starter_application/features/favorite/data/model/request/delete_favorites_params.dart';
import 'package:starter_application/features/favorite/data/model/request/get_favorites_params.dart';
import 'package:starter_application/features/favorite/data/model/response/favorite_model.dart';
import 'package:starter_application/features/favorite/data/model/response/favorites_model.dart';

import 'ifavorite_remote.dart';

@Singleton(as: IFavoriteRemoteSource)
class FavoriteRemoteSource extends IFavoriteRemoteSource {
  @override
  Future<Either<AppErrors, FavoriteModel>> createFavorite(
      CreateFavoriteParams param) {
    return request(
      converter: (json) => FavoriteModel.fromMap(json),
      method: HttpMethod.POST,
      body: param.toMap(),
      url: APIUrls.API_CREATE_FAVORITE,
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> deleteFavorite(
      DeleteFavoriteParams param) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.DELETE,
      queryParameters: param.toMap(),
      createModelInterceptor: const NullResponseModelInterceptor(),
      url: APIUrls.API_DELETE_FAVORITE,
    );
  }

  @override
  Future<Either<AppErrors, FavoritesModel>> getFavorites(
      GetFavoritesParams param) {
    return request(
        converter: (json) => FavoritesModel.fromMap(json),
        method: HttpMethod.GET,
        queryParameters: param.toMap(),
        url: APIUrls.API_GET_FAVORITES);
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> deleteFavoriteByRef(
      DeleteFavoriteByRefParams param) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.DELETE,
      queryParameters: param.toMap(),
      createModelInterceptor: const NullResponseModelInterceptor(),
      url: APIUrls.API_DELETE_FAVORITE_BY_REF_TYPE_ID,
    );
    
  }
}
