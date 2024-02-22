import 'package:flutter/material.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/features/user/data/model/request/change_password_params.dart';
import 'package:starter_application/features/user/presentation/state_m/cubit/user_cubit.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';

class ChangePasswordScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final userCubit = UserCubit();

  bool visiblePassword = true;
  bool visiblePassword2 = true;
  bool visiblePassword3 = true;
  bool canSave = false;

  /// Getters and Setters

  /// Methods

  changeVisible() {
    visiblePassword ? visiblePassword = false : visiblePassword = true;
    notifyListeners();
  }

  changeVisible2() {
    visiblePassword2 ? visiblePassword2 = false : visiblePassword2 = true;
    notifyListeners();
  }

  changeVisible3() {
    visiblePassword3 ? visiblePassword3 = false : visiblePassword3 = true;
    notifyListeners();
  }

  canSave2() {
    if (PasswordKey.currentState!.validate() &&
        PasswordKey2.currentState!.validate() &&
        PasswordKey3.currentState!.validate()) {
      canSave = true;
    } else {
      canSave = false;
    }
    notifyListeners();
  }

  onTapSave() {
    if (canSave) {
      userCubit.changePassword(
        ChangePasswordParams(
            oldPassword: passwordController.text,
            newPassword: passwordController1.text),
      );
    }
  }

  onPasswordChanged(){
    showSnackbar(
      'Password Updated Successfully',
    );
  }

  showError(AppErrors error){
    String message = '';
    error.mapOrNull(
        internalServerWithDataError: (error) {
          message = error.message ??'';
        }
    );
    showSnackbar(
      message,
      isError: true,
    );
  }

  @override
  void closeNotifier() {
    passwordController.dispose();
    passwordController1.dispose();
    passwordController2.dispose();
    this.dispose();
  }

  final passwordController = TextEditingController();
  final passwordController1 = TextEditingController();
  final passwordController2 = TextEditingController();

  final PasswordKey = new GlobalKey<FormFieldState<String>>();
  final PasswordKey2 = new GlobalKey<FormFieldState<String>>();
  final PasswordKey3 = new GlobalKey<FormFieldState<String>>();
}
