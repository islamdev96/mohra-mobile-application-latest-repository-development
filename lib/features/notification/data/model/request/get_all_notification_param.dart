import 'package:dio/dio.dart';
import 'package:starter_application/core/params/base_params.dart';
class GetAllNotificationParam extends BaseParams {
  GetAllNotificationParam(
      {this.EventId,
      this.sorting,
        this.skipCount,
        this.maxResultCount,
        this.isActive,
        CancelToken? cancelToken})
      : super(cancelToken: cancelToken);

  final String? sorting;
  final int? EventId;
  final int? skipCount;
  final int? maxResultCount;
  final bool? isActive;
  factory GetAllNotificationParam.fromMap(Map<String, dynamic> json) =>
      GetAllNotificationParam(
        sorting: json["sorting"] == null ? null : json["sorting"],
        EventId: json["EventId"] == null ? null : json["EventId"],
        skipCount: json["skipCount"] == null ? null : json["skipCount"],
        maxResultCount:
        json["maxResultCount"] == null ? null : json["maxResultCount"],
      );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> _map = {};
    if (sorting != null) _map['sorting'] = sorting;
    if (EventId != null) _map['EventId'] = EventId;
    if (skipCount != null) _map['skipCount'] = skipCount;
    if (maxResultCount != null) _map['maxResultCount'] = maxResultCount;
    if (isActive != null) _map['IsActive'] = isActive;
    _map["IsActive"] = true;

    return _map;
  }
}
