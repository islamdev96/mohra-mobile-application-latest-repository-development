import 'package:starter_application/core/params/base_params.dart';

class UpdateDailyWaterParams extends BaseParams{
  bool increase;
  String date;

  UpdateDailyWaterParams({
   required this.date,
   required this.increase,
});

  @override
  Map<String, dynamic> toMap() =>{
    'day':date,
    'increase':increase,
  };

}