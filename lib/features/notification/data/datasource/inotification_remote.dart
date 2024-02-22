import 'package:dartz/dartz.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/features/mylife/data/model/request/delete_dream_params.dart';
import 'package:starter_application/features/notification/data/model/request/delete_notification.dart';
import 'package:starter_application/features/notification/data/model/request/get_all_notification_param.dart';
import 'package:starter_application/features/notification/data/model/response/notification_resopnse_model.dart';
import '../../../../core/datasources/remote_data_source.dart';

abstract class INotificationRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, NotificationResultModel>> getAllNotification(GetAllNotificationParam params);
  Future<Either<AppErrors, EmptyResponse>> deleteNotificationById(DeleteNotificationParams params);
  Future<Either<AppErrors, EmptyResponse>> deleteAllMyNotification(NoParams params);
}
