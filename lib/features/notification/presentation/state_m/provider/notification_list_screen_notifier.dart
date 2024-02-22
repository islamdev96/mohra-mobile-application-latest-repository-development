import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/bloc/global/glogal_cubit.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/constants/enums/notification_type.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';
import 'package:starter_application/features/notification/data/model/request/delete_notification.dart';
import 'package:starter_application/features/notification/data/model/request/get_all_notification_param.dart';
import 'package:starter_application/features/notification/domain/entity/notification_entity.dart';
import 'package:starter_application/features/notification/domain/usecase/get_all_notification_usecase.dart';
import 'package:starter_application/features/notification/presentation/state_m/cubit/notification_cubit.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';

class NotificationListScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  NotificationCubit notificationCubit= NotificationCubit();
  final RefreshController momentsRefreshController = RefreshController();
  List<NotificationEntity> _notifications = [];
  bool isLoading = true;
  /// Getters and Setters
  List<NotificationEntity> get notifications => this._notifications;
  /// Methods
  //Methods
  void getNotifications() {
    notificationCubit.getNotifications(GetAllNotificationParam(maxResultCount: 10));
  }

  void deleteAllMyNotification() {
    notificationCubit.deleteAllMyNotification(NoParams());
  }

  void deleteNotificationById(String id) {
    notificationCubit.deleteNotificationById(DeleteNotificationParams(id: id));
  }


  void notifyWhenDeleteAll(){
    notifications.clear();
  }
  void onNotificationsItemsFetched(List<NotificationEntity> items, int nextUnit) {
    int unread = 0;
    items.forEach((element) {
      if(element.state == 0){
        unread++;
      }
    });
    // if(unread>0)
    BlocProvider.of<GlogalCubit>(AppConfig().appContext, listen: false).devNotificationsNumber(unread);
    // _notifications.clear();
    // items.forEach((element) {
    //   if(element.notificationType != 9){
    //     _notifications.add(element);
    //   }
    // });
    _notifications = items;
    notifyListeners();
  }

  void NotificationsLoaded(NotificationResultEntity momentEntity) {
    int unread = 0;
    momentEntity.items!.forEach((element) {
      if(element.state == 0){
        unread++;
      }
    });
    // if(unread>0)
      BlocProvider.of<GlogalCubit>(AppConfig().appContext, listen: false).devNotificationsNumber(unread);
    // momentEntity.items!.forEach((element) {
    //   if(element.notificationType != 9){
    //     _notifications.add(element);
    //   }
    // });
    _notifications = momentEntity.items!;
    notifyListeners();
  }

  void loading(value) {
    isLoading = value;
    notifyListeners();
  }

  Future<Result<AppErrors, List<NotificationEntity>>> getNotificationsItems(
      int unit) async {
    final result = await getIt<GetAllNotificationUsecase>()(GetAllNotificationParam(
      skipCount: unit * 10,
      maxResultCount: 10,
    ));

    return Result<AppErrors, List<NotificationEntity>>(
        data: result.data?.items, error: result.error);
  }



  @override
  void closeNotifier() {
    this.dispose();
  }
}
