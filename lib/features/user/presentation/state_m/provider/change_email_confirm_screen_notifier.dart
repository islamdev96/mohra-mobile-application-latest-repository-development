import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:starter_application/core/localization/translations.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_error_snackbar.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/features/account/data/model/request/verify_request.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';
import 'package:starter_application/features/home/presentation/screen/app_main_screen.dart';
import 'package:starter_application/features/user/data/model/request/update_profile_params.dart';
import 'package:starter_application/features/user/domain/entity/update_profile_entity.dart';
import 'package:starter_application/features/user/presentation/screen/change_email_success_screen.dart';
import 'package:starter_application/features/user/presentation/screen/view_profile_screen.dart';
import 'package:starter_application/features/user/presentation/state_m/cubit/user_cubit.dart';
import 'package:starter_application/generated/l10n.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';

class ChangeEmailConfirmScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  late Map<String, dynamic> args;
  late int type;
  late String newField;
  late String countryCode;
  late String verificationId;

  final accountCubit = AccountCubit();
  final userCubit = UserCubit();
  String code = '';
  bool? _isEditing;
  bool isVerifyPhone = false;
  bool isSendingCode = false;

  /// Getters and Setters

  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }

  void onCodeComplete(String value) {
    if (FocusScope.of(context).hasFocus) FocusScope.of(context).unfocus();
    code = value;
    notifyListeners();
  }

  void onEditing(bool value) {
    _isEditing = value;
    code = '';
    notifyListeners();
  }

  onVerifyTapped() {
    // do api call then, go to success screen
    if (code.isEmpty) {
      showErrorSnackBar(message: Translation.current.code_empty);
    } else if (code.length < 6) {
      showErrorSnackBar(message: Translation.current.code_too_short);
    } else {
      if (type == 0) {
        accountCubit.verify(VerifyRequest(
          code: code,
          usernameOrEmailOrPhone: UserSessionDataModel.emailAddress,
        ));
      } else {
        changeVerifyStatus();
        verifyPhoneCode();
      }
    }
  }

  onVerifyDone() {
    Nav.toAndPopUntil(
        ChangeEmailSuccessScreen.routeName, AppMainScreen.routeName,
        arguments: type);
  }

  verifyPhoneCode() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: code);
    try {
      var x = await auth.signInWithCredential(credential);
      print(x.additionalUserInfo!.isNewUser);
      changeVerifyStatusToFalse();
      updateProfileForPhoneNumber();
    } on FirebaseAuthException catch (e) {
      changeVerifyStatusToFalse();
      if (e.code == 'invalid-verification-code') {
        showErrorSnackBar(
          message: '${Translation.current.invalid_verification_code}',
        );
      } else {
        showErrorSnackBar(
          message: e.code,
        );
      }
      print(e.message);
      print(e.code);
    }
  }

  changeVerifyStatus() {
    isVerifyPhone = !isVerifyPhone;
    notifyListeners();
  }

  changeVerifyStatusToFalse() {
    isVerifyPhone = false;
    notifyListeners();
  }

  updateProfileForPhoneNumber() async {
    showSnackbar('verification complete');
    countryCode = countryCode
        .toString()
        .split('+')[countryCode.toString().split('+').length - 1];
    //await Future.delayed(Duration(seconds: 10));
    userCubit.updateProfile(UpdateProfileParams(
      name: UserSessionDataModel.name,
      imageUrl: UserSessionDataModel.imageUrl,
      coverImage: UserSessionDataModel.coverPhoto,
      gender: UserSessionDataModel.gender,
      date: UserSessionDataModel.birthday,
      email: UserSessionDataModel.emailAddress,
      surName: UserSessionDataModel.surname,
      phoneNumber: newField,
      countryCode: '00$countryCode',
    ));
  }

  onUpdateProfleDone(UpdateProfileEntity profileEntity) async {
    if (type == 0) {
      UserSessionDataModel.updateProfileSP(
        profileEntity.name!,
        profileEntity.surname!,
        profileEntity.fullName!,
        UserSessionDataModel.birthday,
        profileEntity.gender!,
        profileEntity.imageUrl ?? null,
        profileEntity.emailAddress!,
        profileEntity.avatarMonth!,
      );
      Nav.toAndPopUntil(
          ChangeEmailSuccessScreen.routeName, AppMainScreen.routeName,
          arguments: type);
    } else {
      UserSessionDataModel.updatePhoneNumber(newField, '00$countryCode');
      Nav.toAndPopUntil(
          ChangeEmailSuccessScreen.routeName, AppMainScreen.routeName,
          arguments: type);
    }

    notifyListeners();
  }

  void reSendOTPCodeFromFirebase() async {
    changeSendingCodeStatus();
    print('${countryCode}${newField}');
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '${countryCode}${newField}',
      verificationCompleted: (PhoneAuthCredential credential) {
        print('complete');
        changeSendingCodeStatusToFalse();
      },
      verificationFailed: (FirebaseAuthException e) {
        print('failed');
        changeSendingCodeStatusToFalse();
        print(e.message);
        print(e.code);
      },
      codeSent: (String verificationId, int? resendToken) {
        print('code sent');
        print('verificationId: ${verificationId}');
        print('$resendToken');
        changeSendingCodeStatusToFalse();
        verificationId = verificationId;
        print('aasdadad');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        changeSendingCodeStatusToFalse();
      },
    );
    // changeSendingCodeStatus();
  }

  changeSendingCodeStatusToFalse() {
    isSendingCode = false;
    notifyListeners();
  }

  changeSendingCodeStatus() {
    isSendingCode = !isSendingCode;
    notifyListeners();
  }
}
