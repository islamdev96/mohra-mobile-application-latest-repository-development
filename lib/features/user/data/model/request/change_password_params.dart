import 'package:starter_application/core/params/base_params.dart';

class ChangePasswordParams extends BaseParams{
  final String oldPassword;
  final String newPassword;

  ChangePasswordParams({
   required this.oldPassword,
   required this.newPassword,
});

  @override
  Map<String, dynamic> toMap()=> {
    'currentPassword': oldPassword,
    'newPassword':newPassword,
  };




}