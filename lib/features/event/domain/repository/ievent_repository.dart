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
import '../../../../core/repositories/repository.dart';

abstract class IEventRepository extends Repository {
  /// Client requests
  Future<Result<AppErrors, EventsEntity>> getAllEvents(GetEventsRequest param);

  Future<Result<AppErrors, EventCategoriesEntity>> getEventCategories(
      NoParams param);

  Future<Result<AppErrors, EventEntity>> getEvent(GetEventRequest param);

  Future<Result<AppErrors, CreateEventTicketEntity>> createEventTicket(
      CreateEventTicketRequest param);

  Future<Result<AppErrors, EventTicketsEntity>> getEventTickets(
      GetEventsTicketsRequest param);

  Future<Result<AppErrors, EventTicketEntity>> getEventTicket(
      GetEventTicketRequest param);

  /// Event Organizer requests
  Future<Result<AppErrors, MyRunningEventsListEntity>> getMyRunningEvents(
      GetMyRunningEventsParam param);

  Future<Result<AppErrors, EmptyResponse>> scanTicketQrCode(
      ScanTicketQrCodeParam param);

  Future<Result<AppErrors, EmptyResponse>> checkIfCanPay(
      CreateEventTicketRequest param);

  Future<Result<AppErrors, EmptyResponse>> createPayment(
      CreatePaymentParam param);
}
