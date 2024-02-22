import 'package:dartz/dartz.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
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

import '../../../../core/datasources/remote_data_source.dart';
import '../../../../core/params/create_payment.dart';

abstract class IEventRemoteSource extends RemoteDataSource {
  /// Client requests
  Future<Either<AppErrors, EventsModel>> getAllEvents(GetEventsRequest param);

  Future<Either<AppErrors, EventCategoriesModel>> getEventCategories(
      NoParams param);

  Future<Either<AppErrors, EventModel>> getEvent(GetEventRequest param);

  Future<Either<AppErrors, CreateEventTicketModel>> createEventTicket(
      CreateEventTicketRequest param);

  Future<Either<AppErrors, EventTicketModel>> getEventTicket(
      GetEventTicketRequest param);

  Future<Either<AppErrors, EventTicketsModel>> getEventTickets(
      GetEventsTicketsRequest param);

  /// Event organizer requests
  Future<Either<AppErrors, MyRunningEventsListModel>> getMyRunningEvents(
      GetMyRunningEventsParam param);

  Future<Either<AppErrors, EmptyResponse>> scanTicketQrCode(
      ScanTicketQrCodeParam param);

  Future<Either<AppErrors, EmptyResponse>> checkIfCanPay(
      CreateEventTicketRequest param);

  Future<Either<AppErrors, EmptyResponse>> createPayment(
      CreatePaymentParam param);
}
