import 'package:starter_application/core/params/base_params.dart';

class DeleteAccountParams extends BaseParams {
  String reasonDeletedAccount;
  String password;
  bool isGoogleAccount;

  DeleteAccountParams({
    required this.password,
    required this.reasonDeletedAccount,
    this.isGoogleAccount = false,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'reasonDeletedAccount':reasonDeletedAccount,
      'password':password,
      'isGoogleAccount':isGoogleAccount
    };
  }

}