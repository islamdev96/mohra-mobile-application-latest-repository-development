import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/login_model.dart';
import 'package:booking_system_flutter/model/user_data_model.dart';
import 'package:booking_system_flutter/network/network_utils.dart';
import 'package:booking_system_flutter/screens/auth/auth_user_services.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class HandManHelp {
  static Future<LoginResponse> loginCurrentUsers(BuildContext context,
      {required Map<String, dynamic> req,
      bool isSocialLogin = false,
      bool isOtpLogin = false}) async {
    String? uid = req['uid'];

    final userValue = await loginUser(req, isSocialLogin: false);
    HandManHelp.firebaseLogin(context, data: userValue.userData!);

    if (userValue.userData != null && userValue.userData!.status == 0) ;
    userValue.userData?.uid = uid;

    return userValue;
  }

  static Future<LoginResponse> loginUser(Map request,
      {bool isSocialLogin = false}) async {
    LoginResponse res = LoginResponse.fromJson(await handleResponse(
        await buildHttpResponse(isSocialLogin ? 'social-login' : 'login',
            request: request, method: HttpMethodType.POST)));

    if (res.userData != null && res.userData!.userType != USER_TYPE_USER) {}

    return res;
  }

  static Future<LoginResponse> createUser(Map request,
      {bool isSocialLogin = false}) async {
    LoginResponse res = LoginResponse.fromJson(await (handleResponse(
        await buildHttpResponse('register',
            request: request, method: HttpMethodType.POST))));

    return res;
  }

  static Future<String> firebaseLogin(BuildContext context,
      {required UserData data}) async {
    try {
      final firebaseEmail = data.email.validate();
      final firebaseUid =
          await authService.signInWithEmailPassword(email: firebaseEmail);

      log("***************** User Already Registered in Firebase*****************");

      if (await userService.isUserExistWithUid(firebaseUid)) {
        return firebaseUid;
      } else {
        data.uid = firebaseUid;
        return await authService
            .setRegisterData(userData: data)
            .catchError((ee) {
          throw "Cannot Register";
        });
      }
    } catch (e) {
      log("======= $e");
      if (e.toString() == USER_NOT_FOUND) {
        log("***************** ($e) User Not Found, Again registering the current user *****************");

        return await registerUserInFirebase(context, user: data);
      } else {
        throw e.toString();
      }
    }
  }
}
