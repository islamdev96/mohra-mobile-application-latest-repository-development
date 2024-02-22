import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/constants/enums/http_method.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/net/api_url.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/features/notification/data/model/request/delete_notification.dart';
import 'package:starter_application/features/notification/data/model/response/notification_resopnse_model.dart';

import 'inotification_remote.dart';

@Singleton(as: INotificationRemoteSource)
class NotificationRemoteSource extends INotificationRemoteSource {
  @override
  Future<Either<AppErrors, NotificationResultModel>> getAllNotification(params) {
    return request(
      converter: (json) => NotificationResultModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.API_AllNotification,
      cancelToken: params.cancelToken,
      queryParameters: params.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> deleteAllMyNotification(NoParams params) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.DELETE,
      url: APIUrls.DeleteAllMyNotification,
      cancelToken: params.cancelToken,
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> deleteNotificationById(DeleteNotificationParams params) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.DELETE,
      url: APIUrls.DeleteNotificationById,
      cancelToken: params.cancelToken,
      queryParameters: params.toMap(),
    );
  }
}
