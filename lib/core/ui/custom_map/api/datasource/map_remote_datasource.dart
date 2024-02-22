import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/ui/custom_map/api/model/map_distance_model.dart';
import 'package:starter_application/core/ui/custom_map/api/params/map_distance_params.dart';

class MapRemoteDataSource {
  final Dio dio = new Dio();

  Future<Either<AppErrors, MapDistanceModel>> getDistance(
      MapDistanceParam param) async {
    try {
      /// Specify the headers.
      final Map<String, dynamic> headers = {};

      Response response = await dio.get(
        /// Remove this from AppConstants
        AppConstants.API_MAP_DISTANCE,
        queryParameters: param.toMap(),
        options: Options(
          headers: headers,
        ),
      );

      return Right(
        MapDistanceModel.fromMap(response.data),
      );
    }

    /// Handling errors
    on DioError catch (e) {
      return Left(_handleDioError(e));
    }

    /// Couldn't reach out the server
    on SocketException catch (_) {
      return const Left(SocketError());
    }
  }
}

AppErrors _handleDioError(DioException error) {
  if (error.type == DioExceptionType.unknown || error.type == DioExceptionType.badResponse) {
    if (error.error is SocketException)
      return const SocketError();
    else if (error.type == DioExceptionType.badResponse) {
      switch (error.response!.statusCode) {
        case 400:
          if (error.response?.data == null)
            return const BadRequestError();
          else {
            return const BadRequestError(
              message: "error performing action",
            );
          }
        case 401:
          return const UnauthorizedError();
        case 403:
          return const ForbiddenError();
        case 404:
          return NotFoundError(error.requestOptions.path);
        case 409:
          return const ConflictError();
        case 500:
          if (error.response!.data is Map<String, dynamic>) {
            if (error.response!.data["errorCode"] != null) {
              return AppErrors.internalServerWithDataError(
                int.parse(error.response!.data["errorCode"].toString()),
                message: error.response!.data["message"],
              );
            } else if (error.response?.data["message"] == null) {
              return const InternalServerError();
            } else if (error.response?.data["data"] == null) {
              return CustomError(message: error.response!.data["message"]);
            } else if (error.response?.data["message"] != null) {
              return CustomError(message: error.response!.data["message"]);
            }
          } else {
            return const InternalServerError();
          }
          break;
        default:
          return const AppErrors.netError();
      }
    }
  } else if (error.type == DioExceptionType.connectionTimeout ||
      error.type == DioExceptionType.sendTimeout ||
      error.type == DioExceptionType.receiveTimeout) {
    return const TimeoutError();
  } else if (error.type == DioExceptionType.cancel) {
    return const CancelError("The rquest has been canceld");
  }
  return const UnknownError();
}
