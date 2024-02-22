import 'package:dartz/dartz.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/constants/enums/http_method.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/net/api_url.dart';
import 'package:starter_application/core/net/create_model_interceptor/null_response_model_interceptor.dart';
import 'package:starter_application/core/params/create_payment.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/features/event/data/model/request/create_ticket_request.dart';
import 'package:starter_application/features/event/data/model/request/get_all_events_request.dart';
import 'package:starter_application/features/event/data/model/request/get_event_request.dart';
import 'package:starter_application/features/event/data/model/request/get_event_ticket_request.dart';
import 'package:starter_application/features/event/data/model/request/get_event_tickets_request.dart';
import 'package:starter_application/features/event/data/model/request/get_my_running_events_param.dart';
import 'package:starter_application/features/event/data/model/request/scan_ticket_qr_code_param.dart';
import 'package:starter_application/features/event/data/model/response/create_event_ticket_model.dart';
import 'package:starter_application/features/event/data/model/response/event_categories_model.dart';
import 'package:starter_application/features/event/data/model/response/event_model.dart';
import 'package:starter_application/features/event/data/model/response/event_ticket_model.dart';
import 'package:starter_application/features/event/data/model/response/event_tickets_model.dart';
import 'package:starter_application/features/event/data/model/response/events_model.dart';
import 'package:starter_application/features/event/data/model/response/my_running_events_list_model.dart';

import 'ievent_remote.dart';

@Singleton(as: IEventRemoteSource)
class EventRemoteSource extends IEventRemoteSource {
  /// Client requests
  @override
  Future<Either<AppErrors, EventsModel>> getAllEvents(GetEventsRequest param) {
    return request(
      converter: (json) => EventsModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.API_GET_ALL_EVENTS,
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EventCategoriesModel>> getEventCategories(
      NoParams param) {
    return request(
      converter: (json) => EventCategoriesModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.API_GET_EVENT_CATEGORIES,
      //
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EventModel>> getEvent(GetEventRequest param) {
    return request(
      converter: (json) => EventModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.API_GET_EVENT,
      cancelToken: param.cancelToken,
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, CreateEventTicketModel>> createEventTicket(
      CreateEventTicketRequest param) {
    return request(
      converter: (json) => CreateEventTicketModel.fromMap(json),
      method: HttpMethod.POST,
      url: APIUrls.API_CREATE_EVENT_TICKET,
      body: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EventTicketModel>> getEventTicket(
      GetEventTicketRequest param) {
    return request(
      converter: (json) => EventTicketModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.API_GET_EVENT_TICKET,
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EventTicketsModel>> getEventTickets(
      GetEventsTicketsRequest param) {
    return request(
      converter: (json) => EventTicketsModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.API_GET_EVENT_TICKETS,
      queryParameters: param.toMap(),
    );
  }

  /// Event organizer requests

  @override
  Future<Either<AppErrors, MyRunningEventsListModel>> getMyRunningEvents(
      GetMyRunningEventsParam param) {
    return request(
      converter: (json) => MyRunningEventsListModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.API_GET_MY_RUNNING_EVENT,
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> scanTicketQrCode(
      ScanTicketQrCodeParam param) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      url: APIUrls.API_TICKET_SCANNED_QR_CODE,
      queryParameters: param.toMap(),
      createModelInterceptor: const NullResponseModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> checkIfCanPay(
      CreateEventTicketRequest param) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      url: APIUrls.API_CHECK_IF_CAN_PAY,
      body: param.toMap(),
      createModelInterceptor: const NullResponseModelInterceptor(),
    );
  }
  @override
  Future<Either<AppErrors, EmptyResponse>> createPayment(
      CreatePaymentParam param) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      url: APIUrls.API_CREATE_PAYMENT,
      body: param.toJson(),
      createModelInterceptor: const NullResponseModelInterceptor(),
    );
  }
}
