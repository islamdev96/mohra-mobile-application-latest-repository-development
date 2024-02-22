import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/constants/enums/http_method.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/net/api_url.dart';
import 'package:starter_application/core/net/create_model_interceptor/null_response_model_interceptor.dart';
import 'package:starter_application/features/like/data/model/request/like_request.dart';
import 'package:starter_application/features/like/data/model/response/like_model.dart';

import 'ilike_remote.dart';

@Singleton(as: ILikeRemoteSource)
class LikeRemoteSource extends ILikeRemoteSource {
  @override
  Future<Either<AppErrors, LikeModel>> like(LikeRequest param) {
    return request(
        converter: (json) => LikeModel.fromMap(json),
        method: HttpMethod.POST,
        body: param.toMap(),
        url: APIUrls.API_LIKE);
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> unlike(LikeRequest param) {
    return request(
        converter: (json) => EmptyResponse.fromMap(json),
        method: HttpMethod.DELETE,
        createModelInterceptor: const NullResponseModelInterceptor(),
        queryParameters: param.toMap(),
        url: APIUrls.API_UNLIKE);
  }
}
