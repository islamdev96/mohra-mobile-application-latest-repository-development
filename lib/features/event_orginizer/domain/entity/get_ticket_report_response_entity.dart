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

import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/core/models/base_model.dart';

class GetTicketReportResponseEntity extends BaseEntity{
  int? totalTicketCount;
  int? ticketScannedCount;
  int? allTicketCount;
  int? ticketNotScannedCount;

  GetTicketReportResponseEntity(
      {this.totalTicketCount,
        this.ticketScannedCount,
        this.allTicketCount,
        this.ticketNotScannedCount});

  @override
  List<Object?> get props => [];
}
