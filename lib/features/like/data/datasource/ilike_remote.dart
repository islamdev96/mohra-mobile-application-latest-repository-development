import 'package:dartz/dartz.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/features/like/data/model/request/like_request.dart';
import 'package:starter_application/features/like/data/model/response/like_model.dart';

import '../../../../core/datasources/remote_data_source.dart';

abstract class ILikeRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, LikeModel>> like(LikeRequest param);
  Future<Either<AppErrors, EmptyResponse>> unlike(LikeRequest param);
}
