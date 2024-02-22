import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/like/data/model/request/like_request.dart';
import 'package:starter_application/features/like/domain/entity/like_entity.dart';

import '../../../../core/repositories/repository.dart';

abstract class ILikeRepository extends Repository {
  Future<Result<AppErrors, LikeEntity>> like(LikeRequest param);
  Future<Result<AppErrors, EmptyResponse>> unlike(LikeRequest param);
}
