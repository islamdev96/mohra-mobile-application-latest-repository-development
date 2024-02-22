import 'dart:io';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/provider/session_data.dart';
import 'package:starter_application/core/common/validators.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/datasources/shared_preference.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/dialogs/show_custom_date_picker.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/features/account/data/model/request/google_register_params.dart';
import 'package:starter_application/features/account/data/model/request/register_request.dart';
import 'package:starter_application/features/account/domain/entity/login_entity.dart';
import 'package:starter_application/features/account/presentation/screen/start_personality_test.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';
import 'package:starter_application/generated/l10n.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';
import '../../../../../main.dart';

class RegisterWithGoogleScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  late RegisterRequest registerRequest;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  DateTime? _date;
  bool _isDateValidate = false;
  bool errorWhenGettingToken = true;

  /// Getters and Setters

  String countryCode = '+966';
  final String _initialCountryCode = "+966";
  final accountCubit = AccountCubit();
  var formkey = GlobalKey<FormState>();

  /// Variables
  final FocusNode myFocusNodePhone = FocusNode();
  final FocusNode userNameFocusNode = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();
  final FocusNode myFocusNodeLastName = FocusNode();

  // Key
  final phoneKey = new GlobalKey<FormFieldState<String>>();
  final userNameKey = new GlobalKey<FormFieldState<String>>();
  final nameKey = new GlobalKey<FormFieldState<String>>();
  final lastNameKey = new GlobalKey<FormFieldState<String>>();

  // Controller
  final phoneController = TextEditingController();
  final userNameController = TextEditingController();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();

  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }

  /// api call and logic

  onRegisterTapped() async {
    UserSessionDataModel.provider = 'google';
    if (canRegister()) {
      String tokenId = await getGoogleToken();
      print('aaaaaaaaaaaaaaaa $tokenId');
      if (errorWhenGettingToken) {
        showSnackbar('$tokenId', isError: true);
      } else {
        registerWithGoogleServerSide(tokenId);
      }
    } else {
      showSnackbar(Translation.current.all_fields_required, isError: true);
    }
  }

  Future<String> getGoogleToken() async {
    try {
      var x = await _googleSignIn.signIn();
      if (x != null) {
        var value = await x.authentication;
        errorWhenGettingToken = false;
        print('tokeeen');
        print(value.idToken);
        print(value.accessToken);
        return value.idToken ?? '';
      } else {
        return 'error';
      }
    } on FirebaseAuthException catch (error) {
      print(error.message);
      print('faaaaaaaaaailed');
      return error.message ?? 'Error';
    }
  }

  registerWithGoogleServerSide(String tokenId) {
    print('dddddddddd');
    countryCode = countryCode
        .toString()
        .split('+')[countryCode.toString().split('+').length - 1];
    String phoneNumber = phoneController.text;
    if (phoneNumber[0] == '0') {
      // phoneNumber = phoneNumber.substring(1);
    }

    GoogleRegisterParams params = GoogleRegisterParams(
      googleToken: tokenId,
      phoneNumber: '$phoneNumber',
      countryCode: '00$countryCode',
      firstName: nameController.text,
      birthDate: date!.toUtc().toString(),
      userName: userNameController.text,
      lastName: lastNameController.text,
    );
    print('aaaaaaa');
    print(params);
    accountCubit.registerWithGoogle(params);
  }

  onRegisterDone(LoginEntity loginEntity) async {
    final prefs = await SpUtil.getInstance();
    await prefs.putString(
        AppConstants.KEY_TOKEN, 'Bearer ${loginEntity.result.accessToken}');
    await prefs.putInt(AppConstants.KEY_USERID, loginEntity.result.userId);
    final session = Provider.of<SessionData>(context, listen: false);
    await session.getSessionDataFromSP();
    await UserSessionDataModel.saveProfile(
      loginEntity.result.accessToken,
      loginEntity.result.userId,
      loginEntity.result.shopId,
      loginEntity.result.userType,
      loginEntity.result.fullName,
      loginEntity.result.name,
      loginEntity.result.birthday,
      loginEntity.result.surname,
      loginEntity.result.emailAddress,
      loginEntity.result.isEmailConfirmed,
      loginEntity.result.phoneNumber,
      loginEntity.result.isPhoneNumberConfirmed,
      loginEntity.result.cityId,
      loginEntity.result.imageUrl,
      loginEntity.result.cover,
      loginEntity.result.code,
      loginEntity.result.points,
      loginEntity.result.status,
      loginEntity.result.gender,
      loginEntity.result.userName,
      loginEntity.result.address,
      loginEntity.result.qrCode,
      loginEntity.result.countryCode,
      loginEntity.result.avatarMonth,
    );

    Nav.toAndRemoveAll(StartPersonalityTest.routeName);
  }

  /// setter and getter and UI control

  DateTime? get date => this._date;

  set date(DateTime? date) {
    this._date = date;
    notifyListeners();
  }

  bool get isDateValidate => this._isDateValidate;

  set isDateValidate(bool value) {
    this._isDateValidate = value;
    notifyListeners();
  }

  Future<void> onDatePickerTap() async {
    isDateValidate = true;

    if (FocusScope.of(context).hasFocus) FocusScope.of(context).unfocus();

    if (Platform.isAndroid) {
      final selectedDate = await showCustomDatePicker(
        context: context,
        initialDate: date ?? DateTime.now(),
        firstDate: DateTime(1980),
        lastDate: DateTime.now(),
      );
      if (selectedDate != null) {
        date = selectedDate;
      }
    } else if (Platform.isIOS) {
      _showDialog();
    }
  }

  void _showDialog() {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 300,
              padding: const EdgeInsets.only(top: 6.0),
              color: CupertinoColors.systemBackground.resolveFrom(context),
              child: Column(
                children: [
                  SafeArea(
                    top: false,
                    child: Container(
                      height: 216,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (DateTime value) {
                          print(value);
                          date = value;
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomMansourButton(
                        width: 150,
                        titleText: Translation.current.cancel,
                        backgroundColor: Colors.white,
                        borderColor: AppColors.primaryColorLight,
                        textColor: AppColors.primaryColorLight,
                        onPressed: () {
                          date = null;
                          Nav.pop();
                        },
                      ),
                      CustomMansourButton(
                        width: 150,
                        titleText: Translation.current.confirm,
                        textColor: AppColors.lightFontColor,
                        onPressed: () {
                          Nav.pop();
                          notifyListeners();
                        },
                      )
                    ],
                  )
                ],
              ),
            ));
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
        searchHintText: (isArabic ? "البحث" : "Search") + "...🏳️",
        searchText: (isArabic ? "البحث" : "Search"),
      ),
      onChanged: (v) {
        countryCode = v!.dialCode!;
        notifyListeners();
      },
      initialSelection: _initialCountryCode,
    );
  }

  bool canRegister() {
    String phoneNumber = phoneController.text[0] == '0'
        ? phoneController.text.substring(1)
        : phoneController.text;
    if (nameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        date != null &&
        userNameController.text.isNotEmpty &&
        phoneNumber.length >= 9) {
      return true;
    }
    return false;
  }
}
