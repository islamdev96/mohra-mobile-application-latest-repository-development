import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/localization/flutter_localization.dart';
import 'package:starter_application/core/navigation/animations/animated_route.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/errv_snack_bar_options.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';
import 'package:starter_application/features/user/presentation/state_m/cubit/user_cubit.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/change_email_confirm_screen_notifier.dart';

class ChangeEmailConfirmScreenContent extends StatelessWidget {
  late ChangeEmailConfirmScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<ChangeEmailConfirmScreenNotifier>(context);
    sn.context = context;
    return Container(
      height: 1.sh,
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Gaps.vGap128,
          Image.asset(
            'assets/images/png/email_code.png',
            width: 50,
            height: 50,
          ),
          Gaps.vGap32,
          Text(
            Translation.current.enter_verify_code,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 70.sp,
            ),
          ),
          Gaps.vGap32,
          Text(
            sn.type == 0 ?  Translation.current.code_sent_email +' ${sn.newField}' : Translation.current.code_sent_mobile + ' ${sn.newField}',
            style: TextStyle(
              color: AppColors.text_gray,
              fontSize:50.sp,
            ),
            textAlign: TextAlign.center,
          ),
          Gaps.vGap32,
          _buildVerificationCodeField(),
          Gaps.vGap32,
          BlocConsumer<AccountCubit, AccountState>(
              listener: (context, state) {
                if(state is VerifyLoaded){
                  sn.onVerifyDone();
                }
                if(state is AccountError){
                  ErrorViewer.showError(context: context, error: state.error, callback: (){},errorViewerOptions: ErrVSnackBarOptions());
                }
              },
              bloc: sn.accountCubit,
              builder: (context, state) {
                return state.maybeMap(
                  orElse: () =>  buildButton(),
                  accountError: (s) => buildButton(),
                  accountInit: (s) => buildButton(),
                  accountLoading: (s) => WaitingWidget(),
                  verifyLoaded: (s) => buildButton(),

                );
              }),
          Gaps.vGap128,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                sn.type == 0 ?  Translation.current.dont_receive_mail +" " : Translation.current.dont_receive_phone +" ",
                style: TextStyle(
                  color: AppColors.text_gray,
                  fontSize:40.sp,
                ),
                textAlign: TextAlign.center,
              ),
              sn.isSendingCode ? WaitingWidget() : GestureDetector(
                onTap: (){
                  sn.reSendOTPCodeFromFirebase();
                },
                child: Text(
                  Translation.current.re_send_code ,
                  style: TextStyle(
                    color: AppColors.mansourDarkOrange3,
                    fontWeight: FontWeight.bold,
                    fontSize:40.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
        ],
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

  buildButton(){
    return sn.code.length == 6 ? sn.isVerifyPhone ? WaitingWidget():
    BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if(state is UpdateProfileDone){
            sn.onUpdateProfleDone(state.updateProfileEntity);
          }
          if(state is UserErrorState){
            ErrorViewer.showError(context: context, error: state.error, callback: (){},errorViewerOptions: ErrVSnackBarOptions());
          }
        },
        bloc: sn.userCubit,
        builder: (context, state) {
          return state.maybeMap(
            orElse: () => buildVerifyButton(),
            userErrorState: (s)=>buildVerifyButton(),
            userInitState:(s)=> buildVerifyButton(),
            updateProfile:(s)=> TextWaitingWidget(Translation.current.updating_your_profile),
            updateProfileDone: (s)=> buildVerifyButton(),
            userLoadingState:(s)=> WaitingWidget(),

          );
        })
        :
    CustomMansourButton(
      titleText: sn.type == 0
          ? Translation.current.verify_email
          : Translation.current.verify_phone,
      backgroundColor: AppColors.text_gray,
      onPressed: (){
        if(sn.type == 0){
          sn.onVerifyTapped();
        }
      },
    );
  }

  buildVerifyButton(){
    return CustomMansourButton(
      titleText: sn.type == 0
          ? Translation.current.verify_email
          : Translation.current.verify_phone,
      onPressed: (){
        sn.onVerifyTapped();
      },
    );
  }
}
