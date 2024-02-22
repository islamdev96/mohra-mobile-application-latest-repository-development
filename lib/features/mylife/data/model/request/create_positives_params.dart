import 'package:starter_application/core/params/base_params.dart';
import 'package:starter_application/features/mylife/data/model/response/get_dream_list_response.dart';

class CreatePositivesParams extends BaseParams{
  String title , imageUrl,description,date;
  CreatePositivesParams({
   required this.title,
   required this.description,
   required this.date,
   required this.imageUrl,
});

  @override
  Map<String, dynamic> toMap() => {
    'title':title,
    'imageUrl':imageUrl,
    'description':description,
    'date':date
  };


}