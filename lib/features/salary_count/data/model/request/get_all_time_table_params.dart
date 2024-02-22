import 'package:starter_application/core/params/base_params.dart';
class GetAllTimeTableParams extends BaseParams {
  GetAllTimeTableParams(
      {this.sorting,
        this.skipCount,
        this.clientId,
        this.maxResultCount,
        this.selected
      });

  final String? sorting;
  final int? clientId;
  final bool? selected;
  final int? skipCount;
  final int? maxResultCount;


  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (sorting != null) map['sorting'] = sorting;
    if (clientId != null) map['ClientId'] = clientId;
    if (skipCount != null) map['skipCount'] = skipCount;
    if (maxResultCount != null) map['maxResultCount'] = maxResultCount;
    if(selected != null) map['selected'] = selected;
    map['IsActive'] = true;
    return map;
  }
}

