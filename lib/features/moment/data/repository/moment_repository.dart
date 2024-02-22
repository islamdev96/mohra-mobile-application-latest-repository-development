import 'package:injectable/injectable.dart';
import 'package:starter_application/core/common/extensions/either_error_model_extension.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/moment/data/model/request/create_post_param.dart';
import 'package:starter_application/features/moment/data/model/request/delete_post_param.dart';
import 'package:starter_application/features/moment/data/model/request/find_place_param.dart';
import 'package:starter_application/features/moment/data/model/request/get_all_moments_request.dart';
import 'package:starter_application/features/moment/data/model/request/get_client_points_request.dart';
import 'package:starter_application/features/moment/data/model/request/report_post_param.dart';
import 'package:starter_application/features/moment/domain/entity/find_place_result_list_entity.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';
import 'package:starter_application/features/moment/domain/entity/points_entity.dart';

import '../datasource/../../domain/repository/imoment_repository.dart';
import '../datasource/imoment_remote.dart';

@Singleton(as: IMomentRepository)
class MomentRepository extends IMomentRepository {
  final IMomentRemoteSource iMomentRemoteSource;

  MomentRepository(this.iMomentRemoteSource);

  @override
  Future<Result<AppErrors, MomentEntity>> getMoments(
      GetMomentsRequest param) async {
    final remoteResult = await iMomentRemoteSource.getMoments(param);
    return remoteResult.result<MomentEntity>();
  }

  @override
  Future<Result<AppErrors, PointsEntity>> getPoints(
      GetClientPointsRequest param) async {
    final remoteResult = await iMomentRemoteSource.getPoints(param);
    return remoteResult.result<PointsEntity>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> createPost(
      CreateEditPostParam param) async {
    final remoteResult = await iMomentRemoteSource.createPost(param);
    return remoteResult.result<EmptyResponse>();
  }
  @override
  Future<Result<AppErrors, EmptyResponse>> editPost(
      CreateEditPostParam param) async {
    final remoteResult = await iMomentRemoteSource.editPost(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, FindPlaceResultListEntity>> findPlace(
      FindPlaceParam param) async {
    final remoteResult = await iMomentRemoteSource.findPlace(param);
    return remoteResult.result<FindPlaceResultListEntity>();
  }



  @override
  Future<Result<AppErrors, EmptyResponse>> deletePost(DeletePostParam param) async{
    final remoteResult = await iMomentRemoteSource.deletePost(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> reportPost(ReportPostParam param) async{
    final remoteResult = await iMomentRemoteSource.reportPost(param);
    return remoteResult.result<EmptyResponse>();
  }
}
