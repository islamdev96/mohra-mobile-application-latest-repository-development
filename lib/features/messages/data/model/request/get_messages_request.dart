import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/params/base_params.dart';

class GetMessagesParams extends BaseParams {
  GetMessagesParams({
    this.conversationId,
    this.groupId,
    this.sorting,
    this.skipCount,
    this.maxResultCount,
  });

  final int? conversationId;
  final int? groupId;
  final String? sorting;
  final int? skipCount;
  final int? maxResultCount;

  factory GetMessagesParams.fromMap(Map<String, dynamic> json) =>
      GetMessagesParams(
        conversationId:
            json["conversationId"] == null ? null : json["conversationId"],
        groupId: json["groupId"] == null ? null : json["groupId"],
        sorting: stringV(json["sorting"]),
        skipCount: json["skipCount"] == null ? null : json["skipCount"],
        maxResultCount:
            json["maxResultCount"] == null ? null : json["maxResultCount"],
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (conversationId != null) map['conversationId'] = conversationId;
    if (groupId != null) map['groupId'] = groupId;
    if (sorting != null) map['sorting'] = sorting;
    if (skipCount != null) map['skipCount'] = skipCount;
    if (maxResultCount != null) map['maxResultCount'] = maxResultCount;
    return map;
  }
}
