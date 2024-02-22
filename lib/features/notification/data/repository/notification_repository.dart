import 'package:injectable/injectable.dart';
import 'package:starter_application/core/common/extensions/either_error_model_extension.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/notification/data/model/request/delete_notification.dart';
import 'package:starter_application/features/notification/data/model/request/get_all_notification_param.dart';
import 'package:starter_application/features/notification/domain/entity/notification_entity.dart';
import '../datasource/../../domain/repository/inotification_repository.dart';
import '../datasource/inotification_remote.dart';

@Singleton(as: INotificationRepository)
class NotificationRepository extends INotificationRepository {
  final INotificationRemoteSource iNotificationRemoteSource;

  NotificationRepository(this.iNotificationRemoteSource);

  @override
  Future<Result<AppErrors, NotificationResultEntity>> getAllNotification(GetAllNotificationParam param)async {
    final remote = await iNotificationRemoteSource.getAllNotification(param);
    return remote.result<NotificationResultEntity>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> deleteAllMyNotification(NoParams params) async{
    final remote = await iNotificationRemoteSource.deleteAllMyNotification(params);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> deleteNotificationById(DeleteNotificationParams params) async{
    final remote = await iNotificationRemoteSource.deleteNotificationById(params);
    return remote.result<EmptyResponse>();
  }
}
