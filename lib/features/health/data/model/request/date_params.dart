import 'package:starter_application/core/params/base_params.dart';

class DateParams extends BaseParams {
  String date;

  DateParams({
    required this.date,
  });

  @override
  Map<String, dynamic> toMap() =>{
    'Date':date,
  };
}
