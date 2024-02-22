import 'package:country_list_pick/country_list_pick.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_error_snackbar.dart';
import 'package:starter_application/features/account/data/model/request/check_exist_phone_params.dart';
import 'package:starter_application/features/account/data/model/request/forgetpassword_request.dart';
import 'package:starter_application/features/account/data/model/request/register_request.dart';
import 'package:starter_application/features/account/presentation/screen/verify_code_screen.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';
import 'package:starter_application/features/home/presentation/screen/app_main_screen.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:starter_application/main.dart';

import 'firebase_otp.dart';

class ForgetPasswordScreenNotifier extends ScreenNotifier {
  late BuildContext context;
  final accountCubit = AccountCubit();
  RegisterRequest registerRequest = RegisterRequest();
  TextInputType keyboard = TextInputType.number;
  bool isSendingCode = false;
  String byPhone="phone",byEmail="email",selected="phone";
  late FireBaseOTP fireBaseOTP;

  /// Variables
  final FocusNode myFocusNodePhone = FocusNode();
  final FocusNode myFocusNodeemail = FocusNode();

  // Key
  final phoneKey = new GlobalKey<FormFieldState<String>>();
  final emailKey = new GlobalKey<FormFieldState<String>>();

  // Controller
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  /// Methods
  var formkey = GlobalKey<FormState>();
  String countryCode = '+966';
  final String _initialCountryCode = "+966";

  onNextTap() {
    registerRequest = RegisterRequest();
    if(selected==byPhone){
      countryCode =  countryCode
          .toString()
          .split('+')[countryCode.toString().split('+').length - 1];
      if (phoneController.text.length > 8) {
        checkIfPhoneExist();
      }
      else {
        showErrorSnackBar(message: "Please enter the correct number");
      }
    }
    else{
      if(emailController.text.isNotEmpty){
        registerRequest.emailAddress = emailController.text;
        accountCubit.ForgetPassword(ForgetPasswordRequest(
            usernameOrEmailOrPhone: emailController.text));
      }
      else {
        showErrorSnackBar(message: "Please enter the correct email");
      }
    }

  }

  checkIfPhoneExist(){
    accountCubit.checkExistPhoneNumber(CheckIfPhoneExistParams(phoneNumber: phoneController.text, countryCode:  '+'+countryCode));
  }

  onPhoneNumberCheckingDone(){
    verifyPhone();
    notifyListeners();
  }


  onCodeVerifyDone(){
    Nav.to(VerifyCodeScreen.routeName,
        arguments: [registerRequest , false]);
  }

  @override
  void closeNotifier() {
    myFocusNodePhone.dispose();
    phoneController.dispose();
  }

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

  changeBy(){
    print('by');
    notifyListeners();
  }

  verifyPhone() async {
    RegisterRequest registerRequest = RegisterRequest(
      phoneNumber: phoneController.text,
      countryCode: countryCode,
    );
    print(countryCode);
    print(phoneController.text);
    changeSendingCodeStatus();
    accountCubit.emit(AccountState.accountLoading());

    fireBaseOTP = FireBaseOTP(phoneNumber: phoneController.text, countryCode: countryCode);
    fireBaseOTP.sendCode(
      verificationCompleted: (phoneAuthCredentials){
        changeSendingCodeStatusToFalse();
        accountCubit.emit(AccountState.accountInit());
      },
      verificationFailed: (e){
        changeSendingCodeStatusToFalse();
        accountCubit.emit(AccountState.accountInit());
        print('Data retreived from firebase is ');
        print(e.code);
        print(e.message);
        showErrorSnackBar(message: e.message, context: context,callback: verifyPhone);
      },
      onCodeSent: (verificationId , resendToken){
        changeSendingCodeStatusToFalse();
        registerRequest.verificationId = verificationId;
        accountCubit.emit(AccountState.accountInit());
        Nav.to(VerifyCodeScreen.routeName , arguments: [registerRequest,false]);
      },
    );
  }



  changeSendingCodeStatus(){
    isSendingCode = !isSendingCode;
    notifyListeners();
  }

  changeSendingCodeStatusToFalse(){
    isSendingCode = false;
    notifyListeners();
  }


}
