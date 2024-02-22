import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/debouncer.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/models/health_profile_model.dart';
import 'package:starter_application/core/navigation/animations/animated_route.dart';
import 'package:starter_application/core/ui/dialogs/show_custom_date_picker.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/health/presentation/widget/health_dropdown.dart';
import 'package:starter_application/features/health/presentation/widget/health_textfield.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/edit_health_profile_screen_notifier.dart';

class EditHealthProfileScreenContent extends StatefulWidget {
  @override
  State<EditHealthProfileScreenContent> createState() =>
      _EditHealthProfileScreenContentState();
}

class _EditHealthProfileScreenContentState
    extends State<EditHealthProfileScreenContent> {
  late EditHealthProfileScreenNotifier sn;
  TextEditingController? controllerWeight = TextEditingController();
  TextEditingController? controllerHeight = TextEditingController();
  final _debouncerWeight = Debouncer(milliseconds: 900);
  final _debouncerHeight = Debouncer(milliseconds: 900);
  @override
  Widget build(BuildContext context) {
    sn = Provider.of<EditHealthProfileScreenNotifier>(context);
    sn.context = context;
    return Center(
      child: Container(
        height: 1.sh,
        width: .9.sw,
        child: ListView(
          children: [
            Gaps.vGap24,
            /*   Gaps.vGap128,
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => Nav.pop(),
                child: SvgPicture.asset(
                  AppConstants.SVG_ARROW_LEFT,
                  color: Colors.black,
                ),
              ),
            ),*/
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                Translation.current.edit_profile,
                style: GoogleFonts.cairo(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 80.sp)),
              ),
            ),
            Gaps.vGap128,
            _buildGenderDropDown(),
            Gaps.vGap32,
            _buildDatePicker(),
            Gaps.vGap32,
            _buildAnimation(
              num: 2,
              child: HealthTextField(
                hint: "${HealthProfileStaticModel.WEIGHT}",
                suffix: "kg",
                controller: controllerWeight,
                onChange: (value) {
                  _debouncerWeight.run(() {
                    if (value.isEmpty) {
                      controllerWeight!.clear();
                    } else {
                      if ((double.tryParse(value)??0)  >= 30 && (double.tryParse(value)??0)  <= 300) {
                        sn.weight = double.parse(value);
                      }
                      else {
                        showSnackbar(Translation.current.The_weight_must_be_real_not_imaginary);
                      }
                    }
                  });
                },
              ),
            ),
            Gaps.vGap32,
            _buildAnimation(
              num: 3,
              child: HealthTextField(
                hint: "${HealthProfileStaticModel.LENGTH}",
                suffix: "cm",
                controller: controllerHeight,
                onChange: (value) {
                  _debouncerHeight.run(() {
                    if (value.isEmpty) {
                      controllerHeight!.clear();
                    } else {
                      if ((double.tryParse(value)??0)  >= 70 && (double.tryParse(value)??0)  <= 220) {
                        sn.height = double.parse(value);
                      }
                      else {
                        showSnackbar(Translation.current.The_height_must_be_real_not_imaginary);
                      }
                    }
                  });
                },
              ),
            ),
            Gaps.vGap32,
            _buildMedicalConditionsDropDown(),
            Gaps.vGap64,
            _buildContinueButton(),
          ],
        ),
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
    return _buildAnimation(
      num: 0,
      child: HealthDropdown(
        items: [Translation.current.female, Translation.current.male],
        hint: HealthProfileStaticModel.GENDER == 1
            ? Translation.current.male
            : Translation.current.female,
        onChange: (value) {
          sn.gender = value ?? 0;
          print(sn.gender);
        },
      ),
    );
  }

  Widget _buildMedicalConditionsDropDown() {
    return _buildAnimation(
        num: 4,
        child: HealthDropdown(
          items: [
            Translation.current.healthy,
            Translation.current.very_healthy,
            Translation.current.normal,
          ],
          hint: HealthProfileStaticModel.HEALTH_SITUATION == 0
              ? Translation.current.healthy
              : HealthProfileStaticModel.HEALTH_SITUATION == 1
                  ? Translation.current.very_healthy
                  : Translation.current.normal,
          onChange: (value) {
            sn.healthSituation = value ?? 0;
            print(sn.healthSituation);
          },
        ));
  }

  Widget _buildContinueButton() {
    return BlocConsumer<HealthCubit, HealthState>(
        bloc: sn.healthCubit,
        listener: (context, state) {
          if (state is ProfileUpdated) {
            sn.onProfileUpdated(state.profileEntity);
          }
        },
        builder: (context, state) {
          return state.maybeMap(
            checkHealthProfileDone: (s) => const ScreenNotImplementedError(),
            dailyWaterUpdated: (s) => const ScreenNotImplementedError(),
            goalUpdated: (s) => const ScreenNotImplementedError(),
            recommendedSessionLoaded: (s) => const ScreenNotImplementedError(),
            favoriteSessionsLoaded: (s) => const ScreenNotImplementedError(),
            dailySessionCreated: (s) => const ScreenNotImplementedError(),
            dailySessionsLoaded: (s) => const ScreenNotImplementedError(),
            recommendedFoodLoaded: (s) => const ScreenNotImplementedError(),
            favoriteDishesLoaded: (s) => const ScreenNotImplementedError(),
            favoriteRecipesLoaded: (s) => const ScreenNotImplementedError(),
            healthDashboardLoaded: (s) => const ScreenNotImplementedError(),
            updateDailyWater: (s) => const ScreenNotImplementedError(),
            updateGoal: (s) => const ScreenNotImplementedError(),
            profileUpdated: (s) => _buildAnimation(
                num: 5,
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: CustomMansourButton(
                    width: 300.h,
                    borderRadius: Radius.circular(
                      20.r,
                    ),
                    titleText: Translation.current.continuee,
                    backgroundColor: AppColors.mansourDarkGreenColor,
                    onPressed: sn.onUpdateTapped,
                  ),
                )),
            updateProfile: (s) => TextWaitingWidget(
              Translation.current.updating_your_profile,
            ),
            createProfile: (s) => const ScreenNotImplementedError(),
            profileCreated: (s) => const ScreenNotImplementedError(),
            questionLoaded: (s) => const ScreenNotImplementedError(),
            answerQuestion: (s) => const ScreenNotImplementedError(),
            questionAnswered: (s) => const ScreenNotImplementedError(),
            recipeListLoaded: (s) => const ScreenNotImplementedError(),
            dishListLoaded: (s) => const ScreenNotImplementedError(),
            healthInitState: (s) => _buildAnimation(
              num: 5,
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: CustomMansourButton(
                  width: 300.h,
                  borderRadius: Radius.circular(
                    20.r,
                  ),
                  titleText: Translation.current.continuee,
                  backgroundColor: AppColors.mansourDarkGreenColor,
                  onPressed: sn.onUpdateTapped,
                ),
              ),
            ),
            healthLoadingState: (s) => WaitingWidget(),
            createDailyDish: (s) => const ScreenNotImplementedError(),
            uploadImage: (s) => const ScreenNotImplementedError(),
            dailyDishCreated: (s) => const ScreenNotImplementedError(),
            healthErrorState: (s) => ErrorScreenWidget(
              error: s.error,
              callback: s.callback,
            ),
            foodCategoriesLoaded: (s) => const ScreenNotImplementedError(),
            dailyDishListLoaded: (s) => const ScreenNotImplementedError(),
            dishLoaded: (s) => const ScreenNotImplementedError(),
            recipeLoaded: (s) => const ScreenNotImplementedError(),
            sessionListLoaded: (s) => const ScreenNotImplementedError(),
            orElse: ()=> _buildAnimation(
              num: 5,
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: CustomMansourButton(
                  width: 300.h,
                  borderRadius: Radius.circular(
                    20.r,
                  ),
                  titleText: Translation.current.continuee,
                  backgroundColor: AppColors.mansourDarkGreenColor,
                  onPressed: sn.onUpdateTapped,
                ),
              ),
            ),
          );
        });

    return _buildAnimation(
      num: 5,
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: CustomMansourButton(
          width: 300.h,
          borderRadius: Radius.circular(
            20.r,
          ),
          titleText: "Continue",
          backgroundColor: AppColors.mansourDarkGreenColor,
          onPressed: sn.onUpdateTapped,
        ),
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
              hintText: '${sn.dateOfBirth}',
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
                helpText: Translation.current.select_birth_date,
              );
              print(se);
              if (se != null) {
                setState(() {
                  sn.changeBirthDay(se);
                  sn.dateSelected = true;
                });
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
}
