import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/common/extensions/either_error_model_extension.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/features/event/data/model/request/get_event_ticket_request.dart';
import 'package:starter_application/features/event/data/model/request/get_my_running_events_param.dart';
import 'package:starter_application/features/event/data/model/request/scan_ticket_qr_code_param.dart';
import 'package:starter_application/features/event/domain/entity/event_ticket_entity.dart';
import 'package:starter_application/features/event_orginizer/data/model/request/manual_event_check_params.dart';
import 'package:starter_application/features/event_orginizer/data/model/request/search_event_params.dart';
import 'package:starter_application/features/event_orginizer/domain/entity/event_tickets_entity.dart';
import 'package:starter_application/features/event_orginizer/domain/entity/get_ticket_report_response_entity.dart';
import 'package:starter_application/features/event_orginizer/domain/entity/my_running_events_entity.dart';
import 'package:starter_application/features/notification/data/model/request/get_all_notification_param.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/params/no_params.dart';
import '../../../../core/results/result.dart';
import '../datasource/../../domain/repository/ievent_orginizer_repository.dart';
import '../datasource/ievent_orginizer_remote.dart';
import '../model/request/event_details_params.dart';

@Singleton(as: IEventOrginizerRepository)
class EventOrginizerRepository extends IEventOrginizerRepository {
  final IEventOrginizerRemoteSource iEventOrginizerRemoteSource;

  EventOrginizerRepository(this.iEventOrginizerRemoteSource);


  @override
  Future<Result<AppErrors, MyRunningEventsEntity>> getMyRunningEvents(GetMyRunningEventsParam param) async{
    final remote = await iEventOrginizerRemoteSource.getMyRunningEvents(param);
    return remote.result<MyRunningEventsEntity>();
  }

  @override
  Future<Result<AppErrors, MyRunningEventsEntity>> searchMyRunningEvents(SearchEventParams param) async{
    final remote = await iEventOrginizerRemoteSource.searchMyRunningEvents(param);
    return remote.result<MyRunningEventsEntity>();
  }


  @override
  Future<Result<AppErrors, EventTicketssEntity>> getEventTickets(GetEventTicketsParam param) async{
    final remote = await iEventOrginizerRemoteSource.getEventTickets(param);
    return remote.result<EventTicketssEntity>();
  }

  @override
  Future<Result<AppErrors, EventTicketEntity>> getEventTicket(GetEventTicketRequest param) async {
    final remote = await iEventOrginizerRemoteSource.getEventTicket(param);
    return remote.result<EventTicketEntity>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> manualCheckingEventTicket(ManualCheckEventParams param) async {
    final remote = await iEventOrginizerRemoteSource.manualCheckingEventTicket(param);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, GetTicketReportResponseEntity>> getTicketReport(EventDetailsParams param)async {
    final remote = await iEventOrginizerRemoteSource.getTicketReport(param);
    return remote.result<GetTicketReportResponseEntity>();
  }
  @override
  Future<Result<AppErrors, EmptyResponse>> scanTicketQrCode(
      ScanTicketQrCodeParam param) async {
    final remoteResult = await iEventOrginizerRemoteSource.scanTicketQrCode(param);
    return remoteResult.result<EmptyResponse>();
  }

}
