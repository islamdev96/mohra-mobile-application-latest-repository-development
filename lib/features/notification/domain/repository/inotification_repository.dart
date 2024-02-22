import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/news/domain/entity/news_of_category_entity.dart';
import 'package:starter_application/features/notification/data/model/request/delete_notification.dart';
import 'package:starter_application/features/notification/data/model/request/get_all_notification_param.dart';
import 'package:starter_application/features/notification/domain/entity/notification_entity.dart';

import '../../../../core/repositories/repository.dart';

abstract class INotificationRepository extends Repository {

  Future<Result<AppErrors, NotificationResultEntity>> getAllNotification(GetAllNotificationParam param);
  Future<Result<AppErrors, EmptyResponse>> deleteNotificationById(DeleteNotificationParams params);
  Future<Result<AppErrors, EmptyResponse>> deleteAllMyNotification(NoParams params);
}
