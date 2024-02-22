import 'package:starter_application/core/params/base_params.dart';

class GetProfileParams extends BaseParams {
  int id;

  GetProfileParams({
    required this.id,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id':id,
    };
  }

}