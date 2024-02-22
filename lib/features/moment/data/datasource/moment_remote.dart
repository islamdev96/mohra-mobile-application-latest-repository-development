import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/constants/enums/http_method.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/net/api_url.dart';
import 'package:starter_application/core/net/create_model_interceptor/all_data_create_model_inteceptor.dart';
import 'package:starter_application/core/net/response_validators/google_search_validator.dart';
import 'package:starter_application/features/moment/data/model/request/create_post_param.dart';
import 'package:starter_application/features/moment/data/model/request/delete_post_param.dart';
import 'package:starter_application/features/moment/data/model/request/find_place_param.dart';
import 'package:starter_application/features/moment/data/model/request/get_all_moments_request.dart';
import 'package:starter_application/features/moment/data/model/request/get_client_points_request.dart';
import 'package:starter_application/features/moment/data/model/request/report_post_param.dart';
import 'package:starter_application/features/moment/data/model/response/find_place_result_list_model.dart';
import 'package:starter_application/features/moment/data/model/response/moment_model.dart';
import 'package:starter_application/features/moment/data/model/response/points_model.dart';

import 'imoment_remote.dart';

@Singleton(as: IMomentRemoteSource)
class MomentRemoteSource extends IMomentRemoteSource {
  @override
  Future<Either<AppErrors, MomentModel>> getMoments(GetMomentsRequest param) {
    return request(
      converter: (json) => MomentModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.getMoments,
      cancelToken: param.cancelToken,
      queryParameters: param.toMap(),
    );
  }

  Future<Either<AppErrors, PointsModel>> getPoints(
      GetClientPointsRequest param) {
    return request(
      converter: (json) => PointsModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.getPoints,
      cancelToken: param.cancelToken,
      queryParameters: param.toMap(),
      createModelInterceptor: const AllDataCreateModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> createPost(
      CreateEditPostParam param) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      //TODO UNCOMMENT
      url: param.challengeId == null
          ? APIUrls.createPost
          : APIUrls.API_VERIFY_CHALLENGE,
      // url: param.challengeId == null ? APIUrls.createPost : APIUrls.createPost,
      cancelToken: param.cancelToken,
      body: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> editPost(CreateEditPostParam param) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.PUT,
      url: APIUrls.editPost,
      cancelToken: param.cancelToken,
      body: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, FindPlaceResultListModel>> findPlace(
      FindPlaceParam param) {
    return request(
      converter: (json) => FindPlaceResultListModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.FIND_PLACE_URL,
      cancelToken: param.cancelToken,
      queryParameters: param.toMap(),
      responseValidator: GoogleSearchValidator(),
      createModelInterceptor: const AllDataCreateModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> deletePost(DeletePostParam param) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.DELETE,
      url: APIUrls.deletePost,
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> reportPost(ReportPostParam param) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      url: APIUrls.reportPost,
      body: param.toMap(),
    );
  }
}
