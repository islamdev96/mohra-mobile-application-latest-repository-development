import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:starter_application/core/entities/base_entity.dart';

import '../../errors/app_errors.dart';
import '../../models/base_model.dart';
import '../../models/empty_response.dart';
import '../../results/result.dart';

//! Not stable yet (Need testing)

extension eitherErrorModel<Error extends AppErrors, Entity extends BaseEntity,
    Model extends BaseModel<Entity>> on Either<Error, Model> {
  Result<AppErrors, T> result<T>() {
    try {
      if (this.isRight()) {
        /// If EmptyResponse
        if (T == EmptyResponse &&
            (this as Right<Error, Model>).value is EmptyResponse)
          return Result(data: (this as Right<Error, Model>).value as T);

        /// If T is Entity
        else if (<T>[] is List<BaseEntity>) {
          final model = (this as Right<Error, Model>).value;
          return Result(data: model.toEntity() as T);

          /// If T not Entity
        } else {
          return Result(data: (this as Right<Error, Model>).value as T);
        }
      } else
        return Result(error: (this as Left<Error, Model>).value);
    } catch (e) {
      log(e.toString());
      return Result(
        error: CustomError(
          message: e.toString(),
        ),
      );
    }
  }
}
