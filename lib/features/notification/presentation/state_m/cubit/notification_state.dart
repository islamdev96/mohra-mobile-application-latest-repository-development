part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}


class NotificationLoading extends NotificationState {}


class NotificationLoaded extends NotificationState {
   final NotificationResultEntity notificationResultEntity;

  NotificationLoaded(this.notificationResultEntity);
}


class NotificationError extends NotificationState {
  late final AppErrors error;
  late final VoidCallback callback;
  NotificationError(this.error,this.callback);
}

class DeleteNotification extends NotificationState {}

class DeleteAllNotification extends NotificationState {}