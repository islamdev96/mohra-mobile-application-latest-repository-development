import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/provider/session_data.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/common/validators.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/animations/animated_route.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/errv_snack_bar_options.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_snackbar_based_error_type.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/register_with_google_screen_notifier.dart';

class RegisterWithGoogleScreenContent extends StatelessWidget {
  late RegisterWithGoogleScreenNotifier sn;
  @override
  Widget build(BuildContext context) {
    sn = Provider.of<RegisterWithGoogleScreenNotifier>(context);
    sn.context = context;
    return Form(
      key: sn.formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildAppbarTitle(Translation.of(context).Register_With_Google),
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
                    child: _buildNameField(),
                  ),
                  Gaps.vGap50,
                  SlidingAnimated(
                    initialOffset: 5,
                    intervalStart: 0.1,
                    intervalEnd: 0.2,
                    child: _buildLastNameField(),
                  ),
                  Gaps.vGap50,
                  SlidingAnimated(
                    initialOffset: 5,
                    intervalStart: 0.3,
                    intervalEnd: 0.4,
                    child: Container(
                      height: 130.h,
                      width: 0.92.sw,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: AppColors.mansourLightGreyColor_5,
                            style: BorderStyle.solid),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: 40.w,
                        ),
                        child: CustomListTile(
                          title: Text(
                            sn.date != null
                                ? DateFormat('yMd').format(sn.date!)
                                : Translation.of(context).Birth_Date,
                            style: TextStyle(
                              color: sn.date != null
                                  ? Colors.black
                                  : AppColors.mansourNotSelectedBorderColor,
                              fontSize: 40.sp,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: AppColors.mansourBackArrowColor,
                            size: 45.sp,
                          ),
                          onTap: sn.onDatePickerTap,
                        ),
                      ),
                    ),
                  ),
                  if (sn.isDateValidate && sn.date == null) Gaps.vGap32,
                  if (sn.isDateValidate && sn.date == null)
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: 40.w,
                      ),
                      child: Text(
                        Translation.of(context).errorEmptyField,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 40.sp,
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
                  Gaps.vGap50,
                  _buildUserNameField(),
                  Gaps.vGap128,
                  BlocConsumer<AccountCubit, AccountState>(
                      listener: (context, state) {
                        if(state is RegisterWithGoogleDone) {
                          sn.onRegisterDone(state.loginEntity);
                        }
                        if(state is AccountError){
                          showSnakBarBasedErrorType(context, state.error, (){}, retryWhenNotAuthorized: false);
                        }
                      },
                      bloc: sn.accountCubit,
                      builder: (context, state) {
                        return state.maybeMap(
                            orElse: () => const SizedBox.shrink(),
                            hasAvatarChecked: (s) =>
                                ScreenNotImplementedError(),
                            getAvatar: (s) => ScreenNotImplementedError(),
                            forgetpasswordLoaded: (s) =>
                            const SizedBox.square(),
                            passwordCodeVerified: (s) => Container(),
                            accountError: (s) => _buildButton(),
                            accountInit: (s) => _buildButton(),
                            accountLoading: (s) => WaitingWidget(),
                            loginLoaded: (s) => Container(),
                            registerLoaded: (s) => Container(),
                            verifyLoaded: (s) => Container(),
                          registerWithGoogleDone: (s) => _buildButton(),

                        );
                      }),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }




  _buildButton(){
    return SlidingAnimated(
      initialOffset: 5,
      intervalStart: 0.3,
      intervalEnd: 0.4,
      child: CustomMansourButton(
        titleText: Translation.of(sn.context)
            .Register_With_Google,
        backgroundColor: Colors.white,
        borderColor:
        AppColors.primaryColorLight,
        textColor:
        AppColors.primaryColorLight,
        onPressed: () {
          sn.onRegisterTapped();
        },
      ),
    );
  }



  /// build ui widget
  Widget _builDescription() {
    return Text(
      Translation.of(sn.context).register_2_desc_part1 + Translation.of(sn.context).register_2_desc_part2,
      style: TextStyle(
        color: Colors.black,
        fontSize: 45.sp,
      ),
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
            child: CustomTextField(
              primaryFieldColor: AppColors.regularFontColor,
              textKey: sn.phoneKey,
              controller: sn.phoneController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              focusNode: sn.myFocusNodePhone,
              hintText: Translation.of(sn.context).Mobile_Number,
              prefixIconConstraints: BoxConstraints(
                minWidth: 0,
                minHeight: 0,
                maxHeight: 80.h,
                maxWidth: 100.h,
              ),
              validator: (phone) {
                if ((phone == null || (phone.trim().isEmpty)) ||
                    phone.length < 10)
                  return Translation.of(sn.context).errorEmptyField;
                if (!Validators.isValidPhoneNumber(phone)) {
                  return Translation.of(sn.context).validatorMobileNumber;
                } else
                  return null;
              },
              onFieldSubmitted: (term) {
                fieldFocusChange(
                  sn.context,
                  sn.myFocusNodePhone,
                  sn.userNameFocusNode,
                );
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

  _buildUserNameField() {
    return Container(
      height: 130.h,
      width: 0.92.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
            color: AppColors.mansourLightGreyColor_5,
            style: BorderStyle.solid),
      ),
      child: CustomTextField(
        primaryFieldColor: AppColors.regularFontColor,
        textKey: sn.userNameKey,
        controller: sn.userNameController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        focusNode: sn.userNameFocusNode,
        hintText: Translation.of(sn.context).Enter_your_user_name,
        contentPadding: EdgeInsets.zero,
        horizontalMargin: 40.w,
        validator: (value) {
          if (Validators.isValidName(value!))
            return null;
          else
            return Translation.of(sn.context).errorEmptyField;
        },
        onFieldSubmitted: (term) {
          sn.userNameFocusNode.unfocus();
        },
        onChanged: (value) {
          sn.userNameKey.currentState!.validate();
        },
      ),
    );
  }

  _buildNameField() {
    return Container(
      height: 130.h,
      width: 0.92.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
            color: AppColors.mansourLightGreyColor_5,
            style: BorderStyle.solid),
      ),
      child: CustomTextField(
        primaryFieldColor: AppColors.regularFontColor,
        textKey: sn.nameKey,
        controller: sn.nameController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        focusNode: sn.myFocusNodeName,
        hintText: Translation.current.firstName,
        contentPadding: EdgeInsets.zero,
        horizontalMargin: 40.w,
        validator: (value) {
          if (Validators.isValidName(value!))
            return null;
          else
            return Translation.current.errorEmptyField;
        },
        onFieldSubmitted: (term) {
          fieldFocusChange(sn.context, sn.myFocusNodeName, sn.myFocusNodeLastName);
        },
        onChanged: (value) {
          Provider.of<SessionData>(sn.context, listen: false).firstName = value;
          sn.nameKey.currentState!.validate();
        },
      ),
    );
  }

  _buildLastNameField() {
    return Container(
      height: 130.h,
      width: 0.92.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
            color: AppColors.mansourLightGreyColor_5,
            style: BorderStyle.solid),
      ),
      child: CustomTextField(
        primaryFieldColor: AppColors.regularFontColor,
        textKey: sn.lastNameKey,
        controller: sn.lastNameController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        focusNode: sn.myFocusNodeLastName,
        hintText: Translation.current.lastName,
        contentPadding: EdgeInsets.zero,
        horizontalMargin: 40.w,
        validator: (value) {
          if (Validators.isValidName(value!))
            return null;
          else
            return Translation.current.errorEmptyField;
        },
        onFieldSubmitted: (term) {
          sn.myFocusNodeLastName.unfocus();
        },
        onChanged: (value) {
          Provider.of<SessionData>(sn.context, listen: false).lastName = value;

          sn.lastNameKey.currentState!.validate();
        },
      ),
    );
  }


}
