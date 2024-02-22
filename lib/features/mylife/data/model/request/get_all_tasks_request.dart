import 'package:starter_application/core/params/base_params.dart';

class GetAllTasksRequest extends BaseParams {
  DateTime? fromDate;
  DateTime?  toDate;

  GetAllTasksRequest({ this.fromDate, this.toDate});

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if(fromDate != null) map['FromDate'] = fromDate;
    if(toDate != null) map['ToDate'] = toDate;
    return map;
  }
}
