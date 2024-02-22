import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:booking_system_flutter/model/user_data_model.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/common/provider/session_data.dart';
import 'package:starter_application/core/common/validators.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/user_type.dart';
import 'package:starter_application/core/datasources/shared_preference.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/errv_snack_bar_options.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_error_snackbar.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/toast/errv_toast_options.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/toast/show_error_toast.dart';
import 'package:starter_application/features/account/data/model/request/google_login_params.dart';
import 'package:starter_application/features/account/data/model/request/login_request.dart';
import 'package:starter_application/features/account/data/model/request/register_request.dart';
import 'package:starter_application/features/account/domain/entity/login_entity.dart';
import 'package:starter_application/features/account/presentation/screen/forgetPassword_screen.dart';
import 'package:starter_application/features/account/presentation/screen/register_with_google_screen.dart';
import 'package:starter_application/features/account/presentation/screen/start_personality_test.dart';
import 'package:starter_application/features/account/presentation/screen/verify_code_screen.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';
import 'package:starter_application/features/event/presentation/screen/my_running_events_screen.dart';
import 'package:starter_application/features/home/presentation/screen/app_main_screen.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/global_messages_notifier.dart';
import 'package:starter_application/features/personality/domain/entity/has_avatar_entity.dart';
import 'package:starter_application/features/personality/presentation/state_m/cubit/personality_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../../core/bloc/global/glogal_cubit.dart';
import '../../../../../core/common/app_config.dart';
import '../../../../../core/common/utils.dart';
import '../../../../../core/localization/localization_provider.dart';
import '../../../../../core/localization/restart_widget.dart';
import '../../../../../main.dart';
import '../../../../event_orginizer/presentation/screen/event_organizer_screen.dart';
import '../../../data/model/response/handman_login_model.dart';
import 'firebase_otp.dart';
import 'package:intl_phone_field/countries.dart';

import 'handman_help.dart';
import 'package:devicelocale/devicelocale.dart';

class LoginScreenNotifier extends ScreenNotifier {
  late BuildContext context;
  bool obscureText = false;
  String countryCode = '+966';
  Country country = Country(
      name: 'Saudi Arabia',
      flag: '🇸🇦',
      code: 'SA',
      dialCode: '966',
      maxLength: 9,
      minLength: 9,
      nameTranslations: {});
  final String _initialCountryCode = "+966";
  var formkey = GlobalKey<FormState>();
  int paddingbottom = 5;
  final accountCubit = AccountCubit();
  final personalityCubit = PersonalityCubit();
  bool isSendingCode = false;
  double? lat;
  double? lon;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  late FireBaseOTP fireBaseOTP;
  String phoneError = '';
  String passwordError = '';
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  /// 0 for normal , 1 for google login
  int loginType = 0;

  bool isGettingGoogleToken = false;

  /// Variables
  final FocusNode myFocusNodePassord = FocusNode();
  final FocusNode myFocusNodePhone = FocusNode();

  // Key
  final PasswordKey = new GlobalKey<FormFieldState<String>>();
  final phoneKey = new GlobalKey<FormFieldState<String>>();

  // Controller
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  /// Methods
  isPassword() {
    obscureText ? obscureText = false : obscureText = true;
    notifyListeners();
  }

  loginWithServer() async {
    UserSessionDataModel.provider = 'normal';
    countryCode = countryCode
        .toString()
        .split('+')[countryCode.toString().split('+').length - 1];
    if (passwordError != '' && phoneError != '') {
      showErrorSnackBar(message: Translation.current.all_fields_required);
    } else {
      int deviceType = 0;
      String deviceId = '';
      if (Platform.isAndroid) {
        deviceType = 1;
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id;
      } else if (Platform.isIOS) {
        deviceType = 2;
        IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
        deviceId = iosDeviceInfo.identifierForVendor;
      }
      String phone = phoneController.text.startsWith('0')
          ? '${phoneController.text.replaceFirst('0', '')}'
          : '${phoneController.text}';
      // await getLocation();
      LoginRequest loginRequest = LoginRequest(
          password: passwordController.text,
          countryCode: '00$countryCode',
          userNameOrEmailAddressOrPhoneNumber: phone,
          devicedType: deviceType,
          devicedId: deviceId,
          lat: lat,
          long: lon);
      print(loginRequest);
      accountCubit.login(loginRequest);
    }
  }

