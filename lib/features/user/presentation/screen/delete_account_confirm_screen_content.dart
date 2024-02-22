import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/user/presentation/screen/delete_account_success_screen.dart';
import 'package:starter_application/features/user/presentation/state_m/cubit/user_cubit.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/delete_account_confirm_screen_notifier.dart';

class DeleteAccountConfirmScreenContent extends StatelessWidget {
  late DeleteAccountConfirmScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<DeleteAccountConfirmScreenNotifier>(context);
    sn.context = context;
    return Container(
      height: 1.sh,
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Visibility(
            visible: UserSessionDataModel.provider == 'normal',
            child: Center(
              child: Text(
                Translation.current.password_confirm,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 70.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Gaps.vGap32,
          Center(
            child: Text(
              Translation.current.delete_confirm,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 50.sp,
                color: AppColors.text_gray,
              ),
            ),
          ),
          Gaps.vGap32,
          Visibility(
            visible: UserSessionDataModel.provider == 'normal',
            child: CustomTextField(
              controller: sn.textEditingController,
              maxLines: 9,
              height: 200,
              hintText: Translation.current.password,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              border:const OutlineInputBorder(
                borderSide: BorderSide(
                  width:1,
                  color: AppColors.text_gray
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    width:1,
                    color: AppColors.text_gray
                ),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    width:1,
                    color: AppColors.text_gray
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    width:1,
                    color: AppColors.text_gray
                ),
              ),
            ),
          ),
          Gaps.vGap32,

          BlocConsumer<UserCubit, UserState>(
              bloc: sn.userCubit,
              listener: (context, state) {
                if (state is DeleteAccountDone) {
                  sn.onAccountDeleted();
                }
                if (state is UserErrorState) {
                  sn.showError(state.error);
                }

              },
              builder: (context, state) {
                return state.map(
                  addressSelectedDone:(s) => ScreenNotImplementedError(),
                  setSelectAddress: (s) => ScreenNotImplementedError(),
                  emailChanged:(s) => ScreenNotImplementedError(),
                  addAddressDone: (s) => ScreenNotImplementedError(),
                  avatarLoaded: (s) => ScreenNotImplementedError(),
                  updateAddress: (s) => const ScreenNotImplementedError(),
                  updateAddressDone: (s) => const ScreenNotImplementedError(),
                  getCityDone: (s) => const ScreenNotImplementedError(),
                  userInitState: (s) =>  buildConfirmButton(),
                  userLoadingState: (s) => WaitingWidget(),
                  uploadImage: (s) => ScreenNotImplementedError(),
                  userErrorState: (s) => buildConfirmButton(),
                  updateProfile: (S) => ScreenNotImplementedError(),
                  updateProfileDone: (s) => ScreenNotImplementedError(),
                  uploadImageDone: (s) => ScreenNotImplementedError(),
                  addressDeleted: (s) => ScreenNotImplementedError(),
                  changePasswordDone: (s) => ScreenNotImplementedError(),
                  getProfileDone: (s) => ScreenNotImplementedError(),
                  getAddressesDone: (s) => ScreenNotImplementedError(),
                  deleteAccountDone: (s) => buildConfirmButton(),
                  getFriendMomentsDone: (s) => ScreenNotImplementedError(),

                );
              })


        ],
      ),
    );
  }

  buildConfirmButton(){
    return CustomMansourButton(
      titleText: Translation.current.confirm_delete,
      onPressed: () {
        sn.onConfirmTapped();
      },
    );
  }
}
