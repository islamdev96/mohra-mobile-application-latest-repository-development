import 'package:flutter/material.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_error_snackbar.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/features/account/data/model/request/confirmPassword_request.dart';
import 'package:starter_application/features/account/data/model/request/register_request.dart';
import 'package:starter_application/features/account/presentation/screen/login_screen.dart';
import 'package:starter_application/features/account/presentation/screen/verify_code_screen.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';

class ConfirmPasswordScreenNotifier extends ScreenNotifier {
  late BuildContext context;
  late RegisterRequest registerRequest;
  bool obscureTextpssword = false;
  bool obscureTextconfirmPssword = false;
  final accountCubit = AccountCubit();
  var formkey = GlobalKey<FormState>();
  int paddingbottom = 5;

  isPassword() {
    obscureTextpssword ? obscureTextpssword = false : obscureTextpssword = true;
    notifyListeners();
  }

  isConfirmPassword() {
    obscureTextconfirmPssword
        ? obscureTextconfirmPssword = false
        : obscureTextconfirmPssword = true;
    notifyListeners();
  }

  /// Variables
  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeConfirmPassword = FocusNode();

  // Key
  final PasswordKey = new GlobalKey<FormFieldState<String>>();
  final confirmPasswordKey = new GlobalKey<FormFieldState<String>>();

  // Controller
  final PasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  /// Methods

  onNextTap() {
    if (formkey.currentState!.validate()) {
      if(registerRequest.phoneNumber != null){
        ConfirmPasswordRequest request = ConfirmPasswordRequest(
            isFromGooleAccount: true,
            newPassword: PasswordController.text,
            userNameOrEmailAddressOrPhoneNumber: "00${registerRequest.countryCode}${registerRequest.phoneNumber}",
          code: "${registerRequest.verifyCode}"

        );
        print(request);
        accountCubit.ConfirmPassword(request);
      }
      else{
        ConfirmPasswordRequest request = ConfirmPasswordRequest(
            code: registerRequest.verifyCode,
            newPassword: PasswordController.text,
            isFromGooleAccount: false,
            userNameOrEmailAddressOrPhoneNumber: "${registerRequest.emailAddress}");
        accountCubit.ConfirmPassword(request);
      }

    }
  }

  onPasswordRestore() async {
    showSnackbar('your new password saved successfully',context: context);
    await Future.delayed(const Duration(seconds: 1));
    Nav.toAndRemoveAll(LoginScreen.routeName);
  }

  @override
  void closeNotifier() {}
}
