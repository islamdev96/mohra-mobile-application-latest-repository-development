part of 'event_orginizer_cubit.dart';

@freezed
class EventOrginizerState with _$EventOrginizerState {
  const factory EventOrginizerState.eventOrginizerInitState() = EventOrginizerInitState;

  const factory EventOrginizerState.eventOrginizerLoadingState() = EventOrginizerLoadingState;
  const factory EventOrginizerState.eventTicketsLoading() = EventTicketsLoading;
  const factory EventOrginizerState.eventCategoriesLoadedState(
      EventCategoriesEntity eventCategoriesEntity) = EventCategoriesLoadedState;
  const factory EventOrginizerState.eventOrginizerErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = EventOrginizerErrorState;
  const factory EventOrginizerState.eventTicketsErrorState(
      AppErrors error,
      VoidCallback callback,
      ) = EventTicketsErrorState;

  const factory EventOrginizerState.eventsLoaded(MyRunningEventsEntity entity) = EventsLoadedState;
  const factory EventOrginizerState.eventTicketsLoaded(EventTicketssEntity entity) = EventTicketsLoaded;
  const factory EventOrginizerState.manualCheckTicket() = ManualCheckTicket;
  const factory EventOrginizerState.manualCheckTicketDone() = ManualCheckTicketDone;
  const factory EventOrginizerState.scanTicketQrCode() = ScanTicketQrCode;
  const factory EventOrginizerState.getTicketReport(GetTicketReportResponseEntity getTicketReportResponseEntity) = GetTicketReport;
  const factory EventOrginizerState.getTicketDetailsDone(EventTicketEntity eventTicketEntity) = GetTicketDetailsDone;




}

