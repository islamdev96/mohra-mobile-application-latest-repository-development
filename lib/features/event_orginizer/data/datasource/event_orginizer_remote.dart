import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/net/create_model_interceptor/null_response_model_interceptor.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/features/event/data/model/request/get_my_running_events_param.dart';
import 'package:starter_application/features/event/data/model/request/scan_ticket_qr_code_param.dart';
import 'package:starter_application/features/event/data/model/response/event_tickets_model.dart';
import 'package:starter_application/features/event_orginizer/data/model/request/event_details_params.dart';
import 'package:starter_application/features/event_orginizer/data/model/request/manual_event_check_params.dart';
import 'package:starter_application/features/event_orginizer/data/model/request/search_event_params.dart';
import 'package:starter_application/features/event_orginizer/data/model/response/get_ticket_report_response_model.dart';
import 'package:starter_application/features/event_orginizer/domain/entity/my_running_events_entity.dart';
import 'package:starter_application/features/notification/data/model/request/get_all_notification_param.dart';


import '../../../../core/constants/enums/http_method.dart';
import '../../../../core/net/api_url.dart';
import '../../../event/data/model/request/get_event_ticket_request.dart';
import '../../../event/data/model/response/event_ticket_model.dart';
import '../../../event/data/model/response/my_running_events_list_model.dart';
import '../model/response/event_tickets_model.dart';
import '../model/response/my_running_events.dart';
import 'ievent_orginizer_remote.dart';

@Singleton(as: IEventOrginizerRemoteSource)
class EventOrginizerRemoteSource extends IEventOrginizerRemoteSource {
  @override
  Future<Either<AppErrors, MyRunningEventsModel>> getMyRunningEvents(GetMyRunningEventsParam param) {
    return request(
      converter: (json) => MyRunningEventsModel.fromJson(json),
      method: HttpMethod.GET,
      url: APIUrls.API_GET_MY_RUNNING_EVENT,
      queryParameters: param.toMap()
    );
  }

  @override
  Future<Either<AppErrors, MyRunningEventsModel>> searchMyRunningEvents(SearchEventParams param) {
    return request(
      converter: (json) => MyRunningEventsModel.fromJson(json),
      method: HttpMethod.GET,
      url: APIUrls.API_GET_MY_RUNNING_EVENT,
    );
  }


  @override
  Future<Either<AppErrors, EventTicketsss>> getEventTickets(GetEventTicketsParam param) {
    return request(
      converter: (json) => EventTicketsss.fromJson(json),
      method: HttpMethod.GET,
      url: APIUrls.getTicketsByEventId,
      queryParameters: param.toMap(),
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
  Future<Either<AppErrors, EmptyResponse>> manualCheckingEventTicket(ManualCheckEventParams param) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      url: APIUrls.manualCheckTicket,
      body: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, GetTicketReportResponseModel>> getTicketReport(EventDetailsParams param) {
    return request(
      converter: (json) => GetTicketReportResponseModel.fromJson(json),
      method: HttpMethod.GET,
      url: APIUrls.getTicketReportByEventId,
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
}
