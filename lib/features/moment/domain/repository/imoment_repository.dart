import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/moment/data/model/request/create_post_param.dart';
import 'package:starter_application/features/moment/data/model/request/find_place_param.dart';
import 'package:starter_application/features/moment/data/model/request/get_all_moments_request.dart';
import 'package:starter_application/features/moment/data/model/request/get_client_points_request.dart';
import 'package:starter_application/features/moment/domain/entity/find_place_result_list_entity.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';
import 'package:starter_application/features/moment/domain/entity/points_entity.dart';

import '../../../../core/repositories/repository.dart';
import '../../data/model/request/delete_post_param.dart';
import '../../data/model/request/report_post_param.dart';

abstract class IMomentRepository extends Repository {
  Future<Result<AppErrors, MomentEntity>> getMoments(GetMomentsRequest param);
  Future<Result<AppErrors, PointsEntity>> getPoints(
      GetClientPointsRequest param);
  Future<Result<AppErrors, EmptyResponse>> createPost(
      CreateEditPostParam param);

  Future<Result<AppErrors, FindPlaceResultListEntity>> findPlace(
      FindPlaceParam param);

  Future<Result<AppErrors, EmptyResponse>> editPost(CreateEditPostParam param);
  Future<Result<AppErrors, EmptyResponse>> deletePost(DeletePostParam param);
  Future<Result<AppErrors, EmptyResponse>> reportPost(ReportPostParam param);
}