  handleError(AccountError error) {
    if (loginType == 0) {
      /// normal login
      print('type : ${error.error.runtimeType}');
      error.error.mapOrNull(internalServerError: (s) {
        ErrorViewer.showError(
            errorViewerOptions: const ErrVSnackBarOptions(),
            context: context,
            error: s,
            callback: () {});
      }, internalServerWithDataError: (s) async {
        if (s.message == 'The phoneNumber is not confirmed') {
          verifyPhone();
        }
        ErrorViewer.showError(
            errorViewerOptions: const ErrVSnackBarOptions(),
            context: context,
            error: s,
            callback: () {});
      });
    } else {
      error.error.mapOrNull(internalServerError: (s) {
        ErrorViewer.showError(
            errorViewerOptions: const ErrVSnackBarOptions(),
            context: context,
            error: s,
            callback: () {});
      }, internalServerWithDataError: (s) {
        if (s.message == '[The user isnt exist]') {
          Nav.to(RegisterWithGoogleScreen.routeName);
        }
        ErrorViewer.showError(
            errorViewerOptions: const ErrVSnackBarOptions(),
            context: context,
            error: s,
            callback: () {});
      });
    }
  }

  verifyPhone() async {
    RegisterRequest registerRequest = RegisterRequest(
      password: passwordController.text,
      phoneNumber: phoneController.text,
      countryCode: countryCode,
    );
    changeSendingCodeStatus();
    fireBaseOTP = FireBaseOTP(
        phoneNumber: phoneController.text, countryCode: countryCode);
    fireBaseOTP.sendCode(
      verificationCompleted: (phoneAuthCredentials) {
        changeSendingCodeStatusToFalse();
        accountCubit.emit(AccountState.accountInit());
      },
      verificationFailed: (e) {
        changeSendingCodeStatusToFalse();
        accountCubit.emit(AccountState.accountInit());

        showErrorSnackBar(
            message: e.message, context: context, callback: verifyPhone);
      },
      onCodeSent: (verificationId, resendToken) {
        changeSendingCodeStatusToFalse();
        registerRequest.verificationId = verificationId;
        accountCubit.emit(AccountState.accountInit());
        registerRequest.register_or_confirm == false;
        Nav.to(VerifyCodeScreen.routeName, arguments: [registerRequest, true]);
      },
    );
  }

  Future<void> onLoginsuccess(LoginEntity loginEntity) async {
    final userType = int2UserType(loginEntity.result.userType);
    if (userType == UserType.OTHER) {
      showErrorToast(
          message: "Phone number or password are not correct",
          errVToastOptions: const ErrVToastOptions());
      return;
    }
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
    BlocProvider.of<GlogalCubit>(AppConfig().appContext, listen: false)
        .getAuth();
    if (userType == UserType.CLIENT) {
      changeLanguage(context);
      Provider.of<GlobalMessagesNotifier>(context, listen: false).init();
      getAvatar();
      await loginHandyMan(userEntity: loginEntity);
      //Nav.toAndRemoveAll(AppMainScreen.routeName);
    }
    if (userType == UserType.EventOrganizer)
      Nav.toAndRemoveAll(EventOrganizerScreen.routeName);

    AppConfig().getHandyManService();
  }

  forgetpassword() {
    Nav.to(ForgetPasswordScreen.routeName);
  }

  getLocation() async {
    final location = await getUserLocationLogic(
        onBackTap: () {
          Nav.pop();
        },
        onRetryTap: () {
          getLocation();
          Nav.pop();
        },
        withoutDialogue: true);
    if (location != null) {
      lon = location.longitude;
      lat = location.latitude;
      notifyListeners();
    }
  }

  getAvatar() {
    accountCubit.checkHasAvatar(NoParams());
  }

  void changeLanguage(BuildContext context) async {
    String? lang = await Devicelocale.currentLocale;
    await Provider.of<LocalizationProvider>(context, listen: false)
        .changeLanguage(Locale(lang ?? "en"), context);
    AppConfig().setAppLanguage = Locale(lang ?? "en").languageCode;
    // if (AppConfig().appOptions.changeLangRestart)
    //   RestartWidget.restartApp(context);
  }

