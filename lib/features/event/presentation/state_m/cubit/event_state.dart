part of 'event_cubit.dart';

@freezed
class EventState with _$EventState {
  const factory EventState.eventInitState() = EventInitState;

  const factory EventState.eventLoadingState() = EventLoadingState;

  const factory EventState.eventsLoadedState(EventsEntity eventsEntity) =
      EventsLoadedState;

  const factory EventState.eventCategoriesLoadedState(
      EventCategoriesEntity eventCategoriesEntity) = EventCategoriesLoadedState;

  const factory EventState.eventLoadedState(EventEntity eventEntity) =
      EventLoadedState;

  const factory EventState.ticketCreatedState(
      CreateEventTicketEntity createEventTicketEntity) = TicketCreatedState;

  const factory EventState.ticketsLoadedState(
      EventTicketsEntity eventTicketsEntity) = TicketsLoadedState;

  const factory EventState.ticketLoadedState(
      EventTicketEntity eventTicketEntity) = TicketLoadedState;

  const factory EventState.myRunningEventsLoaded(
          MyRunningEventsListEntity myRunningEventsListEntity) =
      MyRunningEventsLoaded;

  const factory EventState.scanTicketQrCodeLoaded() = ScanTicketQrCodeLoaded;

  const factory EventState.canPaySuccess() = CanPaySuccess;

  const factory EventState.createPaymentSuccess() = CreatePaymentSuccess;

  const factory EventState.eventErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = EventErrorState;

  const factory EventState.cantPaySuccess(
    AppErrors error,
    VoidCallback callback,
  ) = CantPaySuccess;
}
