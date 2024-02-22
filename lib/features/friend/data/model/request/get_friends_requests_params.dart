import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/params/base_params.dart';

class GetFriendsRequestsParams extends BaseParams {
  GetFriendsRequestsParams({
    this.sentOnly,
    this.receivedOnly,
    this.sorting,
    this.skipCount,
    this.maxResultCount,
  });

  final bool? sentOnly;
  final bool? receivedOnly;
  final String? sorting;
  final int? skipCount;
  final int? maxResultCount;

  factory GetFriendsRequestsParams.fromMap(Map<String, dynamic> json) =>
      GetFriendsRequestsParams(
        sentOnly: boolV(json["sentOnly"]),
        receivedOnly: boolV(json["receivedOnly"]),
        sorting: stringV(json["sorting"]),
        skipCount: json["skipCount"] == null ? null : json["skipCount"],
        maxResultCount:
            json["maxResultCount"] == null ? null : json["maxResultCount"],
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (sentOnly != null) map["sentOnly"] = sentOnly;
    if (receivedOnly != null) map["receivedOnly"] = receivedOnly;
    if (sorting != null) map["sorting"] = sorting;
    if (skipCount != null) map["skipCount"] = skipCount;
    if (maxResultCount != null) map["maxResultCount"] = maxResultCount;
    return map;
  }
}
