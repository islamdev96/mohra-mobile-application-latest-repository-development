import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/common/extensions/either_error_model_extension.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/like/data/model/request/like_request.dart';
import 'package:starter_application/features/like/data/model/response/like_model.dart';
import 'package:starter_application/features/like/domain/entity/like_entity.dart';

import '../datasource/../../domain/repository/ilike_repository.dart';
import '../datasource/ilike_remote.dart';

@Singleton(as: ILikeRepository)
class LikeRepository extends ILikeRepository {
  final ILikeRemoteSource iLikeRemoteSource;

  LikeRepository(this.iLikeRemoteSource);

  @override
  Future<Result<AppErrors, LikeEntity>> like(LikeRequest param) async {
    Either<AppErrors, LikeModel> remoteResult =
        await iLikeRemoteSource.like(param);
    return remoteResult.result<LikeEntity>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> unlike(LikeRequest param) async {
    Either<AppErrors, EmptyResponse> remoteResult =
        await iLikeRemoteSource.unlike(param);
    return remoteResult.result<EmptyResponse>();
  }
}
