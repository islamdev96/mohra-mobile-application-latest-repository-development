import 'package:starter_application/core/params/base_params.dart';

class CheckIfUsernameExistParams extends BaseParams{

  String userName ;

  CheckIfUsernameExistParams({
    required this.userName,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'userName' : userName,
    };
  }

}