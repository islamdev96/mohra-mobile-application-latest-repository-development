import 'dart:convert';
import 'dart:io';

import 'package:booking_system_flutter/model/user_data_model.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/common/provider/session_data.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/user_type.dart';
import 'package:starter_application/core/datasources/shared_preference.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_error_snackbar.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/toast/errv_toast_options.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/toast/show_error_toast.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/features/account/data/model/request/check_exist_userName_params.dart';
import 'package:starter_application/features/account/data/model/request/confirm_phone_number_params.dart';
import 'package:starter_application/features/account/data/model/request/login_request.dart';
import 'package:starter_application/features/account/data/model/request/register_request.dart';
import 'package:starter_application/features/account/domain/entity/login_entity.dart';
import 'package:starter_application/features/account/presentation/screen/start_personality_test.dart';
import 'package:starter_application/features/account/presentation/screen/verify_code_screen.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:starter_application/main.dart';

import '../../../../../core/common/utils.dart';
import 'firebase_otp.dart';
import 'handman_help.dart';

class SetUserNameNotifier extends ScreenNotifier {
  /// Variables
  final FocusNode userNameFocusNode = FocusNode();
  late RegisterRequest registerRequest;
  late FireBaseOTP fireBaseOTP;
  late BuildContext context;
  double? lat;
  double? lon;
  bool isSendingCode = false;

  // Key
  final userNameKey = new GlobalKey<FormFieldState<String>>();

  // Controller
  final userNameController = TextEditingController();
  final accountCubit = AccountCubit();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  @override
  void closeNotifier() {
    userNameFocusNode.dispose();
    userNameController.dispose();
  }

  void register() {
    UserSessionDataModel.provider = 'normal';
    if (userNameKey.currentState!.validate()) {
      registerRequest.userName = userNameController.text;
      accountCubit.register(
        registerRequest,
      );
    }
  }

  onNextTapped() {
    if (userNameController.text.isEmpty) {
      showSnackbar(isArabic ? "كل الحقول مطلوبة" : "All fields required");
    } else {
      checkUserNameIfExist();
    }
  }

  checkUserNameIfExist() {
    accountCubit.checkExistUsername(
        CheckIfUsernameExistParams(userName: userNameController.text));
  }

  onCheckingDone() {
    register();
  }

  onRegisterDone() async {
    confirmPhoneNumber();
  }

  confirmPhoneNumber() {
    accountCubit.confirmPhoneNumber(
        ConfirmPhoneNumberParams(phoneNumbr: registerRequest.phoneNumber!));
  }

  onPhoneNumberConfirmed() async {
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
    await getLocation();
    accountCubit.login(LoginRequest(
        userNameOrEmailAddressOrPhoneNumber: registerRequest.phoneNumber,
        password: registerRequest.password,
        countryCode: '00${registerRequest.countryCode}',
        devicedType: deviceType,
        devicedId: deviceId,
        lat: lat,
        long: lon));
  }

  Future<void> getLocation() async {
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
        loginEntity.result.avatarMonth);
    await loginHandyMan(userEntity: loginEntity);

    Nav.toAndRemoveAll(StartPersonalityTest.routeName);
  }

  Future<bool> loginHandyMan({LoginEntity? userEntity}) async {
    try {
      final prefs = await SpUtil.getInstance();
      Map<String, dynamic> request = {
        'email': userEntity!.result.emailAddress.trim(),
        'password': registerRequest.password,
        'player_id': '',
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
        ..password = registerRequest.password;
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
}
