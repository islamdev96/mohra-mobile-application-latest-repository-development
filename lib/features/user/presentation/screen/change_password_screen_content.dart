import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/common/validators.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/user/presentation/state_m/cubit/user_cubit.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/change_password_screen_notifier.dart';

class ChangePasswordScreenContent extends StatelessWidget {
  late ChangePasswordScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<ChangePasswordScreenNotifier>(context);
    sn.context = context;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: Translation.current.old_password,
                  suffix: GestureDetector(
                    onTap: () {
                      sn.changeVisible();
                    },
                    child: Icon(sn.visiblePassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                  )),
              style: const TextStyle(
                color: AppColors.black,
              ),
              cursorColor: AppColors.mansourDarkOrange3,
              controller: sn.passwordController,
              obscureText: sn.visiblePassword,
              key: sn.PasswordKey,
              validator: (v) {
                if (v != null) {
                  return Validators.isValidPassword(v);
                }
              },
              onChanged: (value) {
                sn.PasswordKey.currentState!.validate();
                sn.canSave2();
              },
            ),
            Gaps.vGap32,
            TextFormField(
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: Translation.current.password,
                  suffix: GestureDetector(
                    onTap: () {
                      sn.changeVisible2();
                    },
                    child: Icon(sn.visiblePassword2
                        ? Icons.visibility_off
                        : Icons.visibility),
                  )),
              style: const TextStyle(
                color: AppColors.black,
              ),
              cursorColor: AppColors.mansourDarkOrange3,
              controller: sn.passwordController1,
              obscureText: sn.visiblePassword2,
              key: sn.PasswordKey2,
              validator: (v) {
                if (v != null) {
                  return Validators.isValidPassword(v);
                }
              },
              onChanged: (value) {
                sn.PasswordKey2.currentState!.validate();
                sn.canSave2();
              },
            ),
            Gaps.vGap32,
            TextFormField(
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: Translation.current.confirmPassword,
                  suffix: GestureDetector(
                    onTap: () {
                      sn.changeVisible3();
                    },
                    child: Icon(sn.visiblePassword3
                        ? Icons.visibility_off
                        : Icons.visibility),
                  )),
              style: const TextStyle(
                color: AppColors.black,
              ),
              cursorColor: AppColors.mansourDarkOrange3,
              controller: sn.passwordController2,
              obscureText: sn.visiblePassword3,
              key: sn.PasswordKey3,
              validator: (v) {
                if (v != null) {
                  if (sn.passwordController1.value.text != v) {
                    return Translation.current.invalidConfirmPassword;
                  }
                  return Validators.isValidPassword(v);
                }
              },
              onChanged: (value) {
                sn.PasswordKey3.currentState!.validate();
                sn.canSave2();
              },
            ),
            Gaps.vGap32,
            BlocConsumer<UserCubit, UserState>(
                bloc: sn.userCubit,
                listener: (context, state) {
                  if (state is ChangePasswordDone) {
                    sn.onPasswordChanged();
                  }
                  if (state is UserErrorState) {
                    sn.showError(state.error);
                  }
                },
                builder: (context, state) {
                  return state.maybeMap(
                    userLoadingState: (s) => WaitingWidget(),
                    uploadImage: (s) => const ScreenNotImplementedError(),
                    userErrorState: (s) => buildSaveButton(),
                    updateProfile: (S) => const ScreenNotImplementedError(),
                    updateProfileDone: (s) =>
                    const ScreenNotImplementedError(),
                    uploadImageDone: (s) => const ScreenNotImplementedError(),
                    getCityDone: (s) => const ScreenNotImplementedError(),
                    userInitState: (s) => buildSaveButton(),
                    updateAddress: (s) => const ScreenNotImplementedError(),
                    updateAddressDone: (s) => const ScreenNotImplementedError(),
                    getAddressesDone: (s) => buildSaveButton(),
                    addressDeleted: (s) =>ScreenNotImplementedError(),
                    changePasswordDone:(s) => buildSaveButton() ,
                    getProfileDone: (s) => ScreenNotImplementedError(),
                    orElse: ()=> buildSaveButton(),
                  );
                }),

          ],
        ),
      ),
    );
  }

  buildSaveButton(){
    return sn.canSave ? CustomMansourButton(
      titleText: Translation.current.save,
      onPressed: (){
        sn.onTapSave();
      },
    ) : CustomMansourButton(
      titleText: Translation.current.save,
      backgroundColor: AppColors.text_gray,
    );
  }
}