  Future<bool> loginHandyMan({LoginEntity? userEntity}) async {
    try {
      String? firebaseToken = await FirebaseMessaging.instance.getToken();

      final prefs = await SpUtil.getInstance();
      Map<String, dynamic> request = {
        'email': userEntity!.result.emailAddress.trim(),
        'password': passwordController.text.trim(),
        'player_id': '',
        'token': firebaseToken
      };
      var res = await HandManHelp.loginCurrentUsers(context, req: request);

      final userDataJson = json.encode(res.toJson());
      await prefs.putString(AppConstants.KEY_HANDYMAN_SERVICE, userDataJson);
      return true;
    } catch (e) {
      registerHandyMan(userEntity: userEntity);
      return false;
    }
  }

  Future<bool> registerHandyMan({LoginEntity? userEntity}) async {
    try {
      UserData userResponse = UserData()
        ..contactNumber = userEntity!.result.phoneNumber
        ..firstName = userEntity.result.name
        ..lastName = userEntity.result.surname
        ..loginType = "mobile"
        ..username = userEntity.result.fullName
        ..email = userEntity.result.emailAddress
        ..password = passwordController.text;
      await HandManHelp.createUser(userResponse.toJson())
          .then((registerResponse) async {
        var response = registerResponse;

        await loginHandyMan(
          userEntity: userEntity,
        );
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  gettingAvatarDone(HasAvatarEntity hasAvatarEntity) async {
    if (hasAvatarEntity.hasAvatar) {
      final prefs = await SpUtil.getInstance();
      prefs.putBool(AppConstants.HAS_PERSONALITY_AVATAR, true);
      Nav.toAndRemoveAll(AppMainScreen.routeName);
    } else {
      Nav.toAndRemoveAll(StartPersonalityTest.routeName);
    }
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

  loginWithGoogle() async {
    UserSessionDataModel.provider = 'google';
    isGettingGoogleToken = true;
    notifyListeners();
    try {
      var x = await _googleSignIn.signIn();
      if (x != null) {
        x.authentication.then((value) {
          print('google auth info');
          print('access token ${value.accessToken}');
          print('id token : ${value.idToken}');
          isGettingGoogleToken = false;
          notifyListeners();
          checkGoogleLogin(value.idToken!);
        });
      } else {
        isGettingGoogleToken = false;
        notifyListeners();
      }
    } catch (error) {
      print(error);
      print('faaaaaaaaaailed');
      isGettingGoogleToken = false;
      notifyListeners();
    }
  }

  checkGoogleLogin(String googleToken) {
    accountCubit.loginWithGoogle(GoogleLoginParams(googleToken: googleToken));
  }

  whenGoogleLoginDone(LoginEntity loginEntity) async {
    final userType = int2UserType(loginEntity.result.userType);
    if (userType == UserType.OTHER) {
      showErrorToast(
          message: "Phone number or password are not correct",
          errVToastOptions: const ErrVToastOptions());
      return;
    }
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

    if (userType == UserType.CLIENT) {
      Provider.of<GlobalMessagesNotifier>(context, listen: false).init();
      getAvatar();
      //Nav.toAndRemoveAll(AppMainScreen.routeName);
    }
  }

  @override
  void closeNotifier() {
    myFocusNodePassord.dispose();
    myFocusNodePhone.dispose();
    passwordController.dispose();
    phoneController.dispose();
  }

  changeSendingCodeStatus() {
    isSendingCode = !isSendingCode;
    notifyListeners();
  }

  changeSendingCodeStatusToFalse() {
    isSendingCode = false;
    notifyListeners();
  }

  validatePhoneNumber(String? phone, int? phoneLength) {
    if ((phone == null || (phone.trim().isEmpty)))
      phoneError = Translation.of(context).errorEmptyField;
    if (phone!.length < (phoneLength ?? 9)) {
      phoneError = Translation.of(context).validatorMobileNumber;
    } else
      phoneError = '';

    notifyListeners();
  }

  validatePassword(String? value) {
    if ((value == null || (value.trim().isEmpty)))
      passwordError = Translation.of(context).errorEmptyField;
    else {
      passwordError = Validators.isValidPassword(value) ?? '';
    }

    notifyListeners();
  }
}
