import 'package:starter_application/core/params/base_params.dart';

class GetDishParams extends BaseParams{
  int id;

  GetDishParams({
    required this.id,
  });


  @override
  Map<String, dynamic> toMap() {
    return{
      'id':id,
    };
  }

}