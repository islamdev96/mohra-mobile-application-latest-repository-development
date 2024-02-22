import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:provider/src/provider.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/event/data/model/request/create_ticket_request.dart';
import 'package:starter_application/features/event/data/model/request/get_all_events_request.dart';
import 'package:starter_application/features/event/data/model/request/get_event_request.dart';
import 'package:starter_application/features/event/data/model/request/get_event_ticket_request.dart';
import 'package:starter_application/features/event/data/model/request/get_event_tickets_request.dart';
import 'package:starter_application/features/event/data/model/request/get_my_running_events_param.dart';
import 'package:starter_application/features/event/data/model/request/scan_ticket_qr_code_param.dart';
import 'package:starter_application/features/event/domain/entity/create_event_ticket_entity.dart';
import 'package:starter_application/features/event/domain/entity/event_categories_entity.dart';
import 'package:starter_application/features/event/domain/entity/event_entity.dart';
import 'package:starter_application/features/event/domain/entity/event_ticket_entity.dart';
import 'package:starter_application/features/event/domain/entity/event_tickets_entity.dart';
import 'package:starter_application/features/event/domain/entity/events_entity.dart';
import 'package:starter_application/features/event/domain/entity/my_running_events_list_entity.dart';
import 'package:starter_application/features/event/domain/entity/my_tickets_entity.dart';
import 'package:starter_application/features/event/domain/usecase/create_event_ticket_usecase.dart';
import 'package:starter_application/features/event/domain/usecase/get_all_events_usecase.dart';
import 'package:starter_application/features/event/domain/usecase/get_event_categories_usecase.dart';
import 'package:starter_application/features/event/domain/usecase/get_event_ticket_usecase.dart';
import 'package:starter_application/features/event/domain/usecase/get_event_tickets_usecase.dart';
import 'package:starter_application/features/event/domain/usecase/get_event_usecase.dart';
import 'package:starter_application/features/event/domain/usecase/get_my_running_events_usecase.dart';
import 'package:starter_application/features/event/domain/usecase/scan_ticket_qr_code_usecase.dart';
import 'package:starter_application/features/event/presentation/state_m/provider/event_categories_screen_notifier.dart';

import '../../../../../core/errors/app_errors.dart';
import '../../../../../core/params/create_payment.dart';
import '../../../domain/usecase/check_if_can_pay_usecase.dart';
import '../../../domain/usecase/create_payment_usecase.dart';

