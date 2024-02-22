import 'package:dartz/dartz.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/features/moment/data/model/request/create_post_param.dart';
import 'package:starter_application/features/moment/data/model/request/find_place_param.dart';
import 'package:starter_application/features/moment/data/model/request/get_all_moments_request.dart';
import 'package:starter_application/features/moment/data/model/request/get_client_points_request.dart';
import 'package:starter_application/features/moment/data/model/response/find_place_result_list_model.dart';
import 'package:starter_application/features/moment/data/model/response/moment_model.dart';
import 'package:starter_application/features/moment/data/model/response/points_model.dart';

import '../../../../core/datasources/remote_data_source.dart';
import '../model/request/delete_post_param.dart';
import '../model/request/report_post_param.dart';

abstract class IMomentRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, MomentModel>> getMoments(GetMomentsRequest param);
  Future<Either<AppErrors, PointsModel>> getPoints(
      GetClientPointsRequest param);

  Future<Either<AppErrors, EmptyResponse>> createPost(
      CreateEditPostParam param);
  Future<Either<AppErrors, EmptyResponse>> editPost(
      CreateEditPostParam param);

  Future<Either<AppErrors, FindPlaceResultListModel>> findPlace(
      FindPlaceParam param);
  Future<Either<AppErrors, EmptyResponse>> deletePost(
      DeletePostParam param);
  Future<Either<AppErrors, EmptyResponse>> reportPost(
      ReportPostParam param);


}
