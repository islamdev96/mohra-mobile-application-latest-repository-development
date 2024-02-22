import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/dimens.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/models/health_profile_model.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/health/presentation/widget/health_goal_widget.dart';
import 'package:starter_application/features/health/presentation/widget/health_percent_indicator_card.dart';
import 'package:starter_application/features/health/presentation/widget/nutritions_card.dart';
import 'package:starter_application/features/health/presentation/widget/walking_card.dart';
import 'package:starter_application/features/health/presentation/widget/water_card.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/health_home_screen_notifier.dart';

class HealthHomeScreenContent extends StatefulWidget {
  @override
  State<HealthHomeScreenContent> createState() =>
      _HealthHomeScreenContentState();
}

class _HealthHomeScreenContentState extends State<HealthHomeScreenContent> {
  late HealthHomeScreenNotifier sn;
  double space = 30.w;
  double itemHeightlarge = 550.h;
  double itemHeightSmall = 550.h;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<HealthHomeScreenNotifier>(context);

    sn.context = context;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        left: AppConstants.hPadding,
        right: AppConstants.hPadding,
        top: Dimens.dp24.h,
        bottom: AppConstants.bottomNavigationBarHeight + 50.h,
      ),
      child: BlocConsumer<HealthCubit, HealthState>(
          bloc: sn.healthCubit,
          listener: (context, state) {
            if (state is HealthDashboardLoaded) {
              // Future.delayed(Duration(
              //     milliseconds: 3000
              // )).whenComplete(() {
              //   sn.initPlatformState();
              // });
              sn.onHealthDashboardLoaded(state.healthDashboardEntity);
            }
            if (state is GoalUpdated) {
              sn.onGoalUpdated();
            }
          },
          builder: (context, state) {
            return state.maybeMap(
                checkHealthProfileDone: (s) =>
                    const ScreenNotImplementedError(),
                recommendedSessionLoaded: (s) =>
                    const ScreenNotImplementedError(),
                favoriteSessionsLoaded: (s) =>
                    const ScreenNotImplementedError(),
                dailySessionCreated: (s) => const ScreenNotImplementedError(),
                dailySessionsLoaded: (s) => const ScreenNotImplementedError(),
                recommendedFoodLoaded: (s) => const ScreenNotImplementedError(),
                favoriteDishesLoaded: (s) => const ScreenNotImplementedError(),
                favoriteRecipesLoaded: (s) => const ScreenNotImplementedError(),
                profileUpdated: (s) => const ScreenNotImplementedError(),
                updateProfile: (s) => const ScreenNotImplementedError(),
                createProfile: (s) => const ScreenNotImplementedError(),
                profileCreated: (s) => const ScreenNotImplementedError(),
                questionLoaded: (s) => const ScreenNotImplementedError(),
                answerQuestion: (s) => const ScreenNotImplementedError(),
                questionAnswered: (s) => const ScreenNotImplementedError(),
                recipeListLoaded: (s) => const ScreenNotImplementedError(),
                dishListLoaded: (s) => const ScreenNotImplementedError(),
                healthInitState: (s) => WaitingWidget(),
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
                updateDailyWater: (s) => buildScreen(),
                updateGoal: (s) => buildScreen(),
                stepsUpdated: (s) => buildScreen(),
                dailyWaterUpdated: (s) => buildScreen(),
                goalUpdated: (s) => buildScreen(),
                healthDashboardLoaded: (s) => buildScreen(),
                orElse: () => buildScreen());
          }),
    );
  }

  buildScreen() {
    return Column(
      children: [
        SizedBox(
          height: space,
        ),
        _buildItem(
          title: Translation.current.day_calories_desc,
          subtitle:
              "${sn.healthDashboardEntity.intakeKcal}/${(sn.healthDashboardEntity.totalValueOfCalories).toStringAsFixed(0)} ${Translation.current.calories}",
          percent: sn.healthDashboardEntity.intakeKcal /
              sn.healthDashboardEntity.totalValueOfCalories,
          percentGradient: AppColors.healthPurpleGradiant,
        ),
        SizedBox(
          height: space,
        ),
        Row(
          children: [
            Expanded(
              child: HeathPercentIndicatorCard(
                height: itemHeightlarge,
                title: Translation.current.intake,
                value: "${sn.healthDashboardEntity.intakeKcal}",
                valueTitle: Translation.current.kcal_eaten,
                gradiant: AppColors.healthGreenGradiant,
                percent: 0.6,
              ),
            ),
            SizedBox(
              width: space,
            ),
            Expanded(
              child: HeathPercentIndicatorCard(
                height: itemHeightlarge,
                title: Translation.current.training,
                value: "${sn.healthDashboardEntity.trainingKcal}",
                valueTitle: Translation.current.kcal_burned,
                gradiant: AppColors.healthRedGradiant,
                percent: 0.4,
              ),
            ),
          ],
        ),
        SizedBox(
          height: space,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  WaterCard(
                    hieght: itemHeightSmall,
                    completedCupNum: sn.completedCupNum,
                    totalCupNum: sn.totalCupNum,
                    onAddTap: sn.onAddWaterTap,
                    onRemoveTap: sn.onRemoveWaterTap,
                  ),
                  SizedBox(
                    height: space,
                  ),
                  HealthGoalWidget(
                    height: itemHeightlarge,
                    title: Translation.current.goals,
                    value: "${sn.goalValue} kg",
                    valueTitle:
                        "${Translation.current.ooff} ${HealthProfileStaticModel.WEIGHT} kg",
                    gradiant: AppColors.healthOrangeGradiant,
                    percent: 0.5,
                    trailing: GestureDetector(
                      onTap: () {
                        sn.onIncreaseGoal();
                      },
                      child: Container(
                        height: 80.h,
                        width: 80.h,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColorLight.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(
                            20.r,
                          ),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 50.h,
                        ),
                      ),
                    ),
                    trailing1: GestureDetector(
                      onTap: () {
                        sn.onDecreaseGoal();
                      },
                      child: Container(
                        height: 80.h,
                        width: 80.h,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColorLight.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(
                            20.r,
                          ),
                        ),
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 50.h,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: space,
            ),
            Expanded(
                child: Column(
              children: [
                NutritionsCard(
                  height: itemHeightlarge,
                  fat: sn.healthDashboardEntity.fat,
                  carb: sn.healthDashboardEntity.carbs,
                  protein: sn.healthDashboardEntity.protein,
                  calories: 3000,
                ),
                SizedBox(
                  height: space,
                ),
                WalkingCard(
                  height: itemHeightSmall,
                  steps: sn.walkingSteps,
                ),
              ],
            )),
          ],
        ),
      ],
    );
  }

  Widget _buildItem({
    required String title,
    required String subtitle,
    required double percent,
    required List<Color> percentGradient,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 40.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: AppColors.mansourLightGreyColor_11,
                fontSize: 40.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        Gaps.vGap32,
        LinearPercentIndicator(
          percent: percent,
          backgroundColor: AppColors.mansourLightGreyColor_7,
          linearGradient: LinearGradient(
            colors: percentGradient,
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
          animation: true,
          lineHeight: 22.h,
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }
}
