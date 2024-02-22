import 'package:dartz/dartz.dart';
import 'package:starter_application/features/event/data/model/request/get_my_running_events_param.dart';
import 'package:starter_application/features/event/data/model/request/scan_ticket_qr_code_param.dart';
import 'package:starter_application/features/event_orginizer/data/model/request/search_event_params.dart';
import 'package:starter_application/features/event_orginizer/data/model/response/get_ticket_report_response_model.dart';
import 'package:starter_application/features/event_orginizer/domain/entity/my_running_events_entity.dart';
import 'package:starter_application/features/notification/data/model/request/get_all_notification_param.dart';
import '../../../../core/datasources/remote_data_source.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/models/empty_response.dart';
import '../../../../core/params/no_params.dart';
import '../../../event/data/model/request/get_event_ticket_request.dart';
import '../../../event/data/model/response/event_ticket_model.dart';
import '../../../event/data/model/response/event_tickets_model.dart';
import '../model/request/event_details_params.dart';
import '../model/request/manual_event_check_params.dart';
import '../model/response/event_tickets_model.dart';
import '../model/response/my_running_events.dart';

abstract class IEventOrginizerRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, MyRunningEventsModel>> getMyRunningEvents(GetMyRunningEventsParam param);
  Future<Either<AppErrors, MyRunningEventsModel>> searchMyRunningEvents(SearchEventParams param);
  Future<Either<AppErrors, EventTicketsss>> getEventTickets(GetEventTicketsParam param);

  Future<Either<AppErrors, EventTicketModel>> getEventTicket(GetEventTicketRequest param);
  Future<Either<AppErrors, GetTicketReportResponseModel>> getTicketReport(EventDetailsParams param);
  Future<Either<AppErrors, EmptyResponse>> manualCheckingEventTicket(ManualCheckEventParams param);
  Future<Either<AppErrors, EmptyResponse>> scanTicketQrCode(
      ScanTicketQrCodeParam param);
}
