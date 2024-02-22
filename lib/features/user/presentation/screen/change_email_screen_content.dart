import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/errv_snack_bar_options.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_snackbar_based_error_type.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';
import 'package:starter_application/features/user/presentation/screen/change_email_confirm_screen.dart';
import 'package:starter_application/features/user/presentation/state_m/cubit/user_cubit.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/change_email_screen_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangeEmailScreenContent extends StatelessWidget {
  late ChangeEmailScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<ChangeEmailScreenNotifier>(context);
    sn.context = context;
    return Container(
      height: 1.sh,
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: buildScreen(),
    );
  }

  buildScreen() {
    if (sn.type == 0)
      return Column(
        children: [
          Gaps.vGap32,
          TextFormField(
            enabled: false,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: Translation.current.registered_email,
            ),
            initialValue: '${UserSessionDataModel.emailAddress}',
            style: const TextStyle(
              color: AppColors.text_gray,
            ),
          ),
          Gaps.vGap64,
          TextFormField(
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: Translation.current.new_email,
              border: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.mansourDarkOrange3,
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.mansourDarkOrange3,
                ),
              ),
            ),
            controller: sn.newEmail,
            keyboardType: TextInputType.emailAddress,
            onChanged: (v) {
              sn.notifyListeners();
            },
          ),
          Gaps.vGap64,
          BlocConsumer<UserCubit, UserState>(
              bloc: sn.userCubit,
              listener: (context, state) {
                if (state is EmailChanged) {
                  print('aaaaa');
                  sn.onChangeEmailDone();
                }
                if(state is UserErrorState){
                  ErrorViewer.showError(context: context, error: state.error, callback: (){},errorViewerOptions: ErrVSnackBarOptions(
                  ));
                }

              },
              builder: (context, state) {
                return state.map(
                  addressSelectedDone: (s) => ScreenNotImplementedError(),
                  setSelectAddress: (s) => ScreenNotImplementedError(),
                  deleteAccountDone: (s) => ScreenNotImplementedError(),
                  addAddressDone: (s) => ScreenNotImplementedError(),
                  userLoadingState: (s) => WaitingWidget(),
                  userErrorState: (s) => _buildSaveEmailButton(),
                  addressDeleted: (s) => ScreenNotImplementedError(),
                  changePasswordDone: (s) => ScreenNotImplementedError(),
                  updateProfile: (S) => ScreenNotImplementedError(),
                  updateProfileDone: (s) => ScreenNotImplementedError(),
                  uploadImage: (s) => ScreenNotImplementedError(),
                  uploadImageDone: (s) => ScreenNotImplementedError(),
                  getProfileDone: (s) => ScreenNotImplementedError(),
                  getCityDone: (s) => ScreenNotImplementedError(),
                  userInitState: (s) => _buildSaveEmailButton(),
                  updateAddress: (s) => ScreenNotImplementedError(),
                  updateAddressDone: (s) => ScreenNotImplementedError(),
                  getAddressesDone: (s) => ScreenNotImplementedError(),
                  avatarLoaded: (s) => ScreenNotImplementedError(),
                  emailChanged: (s) => _buildSaveEmailButton(),
                  getFriendMomentsDone: (s) => ScreenNotImplementedError(),
                );
              })
        ],
      );
    return Column(
      children: [
        Gaps.vGap32,
        TextFormField(
          enabled: false,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: Translation.current.registered_phone,
          ),
          initialValue: '${UserSessionDataModel.phoneNumber}',
          style: const TextStyle(
            color: AppColors.text_gray,
          ),
        ),
        Gaps.vGap64,
        _buildPhoneField(),
        Gaps.vGap64,
        _buildSavePhoneButton()
      ],
    );
  }

  _buildSaveEmailButton() {
    return sn.newEmail.text.isEmpty
        ? CustomMansourButton(
            titleText: Translation.current.continuee,
            backgroundColor: AppColors.text_gray,
          )
        : CustomMansourButton(
            titleText: Translation.current.continuee,
            onPressed: () {
              sn.countinueTapped();
            },
          );
  }

  _buildSavePhoneButton() {
    return sn.newEmail.text.isEmpty
        ? CustomMansourButton(
            titleText: Translation.current.continuee,
            backgroundColor: AppColors.text_gray,
          )
        : buildSaveButton();
  }

  buildSaveButton(){
    return BlocConsumer<AccountCubit , AccountState>(
      bloc: sn.accountCubit,
      listener: (context , state){
          if(state is CheckPhoneNumberExistDone){
            sn.checkDone();
          }
          if(state is AccountError){
            showSnakBarBasedErrorType(context, state.error, (){}, retryWhenNotAuthorized: false);
          }
          if(state is CheckPhoneNumberExistError){
            showSnakBarBasedErrorType(context, state.error, (){}, retryWhenNotAuthorized: false);
          }
      },
      builder: (context, state){
        return state.maybeMap(
          orElse: (){
            return _buttonWidget();
          },
          checkPhoneNumberExistLoading: (s)=>TextWaitingWidget(Translation.current.checkPhoneNumber),
          checkPhoneNumberExistDone: (s){
            return _buttonWidget();
          }
        );
      },
    );
  }

  _buttonWidget(){
    return sn.isSendingCode
        ? TextWaitingWidget(Translation.current.sendingCode)
        : CustomMansourButton(
      titleText: Translation.current.continuee,
      onPressed: () {
        sn.checkNumberAvailable();
      },
    );
  }

  _buildPhoneField() {
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
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: Translation.current.phone,
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.mansourDarkOrange3,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.mansourDarkOrange3,
                  ),
                ),
              ),
              controller: sn.newEmail,
              onChanged: (v) {
                sn.notifyListeners();
              },
            ),
          )
        ],
      ),
    );
  }
}
