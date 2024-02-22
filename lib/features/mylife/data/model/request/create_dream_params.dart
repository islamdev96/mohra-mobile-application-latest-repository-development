import 'package:starter_application/core/params/base_params.dart';
import 'package:starter_application/features/mylife/data/model/response/get_dream_list_response.dart';

class CreateDreamParams extends BaseParams{
  String title , imageUrl;
  List<StepModel> steps;

  CreateDreamParams({
   required this.title,
   required this.steps,
   required this.imageUrl,
});

  @override
  Map<String, dynamic> toMap() => {
    'title':title,
    'imageUrl':imageUrl,
    'steps': List<dynamic>.from(steps.map((x) => x.toMap()))
  };


}