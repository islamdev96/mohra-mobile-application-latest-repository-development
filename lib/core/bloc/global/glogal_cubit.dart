import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/global_messages_notifier.dart';

import '../../../di/service_locator.dart';
import '../../../features/home/presentation/state_m/provider/app_main_screen_notifier.dart';
import '../../datasources/shared_preference.dart';

part 'glogal_state.dart';

class GlogalCubit extends Cubit<GlogalState> {
  GlogalCubit() : super(GlogalInitial());

  static int countMessegesUnreaded = 0;
  static int number = 0;
  static int countNotificaionsUnreaded = 0;

  bool isAuth = false;

  changeNumber(int newNumber, {bool isMessages = true}) {
    if (isMessages) setNumber(newNumber);
    emit(GlogalChanged(
        numberMessages: getNumber(),
        numberNotificaions: countNotificaionsUnreaded));
  }

  changeNotificationsNumber() {
    countNotificaionsUnreaded += 1;
    emit(GlogalChanged(
        numberNotificaions: countNotificaionsUnreaded, numberMessages: number));
  }

  devNotificationsNumber(int i) {
    countNotificaionsUnreaded -= i;
    if (countNotificaionsUnreaded < 0) {
      countNotificaionsUnreaded = 0;
    }
    emit(GlogalChanged(numberNotificaions: 0, numberMessages: number));
  }

  clearNotification() {
    emit(GlogalChanged(numberNotificaions: 0, numberMessages: number));
  }

  setNotificationsNumber(int i) {
    countNotificaionsUnreaded += i;
    emit(GlogalChanged(
        numberNotificaions: countNotificaionsUnreaded, numberMessages: number));
  }

  refreshNumber() {
    emit(GlogalChanged(
        numberMessages: 0, numberNotificaions: countNotificaionsUnreaded));
  }

  refreshNotificationsNumber() {
    countNotificaionsUnreaded = 0;
    emit(GlogalChanged(numberNotificaions: 0, numberMessages: number));
  }

  initNumber() {
    int number = 0;
    Provider.of<GlobalMessagesNotifier>(AppConfig().appContext, listen: false)
        .conversations
        .forEach((element) async {
      number += element.conversationEntity?.countMessegesUnreaded ?? 0;
      changeNumber(number);
    });
  }

  setNumber(int newNumber) {
    number = newNumber;
  }

  getNumber() {
    return number;
  }

  getCall() async {}

  Future<bool> get isUserAuthenticated async => await AppConfig().hasToken;

  getAuth() async {
    isAuth = await AppConfig().hasToken;
  }

  updateIsAuth() {
    isAuth = false;
  }
}
