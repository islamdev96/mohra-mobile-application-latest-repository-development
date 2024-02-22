import 'package:country_list_pick/country_list_pick.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_error_snackbar.dart';
import 'package:starter_application/features/account/data/model/request/check_exist_phone_params.dart';
import 'package:starter_application/features/account/domain/entity/check_exist_phone_entity.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';
import 'package:starter_application/features/account/presentation/state_m/provider/firebase_otp.dart';
import 'package:starter_application/features/user/data/model/request/change_email_params.dart';
import 'package:starter_application/features/user/presentation/screen/change_email_confirm_screen.dart';
import 'package:starter_application/features/user/presentation/state_m/cubit/user_cubit.dart';
import 'package:starter_application/generated/l10n.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';
import '../../../../../main.dart';

class ChangeEmailScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  late int type;
  String countryCode = '+966';
  final String _initialCountryCode = "+966";
  final userCubit = UserCubit();
  final accountCubit = AccountCubit();
  bool isSendingCode = false;
  late FireBaseOTP fireBaseOTP;

  /// Getters and Setters

  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }

  TextEditingController oldEmail = TextEditingController();
  TextEditingController newEmail = TextEditingController();

  showCountryCode2() {
    return CountryListPick(
      pickerBuilder: (context, CountryCode? countryCode) {
        return Image.asset(
          countryCode!.flagUri!,
          package: 'country_list_pick',
          fit: BoxFit.fill,
          width: 100.w,
          height: 60.h,
        );
      },
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      theme: CountryTheme(
        labelColor: Colors.grey,
        alphabetTextColor: Colors.grey,
        alphabetSelectedTextColor: Colors.grey,
        alphabetSelectedBackgroundColor: Colors.orange,
        isShowFlag: true,
        isShowTitle: true,
        isShowCode: false,
        isDownIcon: false,
        showEnglishName: true,
        lastPickText: isArabic ? "اخر اختيار" : "LAST PICK",
        searchHintText: (isArabic ? "البحث" : "Search") +"...🏳️",
        searchText: (isArabic ? "البحث" : "Search"),
      ),
      onChanged: (v) {
        countryCode = v!.dialCode!;
        notifyListeners();
      },
      initialSelection: _initialCountryCode,
    );
  }

  countinueTapped() async {
    print('aaa');

    /*   await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+${countryCode} ${newEmail.text}',
      verificationCompleted: (PhoneAuthCredential credential) {
        print(credential.smsCode);
      },
      verificationFailed: (FirebaseAuthException e) {
        print('error');
        print(e.message);
        print(e.code);
      },
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );*/
    userCubit.changeEmail(ChangeEmailParams(newEmail: newEmail.text));
  }

  onChangeEmailDone() {
    Nav.to(
      ChangeEmailConfirmScreen.routeName,
      arguments: {
        'type': type,
        'new_field': newEmail.value.text,
        'country_code': '',
        'verificationId': ''
      },
    );
  }

  changeSendingCodeStatus() {
    isSendingCode = !isSendingCode;
    notifyListeners();
  }

  void sendOTPCodeFromFirebase() async {
    changeSendingCodeStatus();
    print('${countryCode}${newEmail.text}');
    fireBaseOTP =
        FireBaseOTP(phoneNumber: newEmail.text, countryCode: countryCode);
    await fireBaseOTP.sendCode(
        verificationCompleted: (PhoneAuthCredential credential) {
          print('complete');
          changeSendingCodeStatusToFalse();
        },
        verificationFailed: (FirebaseAuthException e) {
          print('failed');
          changeSendingCodeStatusToFalse();
          if(e.code == 'invalid-phone-number')
            showErrorSnackBar(message: Translation.current.invalid_phone_number_firebase, context: context,callback: sendOTPCodeFromFirebase);
          else{
            showErrorSnackBar(message: e.code , context: context,callback: sendOTPCodeFromFirebase);
          }

        },
        onCodeSent : (String verificationId, int? resendToken) {
          print('code sent');
          print('verificationId: ${verificationId}');
          print('$resendToken');
          changeSendingCodeStatusToFalse();
          Nav.to(
            ChangeEmailConfirmScreen.routeName,
            arguments: {
              'type': type,
              'new_field': newEmail.value.text,
              'country_code': countryCode,
              'verificationId': verificationId
            },
          );
          print('aasdadad');
        });
    // changeSendingCodeStatus();
  }

  changeSendingCodeStatusToFalse() {
    isSendingCode = false;
    notifyListeners();
  }

  checkNumberAvailable() {
    print(countryCode);
    countryCode = countryCode
        .toString()
        .split('+')[countryCode.toString().split('+').length - 1];
    accountCubit.checkExistPhoneNumber(CheckIfPhoneExistParams(
        phoneNumber: newEmail.text, countryCode: '+$countryCode'));
  }

  checkDone() {
    sendOTPCodeFromFirebase();
  }
}
