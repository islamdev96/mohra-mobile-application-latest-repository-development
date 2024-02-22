import 'package:dartz/dartz.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import '../../core/models/base_model.dart';
import '../entities/base_entity.dart';
import '../results/result.dart';

abstract class Repository {
  @deprecated
  Result<AppErrors, Entity>
      execute<Model extends BaseModel<Entity>, Entity extends BaseEntity>(
          {required Either<AppErrors, Model> remoteResult}) {
    if (remoteResult.isRight()) {
      return Result(
        data: (remoteResult as Right<AppErrors, Model>).value.toEntity(),
      );
    } else {
      return Result(error: (remoteResult as Left<AppErrors, Model>).value);
    }
  }
  @deprecated
  Result<AppErrors, T> executeForNoEntity<T>({
    required Either<AppErrors, T> remoteResult,
  }) {
    if (remoteResult.isRight()) {
      return Result(
        data: (remoteResult as Right<AppErrors, T>).value,
      );
    } else {
      return Result(error: (remoteResult as Left<AppErrors, T>).value);
    }
  }
  @deprecated
  Result<AppErrors, List<Entity?>> executeForList<
          Model extends BaseModel<Entity>, Entity extends BaseEntity>(
      {required Either<AppErrors, Entity> remoteResult}) {
    if (remoteResult.isRight()) {
      return Result(
        data: (remoteResult as Right<AppErrors, List<Model>>)
            .value
            .map((model) => model.toEntity())
            .toList(),
      );
    } else {
      return Result(
        error: (remoteResult as Left<AppErrors, List<Model>>).value,
      );
    }
  }
  @deprecated
  Result<AppErrors, Object> executeForNoData({
    required Either<AppErrors, Object> remoteResult,
  }) {
    if (remoteResult.isRight()) {
      return Result(data: (remoteResult as Right<AppErrors, Object>).value);
    } else {
      return Result(error: (remoteResult as Left<AppErrors, Object>).value);
    }
  }
  @deprecated
  Result<AppErrors, List<Entity>>
      listExecute<Model extends BaseModel<Entity>, Entity extends BaseEntity>(
          {required Either<AppErrors, List<Model>> remoteResult}) {
    if (remoteResult.isRight()) {
      return Result(
        data: (remoteResult as Right<AppErrors, List<Model>>)
            .value
            .map((e) => e.toEntity())
            .toList(),
      );
    } else {
      return Result(error: (remoteResult as Left<AppErrors, List<Model>>).value);
    }
  }
}
