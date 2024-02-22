import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/notification/data/model/request/delete_notification.dart';
import 'package:starter_application/features/notification/data/model/request/get_all_notification_param.dart';
import 'package:starter_application/features/notification/domain/entity/notification_entity.dart';
import 'package:starter_application/features/notification/domain/usecase/delete_all_notification_usecase.dart';
import 'package:starter_application/features/notification/domain/usecase/delete_by_id_notification_usecase.dart';
import 'package:starter_application/features/notification/domain/usecase/get_all_notification_usecase.dart';
import 'package:starter_application/features/notification/presentation/state_m/provider/notification_list_screen_notifier.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  getNotifications(GetAllNotificationParam params) async {
    emit(NotificationLoading());
    final result = await getIt<GetAllNotificationUsecase>()(params);
    result.pick(
        onData: (data) => emit(NotificationLoaded(data)),
        onError: (error) => emit(
          NotificationError(
              error, () => this.getNotifications(params)),
        ));
  }


  deleteAllMyNotification(NoParams params) async {
    emit(NotificationLoading());
    final result = await getIt<DeleteAllNotificationUsecase>()(params);
    result.pick(
        onData: (data) {
          emit(NotificationLoaded(NotificationResultEntity(totalCount: 0,items: [])));
        },
        onError: (error) => emit(
          NotificationError(
              error, () => this.deleteAllMyNotification(params)),
        ));
  }


  deleteNotificationById(DeleteNotificationParams params) async {
    emit(NotificationLoading());
    final result = await getIt<DeleteByIdNotificationUsecase>()(params);
    result.pick(
        onData: (data) {
          emit(DeleteNotification());
          getNotifications(GetAllNotificationParam());
        },
        onError: (error) => emit(
          NotificationError(
              error, () => this.deleteNotificationById(params)),
        ));
  }


}
