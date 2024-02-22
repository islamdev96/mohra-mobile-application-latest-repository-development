// class GetTicketReportResponseModel {
//   Result? result;
//   Null? targetUrl;
//   bool? success;
//   Null? error;
//   bool? unAuthorizedRequest;
//   bool? bAbp;
//
//   GetTicketReportResponseModel(
//       {this.result,
//         this.targetUrl,
//         this.success,
//         this.error,
//         this.unAuthorizedRequest,
//         this.bAbp});
//
//   GetTicketReportResponseModel.fromJson(Map<String, dynamic> json) {
//     result =
//     json['result'] != null ? new Result.fromJson(json['result']) : null;
//     targetUrl = json['targetUrl'];
//     success = json['success'];
//     error = json['error'];
//     unAuthorizedRequest = json['unAuthorizedRequest'];
//     bAbp = json['__abp'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.result != null) {
//       data['result'] = this.result!.toJson();
//     }
//     data['targetUrl'] = this.targetUrl;
//     data['success'] = this.success;
//     data['error'] = this.error;
//     data['unAuthorizedRequest'] = this.unAuthorizedRequest;
//     data['__abp'] = this.bAbp;
//     return data;
//   }
// }

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/event_orginizer/domain/entity/get_ticket_report_response_entity.dart';

class GetTicketReportResponseModel extends BaseModel<GetTicketReportResponseEntity>{
  int? totalTicketCount;
  int? allTicketCount;
  int? ticketScannedCount;
  int? ticketNotScannedCount;

  GetTicketReportResponseModel(
      {this.totalTicketCount,
        this.ticketScannedCount,
        this.allTicketCount,
        this.ticketNotScannedCount});

  GetTicketReportResponseModel.fromJson(Map<String, dynamic> json) {
    totalTicketCount = json['totalTicketCount'];
    allTicketCount = json['allTicketCount'];
    ticketScannedCount = json['ticketScannedCount'];
    ticketNotScannedCount = json['ticketNotScannedCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalTicketCount'] = this.totalTicketCount;
    data['allTicketCount'] = this.allTicketCount;
    data['ticketScannedCount'] = this.ticketScannedCount;
    data['ticketNotScannedCount'] = this.ticketNotScannedCount;
    return data;
  }

  @override
  GetTicketReportResponseEntity toEntity() {
    return GetTicketReportResponseEntity(
      allTicketCount: allTicketCount,
      ticketNotScannedCount: ticketNotScannedCount,ticketScannedCount: ticketScannedCount,totalTicketCount: totalTicketCount
    );
  }
}
