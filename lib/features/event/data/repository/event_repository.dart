import 'package:injectable/injectable.dart';
import 'package:starter_application/core/common/extensions/either_error_model_extension.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
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

import '../../../../core/params/create_payment.dart';
import '../datasource/../../domain/repository/ievent_repository.dart';
import '../datasource/ievent_remote.dart';
import '../model/response/create_event_ticket_model.dart';

@Singleton(as: IEventRepository)
class EventRepository extends IEventRepository {
  /// Client requests
  final IEventRemoteSource iEventRemoteSource;

  EventRepository(this.iEventRemoteSource);

  @override
  Future<Result<AppErrors, EventsEntity>> getAllEvents(
      GetEventsRequest param) async {
    final remoteResult = await iEventRemoteSource.getAllEvents(param);
    return remoteResult.result<EventsEntity>();
  }

  @override
  Future<Result<AppErrors, EventCategoriesEntity>> getEventCategories(
      NoParams param) async {
    final remoteResult = await iEventRemoteSource.getEventCategories(param);
    return remoteResult.result<EventCategoriesEntity>();
  }

  @override
  Future<Result<AppErrors, EventEntity>> getEvent(GetEventRequest param) async {
    final remoteResult = await iEventRemoteSource.getEvent(param);
    return remoteResult.result<EventEntity>();
  }

  @override
  Future<Result<AppErrors, CreateEventTicketEntity>> createEventTicket(
      CreateEventTicketRequest param) async {
    final remoteResult = await iEventRemoteSource.createEventTicket(param);
    return remoteResult.result<CreateEventTicketEntity>();
  }

  @override
  Future<Result<AppErrors, EventTicketEntity>> getEventTicket(
      GetEventTicketRequest param) async {
    final remoteResult = await iEventRemoteSource.getEventTicket(param);
    return remoteResult.result<EventTicketEntity>();
  }

  @override
  Future<Result<AppErrors, EventTicketsEntity>> getEventTickets(
      GetEventsTicketsRequest param) async {
    final remoteResult = await iEventRemoteSource.getEventTickets(param);
    return remoteResult.result<EventTicketsEntity>();
  }

  /// Event organizer requests

  @override
  Future<Result<AppErrors, MyRunningEventsListEntity>> getMyRunningEvents(
      GetMyRunningEventsParam param) async {
    final remoteResult = await iEventRemoteSource.getMyRunningEvents(param);
    return remoteResult.result<MyRunningEventsListEntity>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> scanTicketQrCode(
      ScanTicketQrCodeParam param) async {
    final remoteResult = await iEventRemoteSource.scanTicketQrCode(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> checkIfCanPay(
      CreateEventTicketRequest param) async {
    final remoteResult = await iEventRemoteSource.checkIfCanPay(param);
    return remoteResult.result<EmptyResponse>();
  }
  @override
  Future<Result<AppErrors, EmptyResponse>> createPayment(
      CreatePaymentParam param) async {
    final remoteResult = await iEventRemoteSource.createPayment(param);
    return remoteResult.result<EmptyResponse>();
  }
}
