import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/common/validators.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_error_snackbar.dart';
import 'package:starter_application/features/account/data/model/request/check_exist_email_params.dart';
import 'package:starter_application/features/account/data/model/request/check_exist_phone_params.dart';
import 'package:starter_application/features/account/data/model/request/register_request.dart';
import 'package:starter_application/features/account/presentation/screen/register_with_google_screen.dart';
import 'package:starter_application/features/account/presentation/screen/verify_code_screen.dart';
import 'package:starter_application/features/account/presentation/screen/set_username_screen.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:starter_application/main.dart';

import 'firebase_otp.dart';
import 'package:intl_phone_field/countries.dart';
class RegisterScreen2Notifier extends ScreenNotifier {
  late BuildContext context;
  late RegisterRequest registerRequest;
  bool obscureTextpssword = false;
  bool obscureTextconfirmPssword = false;
  String? firstname;
  String? lastname;
  String? date;
  Country country =  Country(name: 'Saudi Arabia',flag: '🇸🇦',code: 'SA',dialCode: '966',maxLength: 9,minLength: 9, nameTranslations: {});
  String countryCode = '+966';
  final String _initialCountryCode = "+966";
  final accountCubit = AccountCubit();
  var formkey = GlobalKey<FormState>();
  int paddingbottom = 5;
  late FireBaseOTP fireBaseOTP;
  bool isSendingCode = false;
  String phoneError = '';
  String passwordError = '';
  String passwordConfirmError = '';
  String emailError = '';

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
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodePhone = FocusNode();
  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeConfirmPassword = FocusNode();

  // Key
  final emailKey = new GlobalKey<FormFieldState<String>>();
  final phoneKey = new GlobalKey<FormFieldState<String>>();
  final PasswordKey = new GlobalKey<FormFieldState<String>>();
  final confirmPasswordKey = new GlobalKey<FormFieldState<String>>();

  // Controller
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final PasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  /// Methods

  onNextTap() {
    countryCode = countryCode
        .toString()
        .split('+')[countryCode.toString().split('+').length - 1];
    String phone = phoneController.text.startsWith('0') ? '${phoneController.text.replaceFirst('0', '')}' :'${phoneController.text}';

    if (checkIfCanPressButton()) {
      registerRequest.phoneNumber = phone;
      registerRequest.emailAddress = emailController.text;
      registerRequest.countryCode = "${countryCode}";
      registerRequest.password = PasswordController.text;
     checkValidPhoneNumber();
    }
  }


  checkValidPhoneNumber(){
    accountCubit.checkExistPhoneNumber(CheckIfPhoneExistParams(phoneNumber: registerRequest.phoneNumber! , countryCode:'+'+ registerRequest.countryCode!));
  }

  onValidPhoneNumber(){
    notifyListeners();
    checkValidEmail();
    notifyListeners();
  }

  checkValidEmail(){
    accountCubit.checkExistEmail(CheckIfEmailExistParams(email: registerRequest.emailAddress!));
    notifyListeners();
  }

  onValidEmail()async{
    print('sendingCode');
    //await Future.delayed(Duration(seconds: 20));
    verifyPhone();
    notifyListeners();
  }


  verifyPhone() async {
    changeSendingCodeStatus();
    String phone = phoneController.text.startsWith('0') ? '${phoneController.text.replaceFirst('0', '')}' :'${phoneController.text}';

    fireBaseOTP = FireBaseOTP(phoneNumber: phone, countryCode: countryCode);
    fireBaseOTP.sendCode(
      verificationCompleted: (phoneAuthCredentials){
        changeSendingCodeStatusToFalse();
        accountCubit.emit(AccountState.accountInit());
      },
      verificationFailed: (e){
        changeSendingCodeStatusToFalse();
        accountCubit.emit(AccountState.accountInit());
        print('aaaaaaaa');
        print(e.message);
        print(e.code);
        if(e.code == 'invalid-phone-number')
            showErrorSnackBar(message: isArabic ?"رقم الهاتف غير صالح" : "Phone Number is invalid", context: context,callback: verifyPhone);
        else{
          showErrorSnackBar(message: e.code , context: context,callback: verifyPhone);
        }
      },
      onCodeSent: (verificationId , resendToken){
        changeSendingCodeStatusToFalse();
        registerRequest.verificationId = verificationId;
        accountCubit.emit(AccountState.accountInit());
        registerRequest.register_or_confirm = true;
        Nav.to(VerifyCodeScreen.routeName, arguments: [registerRequest, true]);
      },
    );
  }

  changeSendingCodeStatus() {
    isSendingCode = !isSendingCode;
    notifyListeners();
  }

  changeSendingCodeStatusToFalse() {
    isSendingCode = false;
    notifyListeners();
  }

  bool checkIfCanPressButton(){
    String phone = phoneController.text.startsWith('0') ? '${phoneController.text.replaceFirst('0', '')}' :'${phoneController.text}';

    validateEmail(emailController.text);
    validatePhoneNumber(phone,country.maxLength);
    validatePassword(PasswordController.text);
    validateConfirmPassword(confirmPasswordController.text);
     if(emailError != ''){
    showErrorSnackBar(message: emailError);
    return false;
    }
    else if(phoneError != ''){
      showErrorSnackBar(message: phoneError);
      return false;
    }

    else if(passwordError != ''){
      showErrorSnackBar(message: passwordError);
      return false;
    }
    else if(passwordConfirmError != ''){
      showErrorSnackBar(message: passwordConfirmError);
      return false;
    }

    else {
      return true;
    }
  }

  registerWithGoogle() {
    String googleToken = '';
    Nav.to(RegisterWithGoogleScreen.routeName,
        arguments: [registerRequest, googleToken]);
  }

  @override
  void closeNotifier() {
    myFocusNodeEmail.dispose();
    myFocusNodePhone.dispose();
    emailController.dispose();
    phoneController.dispose();
  }


  /// UI Controls

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

  validatePhoneNumber(String? phone,int? phoneLength) {
    if ((phone == null || (phone.trim().isEmpty))){
      phoneError = isArabic ?"لا يمكن لهذا الحقل أن يكون فارغا" : "This field mustn't be empty";
    }
    if (phone!.length < (phoneLength ?? 9)) {
      phoneError =isArabic ? "رقم الهاتف المحمول غير صالح":"Phone not valid";
    }
    else
      phoneError = '';

    notifyListeners();
  }

  validatePassword(String? value) {
    if ((value == null || (value.trim().isEmpty)))
      passwordError = isArabic ?"لا يمكن لهذا الحقل أن يكون فارغا" : "This field mustn't be empty";
    passwordError = Validators.isValidPassword(value!) ?? '';

    notifyListeners();
  }

  validateConfirmPassword(String? value) {
    if (value == null || (value.trim().isEmpty))
      passwordConfirmError = isArabic ?"لا يمكن لهذا الحقل أن يكون فارغا" : "This field mustn't be empty";
    else if (!Validators.isValidConfirmPassword(PasswordController.text, value)){
      passwordConfirmError = isArabic ? "كلمة السر وتأكيد كلمة السر غير متطابقتين" : "Password and confirm password doesn't match";
    }
    else
      passwordConfirmError = Validators.isValidPassword(value) ?? '';

    notifyListeners();
  }

  validateEmail(String? value) {
    if (value == null || (value.trim().isEmpty))
      emailError = isArabic ?"لا يمكن لهذا الحقل أن يكون فارغا" : "This field mustn't be empty";
    if (!Validators.isValidEmail(value!))
      emailError = isArabic ?"الايميل غير صالح" : "Email not valid";
    else
      emailError = '';

    notifyListeners();
  }
}
