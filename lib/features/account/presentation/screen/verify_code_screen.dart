import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/animations/animated_route.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/errv_snack_bar_options.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/account/data/model/request/register_request.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';
import 'package:starter_application/features/account/presentation/state_m/provider/verify_code_notifier.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:starter_application/main.dart';
import 'dart:ui' as ui;
class VerifyCodeScreen extends StatefulWidget {
  static const routeName = "/RegisterScreen3";
  RegisterRequest registerRequest;
  bool signUpProcess;

  VerifyCodeScreen(
      {Key? key, required this.registerRequest, required this.signUpProcess})
      : super(key: key);

  @override
  _VerifyCodeScreenState createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  VerifyCodeNotifier sn = VerifyCodeNotifier();

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  void initState() {
    sn.signUpCode = widget.signUpProcess;
    sn.registerRequest = widget.registerRequest;
    super.initState();
  }

  int con = 30;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VerifyCodeNotifier>.value(
      value: sn,
      builder: (context, _) {
        context.watch<VerifyCodeNotifier>();
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
                  buildAppbarTitle(isArabic ? "تأكيد":"Verify"),
                  Gaps.vGap32,
                  _builDescription(sn.registerRequest.phoneNumber == null
                      ? '${sn.registerRequest.emailAddress}'
                      : "${sn.registerRequest.countryCode}${sn.registerRequest.phoneNumber}"),
                  Gaps.vGap128,
                  Gaps.vGap64,
                  Expanded(
                    child: ListView(
                      children: [
                        SlidingAnimated(
                            initialOffset: 5,
                            intervalStart: 0.1,
                            intervalEnd: 0.2,
                            child: _buildVerificationCodeField()),
                        Gaps.vGap128,
                        BlocConsumer<AccountCubit, AccountState>(
                            listener: (context, state) {
                              state.mapOrNull(
                                accountError: (s) => ErrorViewer.showError(
                                  errorViewerOptions: const ErrVSnackBarOptions(),
                                  context: context,
                                  error: s.error,
                                  callback: () => sn.onVerifyTap(),
                                ),
                                passwordCodeVerified: (s) => sn.onVerifyDone(),
                              );
                            },
                            bloc: sn.accountCubit,
                            builder: (context, state) {
                              return state.maybeMap(
                                orElse: () => const SizedBox.shrink(),
                                hasAvatarChecked: (s) =>
                                    ScreenNotImplementedError(),
                                getAvatar: (s) => _buildVerifyButton(),
                                forgetpasswordLoaded: (s) => _buildVerifyButton(),
                                accountError: (s) => _buildVerifyButton(),
                                accountInit: (s) => _buildVerifyButton(),
                                accountLoading: (s) => WaitingWidget(),
                                loginLoaded: (s) => _buildVerifyButton(),
                                registerLoaded: (s) => _buildVerifyButton(),
                                verifyLoaded: (s) => _buildVerifyButton(),
                                passwordCodeVerified: (s) => _buildVerifyButton(),
                                phoneNumberConfirmed: (s) => _buildVerifyButton(),
                              );
                            }),
                        Gaps.vGap32,
                        SlidingAnimated(
                            initialOffset: 5,
                            intervalStart: 0.3,
                            intervalEnd: 0.4,
                            child: _buildCodeNotRecivedColumn()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _buildVerifyButton() {
    return sn.isVerifyPhone
        ? WaitingWidget()
        : CustomMansourButton(
            titleText: isArabic ? "تأكيد":"Verify",
            textColor: AppColors.lightFontColor,
            onPressed: () {
              print('aaa');
              sn.onVerifyTap();
            },
          );
  }

  Widget _builDescription(String fotter) {
    return Text(
      "${isArabic ?"أدخل رمز التحقق أدناه ، الرمز المرسل إلى" : "enter verification code below, the code sent to"} $fotter",
      style: TextStyle(
        color: Colors.black,
        fontSize: 45.sp,
      ),
    );
  }

  Widget _buildVerificationCodeField() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: VerificationCode(
          textStyle: const TextStyle(
            fontSize: 20.0,
            color: AppColors.primaryColorLight,
          ),
          underlineColor: AppColors.primaryColorLight,
          keyboardType: TextInputType.number,
          length: 6,
          itemSize: (1.sw - 2 * (AppConstants.screenPadding.left)) / 7,
          digitsOnly: true,
          onCompleted: sn.onCodeComplete,
          onEditing: sn.onEditing,
        ),
      ),
    );
  }

  Widget _buildCodeNotRecivedColumn() {
    return Column(
      children: [
        Text(
          isArabic ?"الم تتلقى الرمز":"Did’nt recieve code",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 40.sp,
          ),
        ),
        Gaps.vGap12,
        sn.isSendingCode
            ? WaitingWidget()
            : CustomMansourButton(
                width: 0.6.sw,
                backgroundColor: AppColors.mansourWhiteBackgrounColor,
                titleText: "${isArabic ? "اعادة ارسال":"Resend Code"} ",
                titleStyle: TextStyle(
                  color: AppColors.primaryColorLight,
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                ),
                borderRadius: Radius.circular(20.r),
                onPressed: () {
                  sn.reSendCode();
                },
              ),
      ],
    );
  }
}
