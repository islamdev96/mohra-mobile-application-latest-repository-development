import 'package:starter_application/core/params/base_params.dart';

class DailyDishListParamms extends BaseParams{

  int maxResultCount;
  String date;

  DailyDishListParamms({
    required this.maxResultCount,
    required this.date,
});

  @override
  Map<String, dynamic> toMap() {
    return {
      'MaxResultCount':maxResultCount,
      'Date':date,
    };
  }


}