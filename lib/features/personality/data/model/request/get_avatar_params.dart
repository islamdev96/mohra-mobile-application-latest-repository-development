import 'package:starter_application/core/params/base_params.dart';

class GetAvatarParams extends BaseParams {
  int gender;
  int? month;

  GetAvatarParams({
    required this.gender,
     this.month,
  });

  @override
  Map<String, dynamic> toMap() {
    return{
      'Gender':gender,
      'Month':month ?? null,
    };
  }
}
