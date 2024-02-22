import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/common/validators.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/errv_snack_bar_options.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_snackbar_based_error_type.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/account/data/model/request/register_request.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';
import 'package:starter_application/features/account/presentation/state_m/provider/set_username_notifier.dart';
import 'package:starter_application/generated/l10n.dart';
import 'dart:ui'as ui;

import '../../../../main.dart';
class SetUserNameScreen extends StatefulWidget {
  static const routeName = "/RegisterScreen4";
  RegisterRequest registerRequest;

  SetUserNameScreen({Key? key, required this.registerRequest})
      : super(key: key);

  @override
  _SetUserNameScreenState createState() => _SetUserNameScreenState();
}

class _SetUserNameScreenState extends State<SetUserNameScreen> {
  final sn = SetUserNameNotifier();

  @override
  void initState() {
    sn.registerRequest = widget.registerRequest;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SetUserNameNotifier>.value(
      value: sn,
      builder: (context, _) {
        context.watch<SetUserNameNotifier>();
        sn.context = context;
        return Directionality(
          textDirection: isArabic ? ui.TextDirection.rtl :ui.TextDirection.ltr ,
          child: Scaffold(
            appBar: buildAppbar(),
            body: Padding(
              padding: AppConstants.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildAppbarTitle(
                    isArabic ? "حدد اسم (المستخدم)" : "Set Mohra ID (user name)",
                    padding: EdgeInsets.zero,
                  ),
                  Gaps.vGap32,
                  _builDescription(),
                  Gaps.vGap128,
                  _buildUserNameField(),
                  const Spacer(),
                  BlocConsumer<AccountCubit, AccountState>(
                      listener: (context, state) {
                        state.mapOrNull(
                          accountError: (s) => ErrorViewer.showError(
                            errorViewerOptions: const ErrVSnackBarOptions(),
                            context: context,
                            error: s.error,
                            callback: sn.register,
                          ),
                          registerLoaded: (s) {
                            sn.onRegisterDone();
                          },
                          checkUsernameExistLoading: (s)=>TextWaitingWidget(isArabic ? "جاري التحقق من مُعرف مُهرة(اسم المستخدم)" : "Check If Mohra ID (username) is unique and valid"),
                          checkUsernameExistDone: (s)=> sn.onCheckingDone(),
                          checkUsernameExistError: (s){
                            showSnakBarBasedErrorType(context, s.error, (){}, retryWhenNotAuthorized: false);
                          },
                          phoneNumberConfirmed: (s)=> sn.onPhoneNumberConfirmed(),
                          loginLoaded: (s)=> sn.onLoginsuccess(s.loginEntity),
                        );
                      },
                      bloc: sn.accountCubit,
                      builder: (context, state) {
                        return state.maybeMap(
                          orElse: () => CustomMansourButton(
                            titleText: isArabic?"التالي":"Next",
                            textColor: AppColors.lightFontColor,
                            onPressed: () {
                              sn.onNextTapped();
                            },
                          ),
                          hasAvatarChecked: (s) => ScreenNotImplementedError(),
                          getAvatar: (s) => ScreenNotImplementedError(),
                          accountError: (s) => CustomMansourButton(
                            titleText: isArabic?"التالي":"Next",
                            textColor: AppColors.lightFontColor,
                            onPressed: () {
                              sn.onNextTapped();
                            },
                          ),
                          accountInit: (s) => CustomMansourButton(
                            titleText: isArabic?"التالي":"Next",
                            textColor: AppColors.lightFontColor,
                            onPressed: () {
                              sn.onNextTapped();
                            },
                          ),
                          accountLoading: (s) => WaitingWidget(),
                          loginLoaded: (s) => CustomMansourButton(
                            titleText: isArabic?"التالي":"Next",
                            textColor: AppColors.lightFontColor,
                            onPressed: () {
                              sn.onNextTapped();
                            },
                          ),
                          registerLoaded: (s) => CustomMansourButton(
                            titleText: isArabic?"التالي":"Next",
                            textColor: AppColors.lightFontColor,
                            onPressed: () {
                              sn.onNextTapped();
                            },
                          ),
                          verifyLoaded: (s) => CustomMansourButton(
                            titleText: isArabic?"التالي":"Next",
                            textColor: AppColors.lightFontColor,
                            onPressed: () {
                              sn.onNextTapped();
                            },
                          ),

                        );
                      }),
                  Gaps.vGap32,
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
    (  isArabic ? " حاول تخليه مميز" : "Mohra ID (username), try to make it unique") +
          ' ' +
          String.fromCharCode(0x2728) +
          ' ' +
        (isArabic ? "أنا أفداك علشان تضيف الناس بسهولة" : "so that people add you easily"),
      style: TextStyle(
        color: Colors.black,
        fontSize: 45.sp,
      ),
    );
  }

  _buildUserNameField() {
    return CustomTextField(
      primaryFieldColor: AppColors.regularFontColor,
      textKey: sn.userNameKey,
      controller: sn.userNameController,

      inputFormatter:  [
        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
      ],
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      focusNode: sn.userNameFocusNode,
      hintText: isArabic ? "ادخل  مُعرف مُهرة (اسم المستخدم)" : "Enter your Mohra ID (User Name)",
      contentPadding: EdgeInsets.zero,
      horizontalMargin: 40.w,
      validator: (value) {
        if (Validators.isValidName(value!) )
          return null;
        else
          return isArabic ?"لا يمكن لهذا الحقل أن يكون فارغا, ويجب ان يكون باللغة الانكليزية" : "This field mustn't be empty, must english only";
      },
      onFieldSubmitted: (term) {
        sn.userNameFocusNode.unfocus();
      },
      onChanged: (value) {
        sn.userNameKey.currentState!.validate();
      },
    );
  }
}
