import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/common/validators.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/animations/animated_route.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/errv_snack_bar_options.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/account/data/model/request/register_request.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';
import 'package:starter_application/features/account/presentation/state_m/provider/confirmPassword_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../main.dart';
import 'dart:ui'as ui;
class ConfirmPasswordScreen extends StatefulWidget {
  static const routeName = "/ConfirmPasswordScreen";
  RegisterRequest registerRequest;

  ConfirmPasswordScreen({Key? key, required this.registerRequest})
      : super(key: key);

  @override
  _ConfirmPasswordScreenState createState() => _ConfirmPasswordScreenState();
}

class _ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
  ConfirmPasswordScreenNotifier sn = ConfirmPasswordScreenNotifier();

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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ConfirmPasswordScreenNotifier>.value(
      value: sn,
      builder: (context, _) {
        context.watch<ConfirmPasswordScreenNotifier>();
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
                  buildAppbarTitle(isArabic ?"تأكيد كلمة المرور" : "Confirm Password"),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(
                        left: AppConstants.screenPadding.left,
                        right: AppConstants.screenPadding.right,
                        bottom: 40.h,
                      ),
                      child: Column(
                        children: [
                          Gaps.vGap32,
                          // _builDescription(),
                          Gaps.vGap128,
                          SlidingAnimated(
                              initialOffset: 5,
                              intervalStart: 0,
                              intervalEnd: 0.1,
                              child: _buildpassword()),
                          Gaps.vGap32,
                          SlidingAnimated(
                              initialOffset: 5,
                              intervalStart: 0,
                              intervalEnd: 0.1,
                              child: _buildconfirmPassword()),
                          Gaps.vGap128,
                          BlocConsumer<AccountCubit, AccountState>(
                              listener: (context, state) {
                                state.mapOrNull(
                                    accountError: (s) => ErrorViewer.showError(
                                        errorViewerOptions:
                                            const ErrVSnackBarOptions(),
                                        context: context,
                                        error: s.error,
                                        callback: () {}),
                                    forgetpasswordLoaded: (s) =>
                                        sn.onPasswordRestore());
                              },
                              bloc: sn.accountCubit,
                              builder: (context, state) {
                                return state.maybeMap(
                                  hasAvatarChecked: (s) =>
                                      ScreenNotImplementedError(),
                                  getAvatar: (s) => ScreenNotImplementedError(),
                                  forgetpasswordLoaded: (s) => Column(
                                    children: [
                                      Gaps.vGap256,
                                      SlidingAnimated(
                                        initialOffset: 5,
                                        intervalStart: 0.4,
                                        intervalEnd: 0.5,
                                        child: CustomMansourButton(
                                          titleText: isArabic ? "حفظ" : "Save",
                                          textColor: AppColors.lightFontColor,
                                          onPressed: () {
                                            sn.onNextTap();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  accountError: (s) => Column(
                                    children: [
                                      Gaps.vGap256,
                                      SlidingAnimated(
                                        initialOffset: 5,
                                        intervalStart: 0.4,
                                        intervalEnd: 0.5,
                                        child: CustomMansourButton(
                                          titleText: isArabic ? "حفظ" : "Save",
                                          textColor: AppColors.lightFontColor,
                                          onPressed: () {
                                            sn.onNextTap();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  accountInit: (s) => Column(
                                    children: [
                                      Gaps.vGap256,
                                      SlidingAnimated(
                                        initialOffset: 5,
                                        intervalStart: 0.4,
                                        intervalEnd: 0.5,
                                        child: CustomMansourButton(
                                          titleText: isArabic ? "حفظ" : "Save",
                                          textColor: AppColors.lightFontColor,
                                          onPressed: () {
                                            sn.onNextTap();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  accountLoading: (s) => WaitingWidget(),
                                  loginLoaded: (s) => Container(),
                                  registerLoaded: (s) => Container(),
                                  passwordCodeVerified: (s) => Container(),
                                  verifyLoaded: (s) => Container(),
                                  orElse: () => const SizedBox.shrink(),
                                );
                              }),
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
    return Text(
      Translation.of(context).confirmPasswordfooter,
      style: TextStyle(
        color: Colors.black,
        fontSize: 45.sp,
      ),
    );
  }

  Widget _buildpassword() {
    return Container(
        height: 130.h,
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
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(
                      bottom: AppConstants.screenPadding.left / 1.4,
                    ),
                    child: _buildPasswordField())),
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
      hintText: isArabic ? "كلمة المرور":"Password",
      obscureText: sn.obscureTextpssword,
      horizontalMargin: 65.w,
      prefixIconConstraints: BoxConstraints(
        minWidth: 0,
        minHeight: 0,
        maxHeight: 80.h,
        maxWidth: 100.h,
      ),
      validator: (value) {
        if (value == null || (value.trim().isEmpty))
          return isArabic ?"لا يمكن لهذا الحقل أن يكون فارغا" : "This field mustn't be empty";
        return Validators.isValidPassword(value);
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
        height: 130.h,
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
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(
                      bottom: AppConstants.screenPadding.left / 1.4,
                    ),
                    child: _buildconfirmPasswordField())),
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
      hintText: isArabic ? "تأكيد كلمة المرور":"Confirm Password",
      obscureText: sn.obscureTextconfirmPssword,
      horizontalMargin: 65.w,
      prefixIconConstraints: BoxConstraints(
        minWidth: 0,
        minHeight: 0,
        maxHeight: 80.h,
        maxWidth: 100.h,
      ),
      validator: (value) {
        if (value == null || (value.trim().isEmpty))
          return isArabic ?"لا يمكن لهذا الحقل أن يكون فارغا" : "This field mustn't be empty";
        if (!Validators.isValidConfirmPassword(
            sn.PasswordController.text, value))
          return isArabic ? "كلمة السر وتأكيد كلمة السر غير متطابقتين" : "Password and confirm password doesn't match";
        else if (!value.contains(RegExp(r'[0-9]')))
          return isArabic ? "كلمة السر وتأكيد كلمة السر غير متطابقتين" : "Password and confirm password doesn't match";
        else
          return null;
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
