import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/common/validators.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/animations/animated_route.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/errv_snack_bar_options.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_snackbar_based_error_type.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';
import 'package:starter_application/features/account/presentation/state_m/provider/forgetPassword_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:starter_application/main.dart';
import 'dart:ui' as ui;
class ForgetPasswordScreen extends StatefulWidget {
  static const routeName = "/ForgetPasswordScreen";

  ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  ForgetPasswordScreenNotifier sn = ForgetPasswordScreenNotifier();

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgetPasswordScreenNotifier>.value(
      value: sn,
      builder: (context, _) {
        context.watch<ForgetPasswordScreenNotifier>();
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
                  buildAppbarTitle(isArabic ? "هل نسيت كلمة المرور ؟":"Forget Password?"),
                  // _builDescription(),
                  Gaps.vGap128,
                  Center(
                    child: SizedBox(
                      width: 0.8.sw,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Radio(
                                activeColor: AppColors.mansourDarkOrange2,
                                value: sn.byEmail,
                                groupValue: sn.selected,
                                onChanged: (value) {
                                  sn.changeBy();
                                  setState(() {
                                    sn.selected = sn.byEmail;
                                    sn.keyboard = TextInputType.emailAddress;
                                  });
                                },
                              ),
                              Text(isArabic ? "البريد الإلكتروني":"Email"),
                            ],
                          ),
                          Gaps.hGap16,
                          Row(
                            children: [
                              Radio(
                                activeColor: AppColors.mansourDarkOrange2,
                                value: sn.byPhone,
                                groupValue: sn.selected,
                                onChanged: (value) {
                                  sn.changeBy();
                                  setState(() {
                                    sn.selected = sn.byPhone;
                                    sn.keyboard = TextInputType.number;
                                  });
                                },
                              ),
                              Text(
                                isArabic ? "رقم الهاتف":"Phone Number",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Gaps.vGap256,
                          Padding(
                            padding: EdgeInsets.only(
                              right: AppConstants.screenPadding.right,
                              left: AppConstants.screenPadding.right,
                            ),
                            child: SlidingAnimated(
                              initialOffset: 5,
                              intervalStart: 0.1,
                              intervalEnd: 0.2,
                              child: sn.selected == sn.byPhone
                                  ? _buildPhoneField()
                                  : _buildEmailFeild(),
                            ),
                          ),
                          Gaps.vGap256,
                          Gaps.vGap256,
                          Padding(
                            padding: EdgeInsets.only(
                              left: AppConstants.screenPadding.left,
                              right: AppConstants.screenPadding.right,
                            ),
                            child: BlocConsumer<AccountCubit, AccountState>(
                                listener: (context, state) {
                                  state.mapOrNull(
                                      accountError: (s) => ErrorViewer.showError(
                                          errorViewerOptions:
                                              const ErrVSnackBarOptions(),
                                          context: context,
                                          error: s.error,
                                          callback: () => sn.onNextTap()),
                                      forgetpasswordLoaded: (s) {
                                        sn.onCodeVerifyDone();
                                      },
                                      checkPhoneNumberExistDone: (s){
                                          showSnackbar(isArabic ? "رقم الهاتف غير صحيح" : "Phone Number not belong to any user", isError: true);

                                      },
                                    checkPhoneNumberExistError: (s){
                                      sn.onPhoneNumberCheckingDone();

                                    }
                                  );

                                },
                                bloc: sn.accountCubit,
                                builder: (context, state) {
                                  return state.maybeMap(
                                    accountError: (s) => SlidingAnimated(
                                      initialOffset: 5,
                                      intervalStart: 0.4,
                                      intervalEnd: 0.5,
                                      child: CustomMansourButton(
                                        titleText:
                                        isArabic ?"ارسال الكود":"Send code",
                                        textColor: AppColors.lightFontColor,
                                        onPressed: () {
                                          sn.onNextTap();
                                        },
                                      ),
                                    ),
                                    accountInit: (s) => SlidingAnimated(
                                      initialOffset: 5,
                                      intervalStart: 0.4,
                                      intervalEnd: 0.5,
                                      child: CustomMansourButton(
                                        titleText:
                                        isArabic ?"ارسال الكود":"Send code",
                                        textColor: AppColors.lightFontColor,
                                        onPressed: () {
                                          sn.onNextTap();
                                        },
                                      ),
                                    ),
                                    accountLoading: (s) => WaitingWidget(),
                                    hasAvatarChecked: (s) =>
                                        ScreenNotImplementedError(),
                                    getAvatar: (s) => ScreenNotImplementedError(),
                                    loginLoaded: (s) => SlidingAnimated(
                                      initialOffset: 5,
                                      intervalStart: 0.4,
                                      intervalEnd: 0.5,
                                      child: CustomMansourButton(
                                        titleText:
                                        isArabic ?"ارسال الكود":"Send code",
                                        textColor: AppColors.lightFontColor,
                                        onPressed: () {
                                          sn.onNextTap();
                                        },
                                      ),
                                    ),
                                    registerLoaded: (s) => SlidingAnimated(
                                      initialOffset: 5,
                                      intervalStart: 0.4,
                                      intervalEnd: 0.5,
                                      child: CustomMansourButton(
                                        titleText:
                                        isArabic ?"ارسال الكود":"Send code",
                                        textColor: AppColors.lightFontColor,
                                        onPressed: () {
                                          sn.onNextTap();
                                        },
                                      ),
                                    ),
                                    verifyLoaded: (s) => SlidingAnimated(
                                      initialOffset: 5,
                                      intervalStart: 0.4,
                                      intervalEnd: 0.5,
                                      child: CustomMansourButton(
                                        titleText:
                                        isArabic ?"ارسال الكود":"Send code",
                                        textColor: AppColors.lightFontColor,
                                        onPressed: () {
                                          sn.onNextTap();
                                        },
                                      ),
                                    ),
                                    forgetpasswordLoaded: (s) => SlidingAnimated(
                                      initialOffset: 5,
                                      intervalStart: 0.4,
                                      intervalEnd: 0.5,
                                      child: CustomMansourButton(
                                        titleText:
                                        isArabic ?"ارسال الكود":"Send code",
                                        textColor: AppColors.lightFontColor,
                                        onPressed: () {
                                          sn.onNextTap();
                                        },
                                      ),
                                    ),
                                    passwordCodeVerified: (s) => Container(),
                                    checkPhoneNumberExistLoading: (s) => TextWaitingWidget(isArabic ? "جاري التحقق من رقم الهاتف":"Check If Phone Number Valid"),
                                    orElse: () => SlidingAnimated(
                                      initialOffset: 5,
                                      intervalStart: 0.4,
                                      intervalEnd: 0.5,
                                      child: CustomMansourButton(
                                        titleText:
                                        isArabic ?"ارسال الكود":"Send code",
                                        textColor: AppColors.lightFontColor,
                                        onPressed: () {
                                          sn.onNextTap();
                                        },
                                      ),
                                    ),
                                  );
                                }),
                          ),
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

  Widget _builDescription() {
    return Padding(
      padding: EdgeInsets.only(left: 40.w, top: 20.h, right: 50.w),
      child: Text(
        Translation.of(context).Forgetpasswordfooter,
        style: TextStyle(
          color: Colors.black,
          fontSize: 45.sp,
        ),
      ),
    );
  }

  _buildPhoneField() {
    print('sddd');
    sn.keyboard = TextInputType.phone;
    return Container(
      height: 130.h,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
              color: AppColors.mansourLightGreyColor_5,
              style: BorderStyle.solid)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: sn.showCountryCode2()),
          Expanded(
            child: Center(
                child: Text(
              sn.countryCode,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter-Regular',
                  color: Colors.grey),
            )),
          ),
          Expanded(
            flex: 5,
            child: CustomTextField(
              primaryFieldColor: AppColors.regularFontColor,
              textKey: sn.phoneKey,
              controller: sn.phoneController,
              textInputAction: TextInputAction.next,
              keyboardType: sn.keyboard,
              focusNode: sn.myFocusNodePhone,
              hintText: isArabic ? "رقم الهاتف المحمول" : "Mobile Number",
              prefixIconConstraints: BoxConstraints(
                minWidth: 0,
                minHeight: 0,
                maxHeight: 80.h,
                maxWidth: 100.h,
              ),
              validator: (phone) {
                if ((phone == null || (phone.trim().isEmpty)) ||
                    phone.length < 9)
                  return isArabic ?"لا يمكن لهذا الحقل أن يكون فارغا" : "This field mustn't be empty";
                if (!Validators.isValidPhoneNumber(phone)) {
                  return isArabic ? "رقم الهاتف المحمول غير صالح":"Phone not valid";
                } else
                  return null;
              },
              onFieldSubmitted: (term) {
                sn.myFocusNodePhone.unfocus();
              },
              onChanged: (value) {
                sn.phoneKey.currentState!.validate();
              },
            ),
          )
        ],
      ),
    );
  }

  _buildEmailFeild() {
    sn.keyboard = TextInputType.emailAddress;
    return Container(
      height: 130.h,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
              color: AppColors.mansourLightGreyColor_5,
              style: BorderStyle.solid)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: CustomTextField(
              primaryFieldColor: AppColors.regularFontColor,
              textKey: sn.emailKey,
              controller: sn.emailController,
              textInputAction: TextInputAction.done,
              keyboardType: sn.keyboard,
              focusNode: sn.myFocusNodeemail,
              hintText:  isArabic ? "البريد الإلكتروني" : "Email",
              prefixIconConstraints: BoxConstraints(
                minWidth: 0,
                minHeight: 0,
                maxHeight: 80.h,
                maxWidth: 100.h,
              ),
              validator: (phone) {},
              onFieldSubmitted: (term) {
                sn.myFocusNodeemail.unfocus();
              },
              onChanged: (value) {
                sn.emailKey.currentState!.validate();
              },
            ),
          )
        ],
      ),
    );
  }
}
