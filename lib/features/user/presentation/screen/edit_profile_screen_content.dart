import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/models/health_profile_model.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/animations/animated_route.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/dialogs/show_custom_date_picker.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/health/presentation/widget/health_dropdown.dart';
import 'package:starter_application/features/health/presentation/widget/profile/circled_profile_pic.dart';
import 'package:starter_application/features/mylife/presentation/logic/date_time_helper.dart';
import 'package:starter_application/features/user/presentation/state_m/cubit/user_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../core/ui/dialogs/show_dialog.dart';
import '../screen/../state_m/provider/edit_profile_screen_notifier.dart';

class EditProfileScreenContent extends StatefulWidget {
  @override
  State<EditProfileScreenContent> createState() =>
      _EditProfileScreenContentState();
}

class _EditProfileScreenContentState extends State<EditProfileScreenContent> {
  late EditProfileScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<EditProfileScreenNotifier>(context);
    sn.context = context;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Container(
              width: 1.sw,
              height: 0.1.sh,
              child: Center(
                child: ProfilePic(
                  width: 0.3.sw,
                  height: 0.1.sh,
                  imageUrl: UserSessionDataModel.imageUrl ?? null,
                ),
              ),
            ),
          ),
          Gaps.vGap24,
          GestureDetector(
            onTap: sn.onUpdateImage,
            child: Icon(
              Icons.upload_sharp,
              size: 35,
            ),
          ),
          Gaps.vGap24,
          Container(
            width: 0.9.sw,
            child: Column(
              children: [
                _buildAnimation(
                  num: 1,
                  child: CustomTextField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    height: 70,
                    hintText: Translation.current.firstName,
                    fillColor: AppColors.mansourLightGreyColor,
                    primaryFieldColor: AppColors.regularFontColor,
                    controller: sn.nameController,
                    filled: true,
                  ),
                ),
                Gaps.vGap24,
                _buildAnimation(
                  num: 2,
                  child: CustomTextField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    height: 70,
                    hintText: Translation.current.lastName,
                    fillColor: AppColors.mansourLightGreyColor,
                    primaryFieldColor: AppColors.regularFontColor,
                    controller: sn.lastNameController,
                    filled: true,
                  ),
                ),
                Gaps.vGap24,
                _buildAnimation(
                  num: 3,
                  child: CustomTextField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    height: 70,
                    hintText: Translation.current.email,
                    fillColor: AppColors.mansourLightGreyColor,
                    primaryFieldColor: AppColors.regularFontColor,
                    controller: sn.emailController,
                    filled: true,
                  ),
                ),
                Gaps.vGap24,
                _buildAnimation(child: _buildDatePicker(), num: 4),
                Gaps.vGap24,
                _buildAnimation(child: _buildGenderDropDown(), num: 5),
                Gaps.vGap32,
                BlocConsumer<UserCubit, UserState>(
                    bloc: sn.userCubit,
                    listener: (context, state) {
                      if (state is UploadImageDone) {
                        sn.onUpdateImageDone(state.imageUrlsEntity);
                        setState(() {});
                      }
                      if (state is UpdateProfileDone) {
                        sn.onUpdateProfleDone(state.updateProfileEntity);

                        setState(() {});
                      }
                    },
                    builder: (context, state) {
                      return state.map(
                        addressSelectedDone: (s) => ScreenNotImplementedError(),
                        setSelectAddress: (s) => ScreenNotImplementedError(),
                        emailChanged: (s) => ScreenNotImplementedError(),
                        deleteAccountDone: (s) => ScreenNotImplementedError(),
                        addAddressDone: (s) => ScreenNotImplementedError(),
                        avatarLoaded: (s) => ScreenNotImplementedError(),
                        updateAddress: (s) => const ScreenNotImplementedError(),
                        updateAddressDone: (s) =>
                            const ScreenNotImplementedError(),
                        getCityDone: (s) => const ScreenNotImplementedError(),
                        userInitState: (s) => _buildAnimation(
                            child: _buildContinueButton(), num: 6),
                        userLoadingState: (s) => _buildAnimation(
                            child: _buildContinueButton(), num: 6),
                        uploadImage: (s) => WaitingWidget(),
                        userErrorState: (s) => ErrorScreenWidget(
                          error: s.error,
                          callback: s.callback,
                        ),
                        updateProfile: (S) => WaitingWidget(),
                        updateProfileDone: (s) => _buildAnimation(
                            child: _buildContinueButton(), num: 6),
                        uploadImageDone: (s) => WaitingWidget(),
                        getAddressesDone: (s) => _buildAnimation(
                            child: _buildContinueButton(), num: 6),
                        addressDeleted: (s) => ScreenNotImplementedError(),
                        changePasswordDone: (s) => ScreenNotImplementedError(),
                        getProfileDone: (s) => ScreenNotImplementedError(),
                        getFriendMomentsDone: (s) =>
                            ScreenNotImplementedError(),
                      );
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAnimation({
    required Widget child,
    required int num,
    double step = 0.1,
  }) {
    final intervalStart = step * num;

    return SlidingAnimated(
      direction: Axis.vertical,
      initialOffset: 5,
      intervalStart: intervalStart,
      intervalEnd: intervalStart + step,
      child: child,
    );
  }

  Widget _buildGenderDropDown() {
    print('UserSessionDataModel.gender');
    print(UserSessionDataModel.gender);
    return _buildAnimation(
      num: 0,
      child: HealthDropdown(
        items: [Translation.current.female, Translation.current.male],
        hint: UserSessionDataModel.gender == 1
            ? Translation.current.male
            : Translation.current.female,
        onChange: (value) {
          sn.gender = value ?? 0;
          print(sn.gender);
        },
      ),
    );
  }

  Widget _buildDatePicker() {
    return Container(
      height: 150.h,
      decoration: const BoxDecoration(
        color: AppColors.mansourLightGreyColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Stack(
        children: [
          Container(
            height: 150.h,
            decoration: const BoxDecoration(
              color: AppColors.mansourLightGreyColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: CustomTextField(
              keyboardType: TextInputType.none,
              textInputAction: TextInputAction.none,
              enabled: false,
              hintText:
                  '${DateTimeHelper.stringToParsedString(sn.dateOfBirth)}',
            ),
          ),
          GestureDetector(
            onTap: () async {
              print('aaa');
              final DateTime? se = await showCustomDatePicker(
                context: context,
                initialDate: sn.birthDay,
                firstDate: DateTime(1930),
                lastDate: DateTime.now(),
                cancelText: Translation.current.cancel,
                confirmText: Translation.current.select,
                locale: Locale('en'),
                helpText: Translation.current.select_birth_date,
              );
              print(se);
              if (se != null) {
                sn.changeBirthDay(se);
                sn.dateSelected = true;
              }
            },
            child: Container(
              height: 150.h,
              color: Colors.transparent,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: CustomMansourButton(
        width: 300.h,
        borderRadius: Radius.circular(
          20.r,
        ),
        titleText: Translation.current.save,
        backgroundColor: AppColors.mansourDarkOrange,
        onPressed: sn.onUpdateTapped,
      ),
    );
  }
}
