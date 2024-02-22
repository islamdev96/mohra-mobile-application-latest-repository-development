import 'package:starter_application/core/params/base_params.dart';

class CheckIfEmailExistParams extends BaseParams{

  String email ;

  CheckIfEmailExistParams({
    required this.email,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'email' : email,
    };
  }

}