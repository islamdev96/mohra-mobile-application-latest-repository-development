import 'package:starter_application/core/params/base_params.dart';

class GetCommentsRequest extends BaseParams {
  GetCommentsRequest({
    required this.refType,
    required this.refId,
    this.sorting,
    this.skipCount,
    this.maxResultCount,
  });

  final int refType;
  final String refId;
  final String? sorting;
  final int? skipCount;
  final int? maxResultCount;

  factory GetCommentsRequest.fromMap(Map<String, dynamic> json) => GetCommentsRequest(
        refType: json["refType"] == null ? null : json["refType"],
        refId: json["refId"] == null ? null : json["refId"],
        sorting: json["sorting"] == null ? null : json["sorting"],
        skipCount: json["skipCount"] == null ? null : json["skipCount"],
        maxResultCount: json["maxResultCount"] == null ? null : json["maxResultCount"],
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['refType'] = refType;
    map['refId'] = refId;
    if (sorting != null) map['sorting'] = sorting;
    if (skipCount != null) map['skipCount'] = skipCount;
    if (maxResultCount != null) map['maxResultCount'] = maxResultCount;
    return map;
  }
}
