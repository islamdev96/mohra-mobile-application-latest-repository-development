import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/common/validators.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/navigation/animations/animated_route.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/errv_snack_bar_options.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/account/presentation/screen/register_screen1.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';
import 'package:starter_application/features/account/presentation/state_m/provider/login_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';
import 'dart:ui' as ui;

import '../../../../core/bloc/global/glogal_cubit.dart';
import '../../../../core/common/app_config.dart';
import '../../../../main.dart';
import '../../../home/presentation/screen/app_main_screen.dart';
import '../state_m/provider/handman_help.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/LoginScreen";

  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginScreenNotifier sn = LoginScreenNotifier();

  void initState() {
    super.initState();
    /*_googleSignIn.onCurrentUserChanged.listen((event) {
      setState(() {
        _currentUser = event;
      });
    });*/
    //_googleSignIn.signInSilently();
    sn.getLocation();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginScreenNotifier>.value(
      value: sn,
      builder: (context, _) {
        context.watch<LoginScreenNotifier>();
        sn.context = context;
        return Directionality(
          textDirection: isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr,
          child: Scaffold(
            appBar: buildAppbar(actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isArabic = false;
                        });
                      },
                      child: Text(
                        "English",
                        style: TextStyle(
                          color: AppColors.mansourBackArrowColor2,
                          fontSize: 45.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      " | ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 45.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isArabic = true;
                        });
                      },
                      child: Text(
                        "عربي",
                        style: TextStyle(
                          color: AppColors.mansourBackArrowColor2,
                          fontSize: 45.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
            body: Form(
              key: sn.formkey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: AutofillGroup(
                  onDisposeAction: AutofillContextAction.commit,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildAppbarTitle(isArabic ? "تسجيل الدخول" : "login"),
                      Gaps.vGap256,
                      Padding(
                        padding: EdgeInsets.only(
                          right: AppConstants.screenPadding.right,
                          left: AppConstants.screenPadding.right,
                          bottom: AppConstants.screenPadding.right,
                        ),
                        child: SlidingAnimated(
                          initialOffset: 5,
                          intervalStart: 0.1,
                          intervalEnd: 0.2,
                          child: _buildPhoneField(),
                        ),
                      ),
                      Visibility(
                        visible: sn.phoneError != '',
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: AppConstants.screenPadding.right,
                            bottom: AppConstants.screenPadding.right,
                          ),
                          child: SlidingAnimated(
                            initialOffset: 5,
                            intervalStart: 0.1,
                            intervalEnd: 0.2,
                            child: Text(
                              sn.phoneError,
                              style: TextStyle(
                                  color: AppColors.redColor, fontSize: 40.sp),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: AppConstants.screenPadding.right,
                          right: AppConstants.screenPadding.right,
                          bottom: AppConstants.screenPadding.right * 2,
                        ),
                        child: SlidingAnimated(
                            initialOffset: 5,
                            intervalStart: 0,
                            intervalEnd: 0.1,
                            child: _buildpassword()),
                      ),
                      Visibility(
                        visible: sn.passwordError != '',
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: AppConstants.screenPadding.right,
                            bottom: AppConstants.screenPadding.right,
                          ),
                          child: SlidingAnimated(
                            initialOffset: 5,
                            intervalStart: 0.1,
                            intervalEnd: 0.2,
                            child: Text(
                              sn.passwordError,
                              style: TextStyle(
                                  color: AppColors.redColor, fontSize: 40.sp),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 25.h,
                          left: AppConstants.screenPadding.right,
                          right: AppConstants.screenPadding.right,
                        ),
                        child: InkWell(
                          onTap: () => sn.forgetpassword(),
                          child: Text(
                            isArabic
                                ? "هل نسيت كلمة المرور ؟"
                                : "Forget Password?",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      Gaps.vGap256,
                      BlocConsumer<AccountCubit, AccountState>(
                          listener: (context, state) {
                            state.mapOrNull(
                              accountError: (s) {
                                sn.handleError(s);
                              },
                              loginLoaded: (s) {
                                sn.onLoginsuccess(s.loginEntity);
                              },
                              hasAvatarChecked: (s) {
                                sn.gettingAvatarDone(s.hasAvatarEntity);
                              },
                              loginWithGoogleDone: (s) {
                                sn.whenGoogleLoginDone(s.loginEntity);
                              },
                            );
                          },
                          bloc: sn.accountCubit,
                          builder: (context, state) {
                            return state.maybeMap(
                              hasAvatarChecked: (s) => _buildScreen(),
                              getAvatar: (s) => TextWaitingWidget(isArabic
                                  ? "جاري التحقق من اختبار الشخصية"
                                  : "Checking Personality"),
                              accountError: (s) => _buildScreen(),
                              accountInit: (s) => _buildScreen(),
                              accountLoading: (s) => WaitingWidget(),
                              loginLoaded: (s) => _buildScreen(),
                              registerLoaded: (s) => _buildScreen(),
                              verifyLoaded: (s) => _buildScreen(),
                              loginWithGoogleDone: (s) => _buildScreen(),
                              orElse: () => _buildScreen(),
                            );
                          }),
                      Padding(
                        padding: AppConstants.screenPadding,
                        child: GestureDetector(
                          onTap: () {
                            Nav.off(RegisterScreen1.routeName);
                          },
                          child: Text(
                            isArabic
                                ? "ليس لديك حساب"
                                : "Don't have an account?",
                            style: TextStyle(fontSize: 50.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _buildScreen() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: AppConstants.screenPadding.left,
            right: AppConstants.screenPadding.right,
          ),
          child: SlidingAnimated(
            initialOffset: 5,
            intervalStart: 0.4,
            intervalEnd: 0.5,
            child: sn.isSendingCode
                ? TextWaitingWidget(isArabic
                    ? "يتم إرسال كود التحقق"
                    : "Sending a confirmation code")
                : CustomMansourButton(
                    titleText: isArabic ? "تسجيل الدخول" : "login",
                    textColor: AppColors.lightFontColor,
                    onPressed: () {
                      sn.loginType = 0;
                      sn.loginWithServer();
                    },
                  ),
          ),
        ),
        if (!sn.isSendingCode)
          CustomMansourButton(
            width: 0.9.sw,
            title: Text(
              isArabic ? "زائر" : "Guest",
              style: TextStyle(
                color: AppColors.primaryColorLight,
                fontWeight: FontWeight.bold,
                fontSize: 40.sp,
              ),
            ),
            onPressed: () {
              BlocProvider.of<GlogalCubit>(AppConfig().appContext,
                      listen: false)
                  .updateIsAuth();
              Nav.to(AppMainScreen.routeName);
            },
            backgroundColor: Colors.white,
          ),
        Gaps.vGap32,
        /*Center(
          child: SlidingAnimated(
            initialOffset: 5,
            intervalStart: 0.2,
            intervalEnd: 0.3,
            child: Text(
              Translation.of(context).or,
              style: TextStyle(
                color: Colors.black,
                fontSize: 40.sp,
              ),
            ),
          ),
        ),
        Gaps.vGap32,
        Padding(
          padding: EdgeInsets.only(
            left: AppConstants.screenPadding.left,
            right: AppConstants.screenPadding.right,
            bottom: 40.h,
          ),
          child: SlidingAnimated(
            initialOffset: 5,
            intervalStart: 0.3,
            intervalEnd: 0.4,
            child: sn.isGettingGoogleToken
                ? WaitingWidget()
                : CustomMansourButton(
                    titleText: Translation.current.Login_With_Google,
                    backgroundColor: Colors.white,
                    borderColor: AppColors.primaryColorLight,
                    textColor: AppColors.primaryColorLight,
                    onPressed: () {
                      sn.loginType = 1;
                      sn.loginWithGoogle();
                    },
                  ),
          ),
        ),*/
      ],
    );
  }

  _buildpassword() {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
                color: AppColors.mansourLightGreyColor_5,
                style: BorderStyle.solid)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(
                  left: AppConstants.screenPadding.left / 2,
                ),
                child: SizedBox(
                  height: 80.h,
                  width: 80.h,
                  child: SvgPicture.asset(
                    AppConstants.SVG_Lock,
                    color: AppColors.primaryColorLight,
                  ),
                ),
              ),
            ),
            Gaps.hGap64,
            Expanded(
              flex: 6,
              child: _buildPasswordField(),
            ),
            IconButton(
              onPressed: () {
                sn.isPassword();
              },
              icon: sn.obscureText
                  ? const Icon(
                      Icons.visibility_off,
                      color: Colors.grey,
                    )
                  : const Icon(
                      Icons.visibility,
                      color: Colors.grey,
                    ),
            ),
          ],
        ));
  }

  _buildPasswordField() {
    return CustomTextField(
      // key: sn.PasswordKey,
      autoFillHints: AutofillHints.password,
      hasAutoFill: true,
      primaryFieldColor: AppColors.regularFontColor,
      textKey: sn.PasswordKey,
      controller: sn.passwordController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.visiblePassword,
      focusNode: sn.myFocusNodePassord,
      hintText: isArabic ? "كلمة المرور" : "Password",
      obscureText: sn.obscureText,
      horizontalMargin: 110.w,
      errorMaxLines: 5,
      prefixIconConstraints: BoxConstraints(
        minWidth: 0,
        minHeight: 0,
        maxHeight: 80.h,
        maxWidth: 100.h,
      ),
      validator: (value) {
        sn.validatePassword(value);
      },
      onFieldSubmitted: (term) {
        sn.myFocusNodePassord.unfocus();
      },
      onChanged: (value) {
        sn.PasswordKey.currentState!.validate();
      },
    );
  }

  _buildPhoneField() {
    return Container(
      height: 150.h,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
              color: AppColors.mansourLightGreyColor_5,
              style: BorderStyle.solid)),
      child: Transform.translate(
        offset: Offset(0, 10),
        child: IntlPhoneField(
          key: const Key('telephoneNumberNational'),
          focusNode: sn.myFocusNodePhone,
          disableLengthCheck: false,
          textInputAction: TextInputAction.next,
          flagsButtonMargin: EdgeInsets.zero,
          dropdownTextStyle: TextStyle(),
          onCountryChanged: (value) {
            sn.countryCode = "+${value.dialCode}";
            sn.country = value;
            sn.notifyListeners();
          },
          // countries: ["SY"],
          controller: sn.phoneController,
          initialValue: '0',
          autovalidateMode: AutovalidateMode.disabled,
          inputFormatters: [
            new FilteringTextInputFormatter.allow((RegExp("[0-9]"))),
          ],
          searchText: isArabic ? "البحث عن بلد" : "Search country",
          textAlign: isArabic ? TextAlign.right : TextAlign.left,
          decoration: InputDecoration(
            hintStyle: TextStyle(fontSize: 14),
            hintMaxLines: 1,
            hintTextDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            enabled: true,
            alignLabelWithHint: true,
            hintText: (isArabic ? "مثال" : "Example") + ' : ' + '5xxxxxxxx',
            border: InputBorder.none,
          ),
          initialCountryCode: 'SA',
          validator: (phone) {
            sn.validatePhoneNumber(phone?.number, sn.country.maxLength);
          },
          onSubmitted: (term) {
            fieldFocusChange(
              context,
              sn.myFocusNodePhone,
              sn.myFocusNodePassord,
            );
          },
          onChanged: (value) {
            // sn.phoneKey.currentState!.validate();
          },
        ),
      ),
    );
  }
}
