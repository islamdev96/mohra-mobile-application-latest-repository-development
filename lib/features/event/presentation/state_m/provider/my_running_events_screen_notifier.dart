import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/event_details_screen_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/event/data/model/request/get_my_running_events_param.dart';
import 'package:starter_application/features/event/domain/entity/my_running_events_list_entity.dart';
import 'package:starter_application/features/event/presentation/screen/event_details_screen.dart';
import 'package:starter_application/features/event/presentation/state_m/cubit/event_cubit.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class MyRunningEventsScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  EventCubit eventCubit = EventCubit();
  List<MyRunningEventEntity> events = [];
  RefreshController refreshController = RefreshController();

  /// Getters and Setters

  /// Methods
  getEvents() {
    eventCubit.getMyRunningEvents(getRequest(0));
  }

  Future<Result<AppErrors, List<MyRunningEventEntity>>> returnData(
      int unit) async {
    return eventCubit.returnMyRunningEvents(
      getRequest(unit),
    );
  }

  GetMyRunningEventsParam getRequest(int unit) {
    return GetMyRunningEventsParam(maxResultCount: 10, skipCount: unit * 10);
  }

  gotoEventDetails(int eventId) {
    //Todo
    Nav.to(
      EventDetailsScreen.routeName,
      arguments: EventDetailsScreenParams(
        sharedId: eventId,
      ),
    );
  }

  void onDataFetched(List<MyRunningEventEntity> items, int nextUnit) {
    events = items;
    notifyListeners();
  }

  @override
  void closeNotifier() {
    this.dispose();
  }
}
