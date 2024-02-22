import 'package:starter_application/core/params/base_params.dart';

class GetAppointmentRequest extends BaseParams {
  GetAppointmentRequest(
      {this.sorting,
      this.skipCount,
      this.maxResultCount,
      this.fromDate,
      this.toDate});

  final String? sorting;
  final int? skipCount;
  final int? maxResultCount;
  DateTime? fromDate;
  DateTime? toDate;

  factory GetAppointmentRequest.fromMap(Map<String, dynamic> json) =>
      GetAppointmentRequest(
        sorting: json["sorting"] == null ? null : json["sorting"],
        skipCount: json["skipCount"] == null ? null : json["skipCount"],
        maxResultCount:
            json["maxResultCount"] == null ? null : json["maxResultCount"],
        fromDate: json["FromDate"],
        toDate: json["ToDate"],
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (sorting != null) map['sorting'] = sorting;
    if (skipCount != null) map['skipCount'] = skipCount;
     map['maxResultCount'] = 200;
    if(fromDate != null) map["FromDate"] = fromDate;
    if(toDate != null)  map["ToDate"] = toDate;
    return map;
  }
}
