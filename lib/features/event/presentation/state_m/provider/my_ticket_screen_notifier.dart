import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/ticket_details_screen_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/event/data/model/request/get_event_tickets_request.dart';
import 'package:starter_application/features/event/domain/entity/my_tickets_entity.dart';
import 'package:starter_application/features/event/presentation/screen/ticket_details_screen.dart';
import 'package:starter_application/features/event/presentation/state_m/cubit/event_cubit.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class MyTicketScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  EventCubit eventCubit = EventCubit();
  List<MyTicketsEntity> tickets = [];
  RefreshController refreshController = RefreshController();

  /// Getters and Setters

  /// Methods
  getTickets() {
    eventCubit.getTickets(getRequest(0));
  }

  Future<Result<AppErrors, List<MyTicketsEntity>>> returnData(int unit) async {
    return eventCubit.returnTickets(
      getRequest(unit),
    );
  }

  GetEventsTicketsRequest getRequest(int unit) {
    return GetEventsTicketsRequest(maxResultCount: 10, skipCount: unit * 10);
  }

  gotoTicketDetails(MyTicketsEntity myTicketsEntity) {
    Nav.to(TicketDetailsScreen.routeName,
        arguments: TicketDetailsScreenParams(myTicketsEntity: myTicketsEntity , id: myTicketsEntity.tickets.first.id));
  }

  void onDataFetched(List<MyTicketsEntity> items, int nextUnit) {
    tickets = items;
    notifyListeners();
  }

  @override
  void closeNotifier() {
    this.dispose();
  }
}
