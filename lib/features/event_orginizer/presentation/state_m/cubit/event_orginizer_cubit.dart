import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:starter_application/features/event/data/model/request/get_my_running_events_param.dart';
import 'package:starter_application/features/event/data/model/request/scan_ticket_qr_code_param.dart';
import 'package:starter_application/features/event/domain/entity/event_categories_entity.dart';
import 'package:starter_application/features/event/domain/usecase/get_event_categories_usecase.dart';
import 'package:starter_application/features/event/domain/usecase/scan_ticket_qr_code_usecase.dart';
import 'package:starter_application/features/event_orginizer/data/model/request/search_event_params.dart';
import 'package:starter_application/features/event_orginizer/domain/entity/get_ticket_report_response_entity.dart';
import 'package:starter_application/features/event_orginizer/domain/entity/my_running_events_entity.dart';
import 'package:starter_application/features/event_orginizer/domain/usecase/get_my_running_events_usecase.dart';
import 'package:starter_application/features/event_orginizer/domain/usecase/get_ticket_details_usecase.dart';
import 'package:starter_application/features/event_orginizer/domain/usecase/get_ticket_report_usecase.dart';
import 'package:starter_application/features/event_orginizer/domain/usecase/search_my_running_events_usecase.dart';
import 'package:starter_application/features/notification/data/model/request/get_all_notification_param.dart';
import '../../../../../core/errors/app_errors.dart';
import '../../../../../core/params/no_params.dart';
import '../../../../../di/service_locator.dart';
import '../../../../event/data/model/request/get_event_ticket_request.dart';
import '../../../../event/domain/entity/event_ticket_entity.dart';
import '../../../data/model/request/event_details_params.dart';
import '../../../data/model/request/manual_event_check_params.dart';
import '../../../domain/entity/event_tickets_entity.dart';
import '../../../domain/usecase/get_event_ticketss_usecase.dart';
import '../../../domain/usecase/manual_check_ticketusecase.dart';


part 'event_orginizer_state.dart';

part 'event_orginizer_cubit.freezed.dart';

class EventOrginizerCubit extends Cubit<EventOrginizerState> {

  EventOrginizerCubit() : super(const EventOrginizerState.eventOrginizerInitState());
  getMyRunningEvents(GetMyRunningEventsParam param) async {
    emit(const EventOrginizerState.eventOrginizerLoadingState());
    final result = await getIt<GetMyRunningEventsUseCase>()(param);
    result.pick(
      onData: (data) => emit(EventOrginizerState.eventsLoaded(data)),
      onError: (error) => emit(EventOrginizerState.eventOrginizerErrorState(error, () {
        this.getMyRunningEvents(param);
      })),
    );
  }

  searchMyRunningEvents(SearchEventParams param) async {
    emit(const EventOrginizerState.eventOrginizerLoadingState());
    final result = await getIt<SearchMyRunningEventsUseCase>()(param);
    result.pick(
      onData: (data) => emit(EventOrginizerState.eventsLoaded(data)),
      onError: (error) => emit(EventOrginizerState.eventOrginizerErrorState(error, () {
        this.searchMyRunningEvents(param);
      })),
    );
  }

  getEventTicketss(GetEventTicketsParam param) async {
    emit(const EventOrginizerState.eventTicketsLoading());
    final result = await getIt<GetEventTicketssUseCase>()(param);
    result.pick(
      onData: (data) => emit(EventOrginizerState.eventTicketsLoaded(data)),
      onError: (error) => emit(EventOrginizerState.eventOrginizerErrorState(error, () {
        this.getEventTicketss(param);
      })),
    );
  }
  getTicketDetails(GetEventTicketRequest param) async {
    emit(const EventOrginizerState.eventOrginizerLoadingState());
    final result = await getIt<GetTicketDetailsUsecase>()(param);
    result.pick(
      onData: (data) => emit(EventOrginizerState.getTicketDetailsDone(data)),
      onError: (error) => emit(EventOrginizerState.eventOrginizerErrorState(error, () {
        this.getTicketDetails(param);
      })),
    );
  }
  manualCheckTicket(ManualCheckEventParams param) async {
    emit(const EventOrginizerState.manualCheckTicket());
    final result = await getIt<ManualCheckTicketUsecase>()(param);
    result.pick(
      onData: (data) => emit(const EventOrginizerState.manualCheckTicketDone()),
      onError: (error) => emit(EventOrginizerState.eventOrginizerErrorState(error, () {
        this.manualCheckTicket(param);
      })),
    );
  }

  void getCategories(NoParams params) async {
    emit(const EventOrginizerState.eventOrginizerLoadingState());
      final result = await getIt<GetEventCategoriesUseCase>().call(params);
      result.pick(
          onData: (data) {
            emit(EventOrginizerState.eventCategoriesLoadedState(data));
          },
          onError: (error) => emit(
            EventOrginizerState.eventOrginizerErrorState(error, () {
              this.getCategories( params);
            }),
          ));
  }

  void getTicketReport( EventDetailsParams param) async {
    emit(const EventOrginizerState.eventOrginizerLoadingState());
    final result = await getIt<GetTicketReportUsecase>().call(param);
    result.pick(
        onData: (data) {
          emit( EventOrginizerState.getTicketReport(data));
        },
        onError: (error) => emit(
          EventOrginizerState.eventOrginizerErrorState(error, () {
            this.getTicketReport( param);
          }),
        ));
  }

  void scanTicketQrCode( ScanTicketQrCodeParam param) async {
    emit(const EventOrginizerState.eventOrginizerLoadingState());
    final result = await getIt<ScanTicketQrCodeUseCase>().call(param);
    result.pick(
        onData: (data) {
          emit(const EventOrginizerState.scanTicketQrCode());
        },
        onError: (error) => emit(
          EventOrginizerState.eventOrginizerErrorState(error, () {
            this.scanTicketQrCode( param);
          }),
        ));
  }
 
}
