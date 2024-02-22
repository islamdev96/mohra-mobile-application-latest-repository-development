import 'package:dartz/dartz.dart';
import 'package:starter_application/features/event/data/model/request/get_my_running_events_param.dart';
import 'package:starter_application/features/event/data/model/request/scan_ticket_qr_code_param.dart';
import 'package:starter_application/features/event_orginizer/data/model/request/search_event_params.dart';
import 'package:starter_application/features/event_orginizer/domain/entity/get_ticket_report_response_entity.dart';
import 'package:starter_application/features/notification/data/model/request/get_all_notification_param.dart';

import '../../../../core/errors/app_errors.dart';
import '../../../../core/models/empty_response.dart';
import '../../../../core/params/no_params.dart';
import '../../../../core/repositories/repository.dart';
import '../../../../core/results/result.dart';
import '../../../event/data/model/request/get_event_ticket_request.dart';
import '../../../event/domain/entity/event_ticket_entity.dart';
import '../../../event/domain/entity/event_tickets_entity.dart';
import '../../data/model/request/event_details_params.dart';
import '../../data/model/request/manual_event_check_params.dart';
import '../entity/event_tickets_entity.dart';
import '../entity/my_running_events_entity.dart';

abstract class IEventOrginizerRepository extends Repository {
  Future<Result<AppErrors, MyRunningEventsEntity>> getMyRunningEvents(GetMyRunningEventsParam param);
  Future<Result<AppErrors, MyRunningEventsEntity>> searchMyRunningEvents(SearchEventParams param);
  Future<Result<AppErrors, EventTicketssEntity>> getEventTickets(GetEventTicketsParam param);
  Future<Result<AppErrors, EventTicketEntity>> getEventTicket(GetEventTicketRequest param);
  Future<Result<AppErrors, GetTicketReportResponseEntity>> getTicketReport(EventDetailsParams param);
  Future<Result<AppErrors, EmptyResponse>> manualCheckingEventTicket(ManualCheckEventParams param);
  Future<Result<AppErrors, EmptyResponse>> scanTicketQrCode(
      ScanTicketQrCodeParam param);

}

