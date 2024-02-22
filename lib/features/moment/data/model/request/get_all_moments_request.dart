import 'package:dio/dio.dart';
import 'package:starter_application/core/params/base_params.dart';

class GetMomentsRequest extends BaseParams {
  GetMomentsRequest(
      {this.sorting,
      this.skipCount,
      this.maxResultCount,
      this.isMyChalhengs = false,
      CancelToken? cancelToken})
      : super(cancelToken: cancelToken);

  final String? sorting;
  final int? skipCount;
  final int? maxResultCount;
  final bool isMyChalhengs;
  factory GetMomentsRequest.fromMap(Map<String, dynamic> json) =>
      GetMomentsRequest(
        sorting: json["sorting"] == null ? null : json["sorting"],
        skipCount: json["skipCount"] == null ? null : json["skipCount"],
        maxResultCount:
            json["maxResultCount"] == null ? null : json["maxResultCount"],
      );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> _map = {};
    if (sorting != null) _map['sorting'] = sorting;
    if (skipCount != null) _map['skipCount'] = skipCount;
    if (maxResultCount != null) _map['maxResultCount'] = maxResultCount;
    _map["IsActive"] = true;

    return _map;
  }
}