part 'event_cubit.freezed.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit() : super(const EventState.eventInitState());

  void getEvents(GetEventsRequest params) async {
    emit(const EventState.eventLoadingState());

    final result = await getIt<GetEventsUseCase>().call(params);
    result.pick(
        onData: (data) => emit(EventState.eventsLoadedState(data)),
        onError: (error) => emit(
              EventState.eventErrorState(error, () {
                this.getEvents(params);
              }),
            ));
  }

  void getEvent(GetEventRequest params) async {
    emit(const EventState.eventLoadingState());

    final result = await getIt<GetEventUseCase>().call(params);
    result.pick(
        onData: (data) => emit(EventState.eventLoadedState(data)),
        onError: (error) => emit(
              EventState.eventErrorState(error, () {
                this.getEvent(params);
              }),
            ));
  }

  Future<Result<AppErrors, List<EventEntity>>> returnEvents(
      GetEventsRequest params) async {
    final result = await await getIt<GetEventsUseCase>().call(params);
    return Result(error: result.error, data: result.data?.items ?? []);
  }

  void getCategories(BuildContext context, NoParams params) async {
    emit(const EventState.eventLoadingState());
    if (context.read<EventCategoriesScreenNotifier>().eventCategoriesEntity !=
            null &&
        context
            .read<EventCategoriesScreenNotifier>()
            .eventCategoriesEntity!
            .items
            .isNotEmpty)
      emit(EventState.eventCategoriesLoadedState(context
          .read<EventCategoriesScreenNotifier>()
          .eventCategoriesEntity!));
    else {
      final result = await getIt<GetEventCategoriesUseCase>().call(params);
      result.pick(
          onData: (data) {
            Provider.of<EventCategoriesScreenNotifier>(context, listen: false)
                .eventCategoriesEntity = data;
            emit(EventState.eventCategoriesLoadedState(data));
          },
          onError: (error) => emit(
                EventState.eventErrorState(error, () {
                  this.getCategories(context, params);
                }),
              ));
    }
  }

  void createTicket(CreateEventTicketRequest params) async {
    emit(const EventState.eventLoadingState());

    final result = await getIt<CreateEventTicketUseCase>().call(params);
    result.pick(
        onData: (data) => emit(EventState.ticketCreatedState(data)),
        onError: (error) => emit(
              EventState.eventErrorState(error, () {
                this.createTicket(params);
              }),
            ));
  }

  void getTickets(GetEventsTicketsRequest params) async {
    emit(const EventState.eventLoadingState());

    final result = await getIt<GetEventTicketsUseCase>().call(params);
    result.pick(
        onData: (data) => emit(EventState.ticketsLoadedState(data)),
        onError: (error) => emit(
              EventState.eventErrorState(error, () {
                this.getTickets(params);
              }),
            ));
  }

  Future<Result<AppErrors, List<MyTicketsEntity>>> returnTickets(
      GetEventsTicketsRequest params) async {
    final result = await getIt<GetEventTicketsUseCase>()(params);
    return Result(error: result.error, data: result.data?.items ?? []);
  }

  void getTicket(GetEventTicketRequest params) async {
    emit(const EventState.eventLoadingState());

    final result = await getIt<GetEventTicketUseCase>().call(params);
    result.pick(
        onData: (data) => emit(EventState.ticketLoadedState(data)),
        onError: (error) => emit(
              EventState.eventErrorState(error, () {
                this.getTicket(params);
              }),
            ));
  }

  void getMyRunningEvents(GetMyRunningEventsParam params) async {
    emit(const EventState.eventLoadingState());

    final result = await getIt<GetMyRunningEventsUsecase>().call(params);
    result.pick(
        onData: (data) => emit(EventState.myRunningEventsLoaded(data)),
        onError: (error) => emit(
              EventState.eventErrorState(error, () {
                this.getMyRunningEvents(params);
              }),
            ));
  }

  Future<Result<AppErrors, List<MyRunningEventEntity>>> returnMyRunningEvents(
      GetMyRunningEventsParam params) async {
    final result = await getIt<GetMyRunningEventsUsecase>()(params);
    return Result(error: result.error, data: result.data?.items ?? []);
  }

  void scanTicketQrCode(ScanTicketQrCodeParam params) async {
    emit(const EventState.eventLoadingState());

    final result = await getIt<ScanTicketQrCodeUseCase>().call(params);
    result.pick(
        onData: (data) => emit(const EventState.scanTicketQrCodeLoaded()),
        onError: (error) => emit(
              EventState.eventErrorState(error, () {
                this.scanTicketQrCode(params);
              }),
            ));
  }

  void checkIfCanPay(CreateEventTicketRequest params) async {
    emit(const EventState.eventLoadingState());

    final result = await getIt<CheckIfCanPayUseCase>().call(params);
    result.pick(
        onData: (data) => emit(const EventState.canPaySuccess()),
        onError: (error) => emit(
              EventState.cantPaySuccess(error, () {
                this.checkIfCanPay(params);
              }),
            ));
  }

  void createPayment(CreatePaymentParam params) async {
    emit(const EventState.eventLoadingState());

    final result = await getIt<CreatePaymentUseCase>().call(params);
    result.pick(
        onData: (data) => emit(const EventState.createPaymentSuccess()),
        onError: (error) => emit(
              EventState.eventErrorState(error, () {
                this.createPayment(params);
              }),
            ));
  }
}
