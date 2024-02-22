import 'package:starter_application/core/params/base_params.dart';

class ChangeEmailParams extends BaseParams{
  final String newEmail;
  ChangeEmailParams({
    required this.newEmail,
});

  @override
  Map<String, dynamic> toMap() {
    return{
      'newEmail' : newEmail,
    };
  }



}