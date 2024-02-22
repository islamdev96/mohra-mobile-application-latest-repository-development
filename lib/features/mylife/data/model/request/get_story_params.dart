import 'package:starter_application/core/params/base_params.dart';

class GetStoryParams extends BaseParams{
  int id;

  GetStoryParams({
    required this.id,
});

  @override
  Map<String, dynamic> toMap() {
    return {
      'id':id,
    };
  }


}