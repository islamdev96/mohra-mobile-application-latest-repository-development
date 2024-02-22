import 'package:starter_application/core/params/base_params.dart';

class GetConversationParams extends BaseParams {
  GetConversationParams({
    this.sorting,
    this.skipCount,
    this.maxResultCount,
  });

  final String? sorting;
  final int? skipCount;
  final int? maxResultCount;

  factory GetConversationParams.fromMap(Map<String, dynamic> json) =>
      GetConversationParams(
        sorting: json["sorting"] == null ? null : json["sorting"],
        skipCount: json["skipCount"] == null ? null : json["skipCount"],
        maxResultCount:
            json["maxResultCount"] == null ? null : json["maxResultCount"],
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (sorting != null) map['sorting'] = sorting;
    if (skipCount != null) map['skipCount'] = skipCount;
    if (maxResultCount != null) map['maxResultCount'] = maxResultCount;
    return map;
  }
}
