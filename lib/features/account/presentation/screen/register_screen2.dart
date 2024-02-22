import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/common/validators.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/animations/animated_route.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_snackbar_based_error_type.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/account/data/model/request/register_request.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';
import 'package:starter_application/features/account/presentation/state_m/provider/register_screen_2_notifier.dart';
import 'package:starter_application/generated/l10n.dart';
import 'dart:ui' as ui;
import 'package:intl_phone_field/countries.dart';
import '../../../../main.dart';
class RegisterScreen2 extends StatefulWidget {
  static const routeName = "/RegisterScreen2";
  RegisterRequest registerRequest;

  RegisterScreen2({Key? key, required this.registerRequest}) : super(key: key);

  @override
  _RegisterScreen2State createState() => _RegisterScreen2State();
}

class _RegisterScreen2State extends State<RegisterScreen2> {
  RegisterScreen2Notifier sn = RegisterScreen2Notifier();

  @override
  void initState() {
    sn.registerRequest = widget.registerRequest;
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  getCakeOrBasboosh() {
    if (sn.registerRequest.cake == 1) {
      return ' ' +
          (isArabic ? "الكيكة" : "Cake") +
          ' ' +
          String.fromCharCode(0x1F36F);
    } else {
      return ' ' +
          (isArabic ? "البسبوسة" : "Basboosh") +
          ' ' +
          String.fromCharCode(0x1F95E);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterScreen2Notifier>.value(
      value: sn,
      builder: (context, _) {
        context.watch<RegisterScreen2Notifier>();
        sn.context = context;
        return Directionality(
          textDirection: isArabic ? ui.TextDirection.rtl :ui.TextDirection.ltr ,
          child: Scaffold(
            appBar: buildAppbar(),
            body: Form(
              key: sn.formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildAppbarTitle( isArabic ? "تسجيل حساب":"Register"),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(
                        left: AppConstants.screenPadding.left,
                        right: AppConstants.screenPadding.right,
                        bottom: 40.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _builDescription(),
                          Gaps.vGap128,
                          SlidingAnimated(
                            initialOffset: 5,
                            intervalStart: 0,
                            intervalEnd: 0.1,
                            child: _buildEmail(),
                          ),
                          Visibility(
                            visible: sn.emailError != '',
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                start: AppConstants.screenPadding.right,
                                bottom: AppConstants.screenPadding.right * 2,
                              ),
                              child: SlidingAnimated(
                                initialOffset: 5,
                                intervalStart: 0.1,
                                intervalEnd: 0.2,
                                child: Text(
                                  sn.emailError,
                                  style: TextStyle(
                                      color: AppColors.redColor, fontSize: 40.sp),
                                ),
                              ),
                            ),
                          ),
                          Gaps.vGap50,
                          SlidingAnimated(
                            initialOffset: 5,
                            intervalStart: 0.1,
                            intervalEnd: 0.2,
                            child: _buildPhoneField(),
                          ),
                          Visibility(
                            visible: sn.phoneError != '',
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                start: AppConstants.screenPadding.right,
                                bottom: AppConstants.screenPadding.right * 2,
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
                          Gaps.vGap50,
                          SlidingAnimated(
                              initialOffset: 5,
                              intervalStart: 0,
                              intervalEnd: 0.1,
                              child: _buildpassword()),
                          Visibility(
                            visible: sn.passwordError != '',
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                start: AppConstants.screenPadding.right,
                                bottom: AppConstants.screenPadding.right * 2,
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
                          Gaps.vGap50,
                          SlidingAnimated(
                              initialOffset: 5,
                              intervalStart: 0,
                              intervalEnd: 0.1,
                              child: _buildconfirmPassword()),
                          Visibility(
                            visible: sn.passwordConfirmError != '',
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                start: AppConstants.screenPadding.right,
                                bottom: AppConstants.screenPadding.right * 2,
                              ),
                              child: SlidingAnimated(
                                initialOffset: 5,
                                intervalStart: 0.1,
                                intervalEnd: 0.2,
                                child: Text(
                                  sn.passwordConfirmError,
                                  style: TextStyle(
                                      color: AppColors.redColor, fontSize: 40.sp),
                                ),
                              ),
                            ),
                          ),
                          Gaps.vGap128,
                          _buildNextButtonConsumer()
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _buildNextButtonConsumer() {
    return BlocConsumer<AccountCubit, AccountState>(
        listener: (context, state) {
          if(state is CheckPhoneNumberExistDone){
            sn.onValidPhoneNumber();
          }
          if(state is CheckPhoneNumberExistError){
            showSnakBarBasedErrorType(context, state.error, (){}, retryWhenNotAuthorized: false);
          }
          if(state is CheckEmailExistDone){
            sn.onValidEmail();
          }
          if(state is CheckEmailExistError){
            showSnakBarBasedErrorType(context, state.error, (){}, retryWhenNotAuthorized: false);
          }
          if(state is CheckEmailExistLoading){
            sn.notifyListeners();
          }

        },
        bloc: sn.accountCubit,
        builder: (context, state) {
          return state.maybeMap(
              orElse: () => _buildNextButtonWidget(),
              accountError: (s) => _buildNextButtonWidget(),
              accountInit: (s) => _buildNextButtonWidget(),
              accountLoading: (s) => WaitingWidget(),
              loginLoaded: (s) => Container(),
              registerLoaded: (s) => Container(),
              verifyLoaded: (s) => Container(),
              checkPhoneNumberExistLoading: (s) => TextWaitingWidget( isArabic ? "جاري التحقق من رقم الهاتف" :"Check If Phone Number Valid"),
              checkEmailExistLoading:  (s) => TextWaitingWidget(isArabic ? "جاري التحقق من البريد الالكتروني" : "Check If Email is Valid"),
              checkEmailExistDone: (s) => _buildNextButtonWidget(),
              checkPhoneNumberExistDone: (s) => _buildNextButtonWidget(),
          );
        });
  }

  _buildNextButtonWidget(){
    return Column(
      children: [
        SlidingAnimated(
          initialOffset: 5,
          intervalStart: 0.4,
          intervalEnd: 0.5,
          child: sn.isSendingCode ? TextWaitingWidget(isArabic ? "يتم إرسال كود التحقق" : "Sending a confirmation code")  : CustomMansourButton(
            titleText: isArabic?"التالي":"Next",
            textColor: AppColors.lightFontColor,
            onPressed: () {
              sn.onNextTap();
            },
          ),
        ),
        /*Gaps.vGap128,
                                          Center(
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
                                          ),*/
        /* Gaps.vGap32,
                                          SlidingAnimated(
                                            initialOffset: 5,
                                            intervalStart: 0.3,
                                            intervalEnd: 0.4,
                                            child: CustomMansourButton(
                                              titleText: Translation.of(context)
                                                  .Register_With_Google,
                                              backgroundColor: Colors.white,
                                              borderColor:
                                                  AppColors.primaryColorLight,
                                              textColor:
                                                  AppColors.primaryColorLight,
                                              onPressed: () {
                                                sn.registerWithGoogle();
                                              },
                                            ),
                                          ),*/
      ],
    );
  }


  Widget _builDescription() {
    return Text(
      (isArabic ? "طيب يا " : "Welcome ") +
          sn.registerRequest.firstName! +
          getCakeOrBasboosh() +
          '\n' +
          (isArabic?" ممكن تعبي معلوماتك هنا " : " , Please Fill your Information here"),
      style: TextStyle(
        color: Colors.black,
        fontSize: 45.sp,
      ),
    );
  }

  _buildEmailField() {
    return CustomTextField(
      primaryFieldColor: AppColors.regularFontColor,
      textKey: sn.emailKey,
      controller: sn.emailController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      focusNode: sn.myFocusNodeEmail,
      hintText: isArabic ? "البريد الإلكتروني":"Email",
      horizontalMargin: 100.w,
      prefixIconConstraints: BoxConstraints(
        minWidth: 0,
        minHeight: 0,
        maxHeight: 80.h,
        maxWidth: 100.h,
      ),
      validator: (value) {
        sn.validateEmail(value);
      },
      onFieldSubmitted: (term) {
        fieldFocusChange(context, sn.myFocusNodeEmail, sn.myFocusNodePhone);
      },
      onChanged: (value) {
        sn.emailKey.currentState!.validate();
      },
    );
  }

  Widget _buildEmail() {
    return Container(
      height: 130.h,
      width: 0.92.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
            color: AppColors.mansourLightGreyColor_5, style: BorderStyle.solid),
      ),
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
                  AppConstants.SVG_EMAIL,
                  color: AppColors.primaryColorLight,
                ),
              ),
            ),
          ),
          Gaps.hGap64,
          Expanded(flex: 6, child: _buildEmailField()),
        ],
      ),
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
          disableLengthCheck: false,
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

          searchText: isArabic  ? "البحث عن بلد" : "Search country",
          textAlign: isArabic ? TextAlign.right : TextAlign.left,
          decoration: InputDecoration(
            hintStyle: TextStyle(fontSize: 14),
            hintMaxLines: 1,
            hintTextDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            enabled: true,
            alignLabelWithHint: true,
            hintText: (isArabic ? "مثال" :"Example") + ' : ' + '5xxxxxxxx',
            border: InputBorder.none,
          ),
          initialCountryCode: 'SA',
          validator: (phone) {
            sn.validatePhoneNumber(phone?.number,sn.country.maxLength);
          },
          onSubmitted: (term) {
            fieldFocusChange(
              context,
              sn.myFocusNodePhone,
              sn.myFocusNodePassword,
            );
          },
          onChanged: (value) {
              // sn.phoneKey.currentState!.validate();
          },
        ),
      ),
    );
  }

  Widget _buildpassword() {
    return Container(
        width: 0.92.sw,
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
            Expanded(flex: 6, child: _buildPasswordField()),
            IconButton(
              onPressed: () {
                sn.isPassword();
              },
              icon: sn.obscureTextpssword
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
      primaryFieldColor: AppColors.regularFontColor,
      textKey: sn.PasswordKey,
      controller: sn.PasswordController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.visiblePassword,
      focusNode: sn.myFocusNodePassword,
      hintText: isArabic ? "كلمة المرور" :"Password",
      obscureText: sn.obscureTextpssword,
      horizontalMargin: 110.w,
      errorMaxLines: 4,
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
        fieldFocusChange(
            context, sn.myFocusNodePassword, sn.myFocusNodeConfirmPassword);
      },
      onChanged: (value) {
        sn.PasswordKey.currentState!.validate();
      },
    );
  }

  Widget _buildconfirmPassword() {
    return Container(
        width: 0.92.sw,
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
            Expanded(flex: 6, child: _buildconfirmPasswordField()),
            IconButton(
              onPressed: () {
                sn.isConfirmPassword();
              },
              icon: sn.obscureTextconfirmPssword
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

  _buildconfirmPasswordField() {
    return CustomTextField(
      primaryFieldColor: AppColors.regularFontColor,
      textKey: sn.confirmPasswordKey,
      controller: sn.confirmPasswordController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.visiblePassword,
      focusNode: sn.myFocusNodeConfirmPassword,
      hintText: isArabic ? "تأكيد كلمة المرور" : "Confirm Password",
      obscureText: sn.obscureTextconfirmPssword,
      errorMaxLines: 4,
      horizontalMargin: 110.w,
      prefixIconConstraints: BoxConstraints(
        minWidth: 0,
        minHeight: 0,
        maxHeight: 80.h,
        maxWidth: 100.h,
      ),
      validator: (value) {
        sn.validateConfirmPassword(value);
      },
      onFieldSubmitted: (term) {
        sn.myFocusNodeConfirmPassword.unfocus();
      },
      onChanged: (value) {
        sn.confirmPasswordKey.currentState!.validate();
      },
    );
  }
}
