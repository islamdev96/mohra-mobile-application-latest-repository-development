import 'package:starter_application/core/params/base_params.dart';

class GetEventsTicketsRequest extends BaseParams {
  GetEventsTicketsRequest({
    this.clientId,
    this.isActive,
    this.sorting,
    this.skipCount,
    this.maxResultCount,
  });

  final int? clientId;
  final bool? isActive;
  final String? sorting;
  final int? skipCount;
  final int? maxResultCount;

  factory GetEventsTicketsRequest.fromMap(Map<String, dynamic> json) =>
      GetEventsTicketsRequest(
        clientId: json["clientId"] == null ? null : json["clientId"],
        isActive: json["isActive"] == null ? null : json["isActive"],
        sorting: json["sorting"] == null ? null : json["sorting"],
        skipCount: json["skipCount"] == null ? null : json["skipCount"],
        maxResultCount:
            json["maxResultCount"] == null ? null : json["maxResultCount"],
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (clientId != null) map['clientId'] = clientId;
    if (isActive != null) map['isActive'] = isActive;
    if (sorting != null) map['sorting'] = sorting;
    if (skipCount != null) map['skipCount'] = skipCount;
    if (maxResultCount != null) map['maxResultCount'] = maxResultCount;

    return map;
  }
}
