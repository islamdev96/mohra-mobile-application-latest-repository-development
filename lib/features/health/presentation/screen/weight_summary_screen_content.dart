import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/health/presentation/logic/bmi_calculator/bmi_alculator.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/health/presentation/widget/goal_section.dart';
import 'package:starter_application/features/health/presentation/widget/health_dropdown.dart';
import 'package:starter_application/features/health/presentation/widget/height_weight_meters.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/weight_summary_screen_notifier.dart';

class WeightSummaryScreenContent extends StatefulWidget {
  @override
  State<WeightSummaryScreenContent> createState() =>
      _WeightSummaryScreenContentState();
}

class _WeightSummaryScreenContentState
    extends State<WeightSummaryScreenContent> {
  late WeightSummaryScreenNotifier sn;

  Widget divider = Divider(
    color: AppColors.accentColorLight.withOpacity(0.19),
    height: 150.h,
    thickness: 1,
  );

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<WeightSummaryScreenNotifier>(context);
    sn.context = context;
    return SingleChildScrollView(
      padding: AppConstants.screenPadding,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Gaps.vGap96,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HeightWeightMeters(
                personHeight: sn.profileModel.height!,
                perosonWeight: sn.profileModel.weight!,
                rulerMaxValueHeight:  220,
                rulerMaxValueWeight:  300,
                rulerSpace: 1,
                width: 600.w,
                gender: sn.profileModel.gender!,
              ),
              _buildRecommendedWeightAndBMIColumn(),
            ],
          ),
          divider,
          _buildGoalSection(),
          Gaps.vGap64,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Translation.current.select_activity_level_desc ,
                style: TextStyle(
                  color: AppColors.accentColorLight,
                  fontSize: 40.sp,
                ),
              ),
              Gaps.vGap32,
              _buildActivityLevelDropdown(),
            ],
          ),
          Gaps.vGap64,
          _buildContinueButton(),
          Gaps.vGap96,
        ],
      ),
    );
  }

  Widget _buildRecommendedWeightAndBMIColumn() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: Translation.current.ideal + "\n",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 60.sp,
                height: 1.2,
              ),
            ),
            TextSpan(
              text: Translation.current.your_bmi + " ${BMICalculator.BMI}",
              style: TextStyle(
                color: AppColors.accentColorLight,
                fontSize: 40.sp,
              ),
            ),
          ],
        ),
      ),
      Gaps.vGap64,
      Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text:
                  "${BMICalculator.minWeight} -${BMICalculator.maxWeight} kg\n",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 60.sp,
                height: 1.2,
              ),
            ),
            TextSpan(
              text: Translation.current.recommended_weight,
              style: TextStyle(
                color: AppColors.accentColorLight,
                fontSize: 40.sp,
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  /// Goal
  Widget _buildGoalSection() {
    return GoalSection(
      selectedWeight: sn.selectedWeight,
      onWeightChanged: sn.onTargetWeightChanged,
      goalDifficulties: sn.goalDifficulies,
      gainKG: (((sn.selectedWeight - sn.profileModel.weight!).abs()) * 100)
              .round() /
          100,
      onDifficaltySelected: (value) {
        sn.defficultySelectd = value ?? -1;
        sn.calculateTimeToReachGoal();
        print(sn.reachGoalWeeks);
        print(sn.reachGoalMonth);
      },
      reachMonth: sn.reachGoalMonth,
      reachWeeks: sn.reachGoalWeeks,
      gainOrLoss: sn.selectedWeight > sn.profileModel.weight!,
    );
  }

  Widget _buildContinueButton() {
    return BlocConsumer<HealthCubit, HealthState>(
        bloc: sn.healthCubit,
        listener: (context, state) {
          if (state is ProfileCreated) {
            sn.onProfileCreated(state.profileEntity);
          }
        },
        builder: (context, state) {
          return state.maybeMap(
            checkHealthProfileDone: (s) => const ScreenNotImplementedError(),
            healthDashboardLoaded: (s) => const ScreenNotImplementedError(),
            updateDailyWater: (s) => const ScreenNotImplementedError(),
            updateGoal: (s) => const ScreenNotImplementedError(),
            dailyWaterUpdated: (s) => const ScreenNotImplementedError(),
            goalUpdated: (s) => const ScreenNotImplementedError(),
            recommendedSessionLoaded: (s) => const ScreenNotImplementedError(),
            favoriteSessionsLoaded: (s) => const ScreenNotImplementedError(),
            dailySessionCreated: (s) => const ScreenNotImplementedError(),
            dailySessionsLoaded: (s) => const ScreenNotImplementedError(),
            recommendedFoodLoaded: (s) => const ScreenNotImplementedError(),
            favoriteDishesLoaded: (s) => const ScreenNotImplementedError(),
            favoriteRecipesLoaded: (s) => const ScreenNotImplementedError(),
            profileUpdated: (s) => const ScreenNotImplementedError(),
            updateProfile: (s) => const ScreenNotImplementedError(),
            createProfile: (s) => TextWaitingWidget(
              Translation.current.setup_your_profile,
            ),
            profileCreated: (s) => Align(
              alignment: AlignmentDirectional.centerEnd,
              child: CustomMansourButton(
                width: 300.h,
                borderRadius: Radius.circular(
                  20.r,
                ),
                titleText: Translation.current.continuee,
                backgroundColor: AppColors.mansourDarkGreenColor,
                onPressed: sn.onContinueTap,
              ),
            ),
            questionLoaded: (s) => const ScreenNotImplementedError(),
            answerQuestion: (s) => const ScreenNotImplementedError(),
            questionAnswered: (s) => const ScreenNotImplementedError(),
            recipeListLoaded: (s) => const ScreenNotImplementedError(),
            dishListLoaded: (s) => const ScreenNotImplementedError(),
            healthInitState: (s) => Align(
              alignment: AlignmentDirectional.centerEnd,
              child: CustomMansourButton(
                width: 300.h,
                borderRadius: Radius.circular(
                  20.r,
                ),
                titleText: Translation.current.continuee,
                backgroundColor: AppColors.mansourDarkGreenColor,
                onPressed: sn.onContinueTap,
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
            orElse: ()=> Align(
              alignment: AlignmentDirectional.centerEnd,
              child: CustomMansourButton(
                width: 300.h,
                borderRadius: Radius.circular(
                  20.r,
                ),
                titleText: Translation.current.continuee,
                backgroundColor: AppColors.mansourDarkGreenColor,
                onPressed: sn.onContinueTap,
              ),
            )
          );
        });
  }

  Widget _buildActivityLevelDropdown() {
    return HealthDropdown(
      items: sn.activitiesLevel,
      hint: Translation.current.select_activity_level,
      fontSize: 37.sp,
      onChange: (v){
        sn.activityLevelSelected = v ?? -1;
      },
    );
  }
}
