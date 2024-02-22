import 'package:starter_application/core/params/base_params.dart';

class GetPositiveRequest extends BaseParams {
  GetPositiveRequest(
      {
        this.sorting,
      this.skipCount,
      this.maxResultCount,

        this.Date,
     });

  final String? sorting;
  final int? skipCount;
  final int? maxResultCount;

  DateTime? Date ;

  factory GetPositiveRequest.fromMap(Map<String, dynamic> json) =>
      GetPositiveRequest(
        sorting: json["sorting"] == null ? null : json["sorting"],
        skipCount: json["skipCount"] == null ? null : json["skipCount"],
        maxResultCount:
            json["maxResultCount"] == null ? null : json["maxResultCount"],
        Date: json["Date"],
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (sorting != null) map['sorting'] = sorting;
    if (skipCount != null) map['skipCount'] = skipCount;
    if (maxResultCount != null) map['maxResultCount'] = maxResultCount;
    if(Date != null) map['Date'] = Date;
    return map;
  }
}
