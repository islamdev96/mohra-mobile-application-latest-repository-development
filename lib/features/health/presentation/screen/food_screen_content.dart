import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/health/presentation/screen/food_details_screen.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/health/presentation/state_m/provider/food_screen_notifier.dart';
import 'package:starter_application/features/health/presentation/widget/daily_dish_list_view.dart';
import 'package:starter_application/features/health/presentation/widget/health_days_list.dart';
import 'package:starter_application/features/health/presentation/widget/health_percent_indicator_card.dart';
import 'package:starter_application/features/health/presentation/widget/nutritions_card.dart';
import 'package:starter_application/features/health/presentation/widget/water_card.dart';
import 'package:starter_application/generated/l10n.dart';

class FoodScreenContent extends StatefulWidget {
  @override
  State<FoodScreenContent> createState() => _FoodScreenContentState();
}

class _FoodScreenContentState extends State<FoodScreenContent> {
  late FoodScreenNotifier sn;
  double itemHeight = 700.h;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<FoodScreenNotifier>(context);
    sn.context = context;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppConstants.screenPadding,
            child: Text(
              getTodayFormattedDate(),
              style: TextStyle(
                color: AppColors.mansourLightGreyColor_11,
                fontSize: 40.sp,
              ),
            ),
          ),
          Gaps.vGap64,
          HealthDaysList(
            height: 120.h,
            selectedDay: sn.selectedDay,
            onDayChange: sn.onDayChange,
          ),
          Gaps.vGap64,
          Padding(
            padding: AppConstants.screenPadding,
            child: BlocConsumer<HealthCubit, HealthState>(
              bloc: sn.healthCubit,
              listener: (context, state) {
                if (state is DailyDishListLoaded) {
                  sn.onDailyDishListLoaded(state.dailyDishListEntity);
                }
              },
              builder: (context, state) {
                return state.maybeMap(
                  orElse: () => const ScreenNotImplementedError(),
                  checkHealthProfileDone: (s) =>
                      const ScreenNotImplementedError(),
                  healthDashboardLoaded: (s) =>
                      const ScreenNotImplementedError(),
                  updateGoal: (s) => const ScreenNotImplementedError(),
                  goalUpdated: (s) => const ScreenNotImplementedError(),
                  recommendedSessionLoaded: (s) =>
                      const ScreenNotImplementedError(),
                  favoriteSessionsLoaded: (s) =>
                      const ScreenNotImplementedError(),
                  dailySessionCreated: (s) => const ScreenNotImplementedError(),
                  dailySessionsLoaded: (s) => const ScreenNotImplementedError(),
                  recommendedFoodLoaded: (s) =>
                      const ScreenNotImplementedError(),
                  favoriteDishesLoaded: (s) =>
                      const ScreenNotImplementedError(),
                  favoriteRecipesLoaded: (s) =>
                      const ScreenNotImplementedError(),
                  profileUpdated: (s) => const ScreenNotImplementedError(),
                  updateProfile: (s) => const ScreenNotImplementedError(),
                  answerQuestion: (s) => const ScreenNotImplementedError(),
                  questionAnswered: (s) => const ScreenNotImplementedError(),
                  createProfile: (s) => const ScreenNotImplementedError(),
                  profileCreated: (s) => const ScreenNotImplementedError(),
                  questionLoaded: (s) => const ScreenNotImplementedError(),
                  sessionListLoaded: (s) => const ScreenNotImplementedError(),
                  dishLoaded: (s) => const ScreenNotImplementedError(),
                  recipeLoaded: (s) => const ScreenNotImplementedError(),
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
                  foodCategoriesLoaded: (s) =>
                      const ScreenNotImplementedError(),
                  dailyWaterUpdated: (s) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: HeathPercentIndicatorCard(
                              height: itemHeight,
                              title: Translation.current.intake,
                              value: '${sn.dailyDishListEntity.intake}',
                              valueTitle: Translation.current.kcal_eaten,
                              gradiant: AppColors.healthGreenGradiant,
                              percent: sn.dailyDishListEntity.intake /
                                  sn.dailyDishListEntity.totalValueOfCalories,
                            ),
                          ),
                          SizedBox(
                            width: 50.w,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: itemHeight,
                              child: Column(
                                children: [
                                  BlocConsumer<HealthCubit, HealthState>(
                                    bloc: sn.healthCubit,
                                    listener: (context, state) {
                                      if (state is DailyDishListLoaded) {
                                        sn.onDailyDishListLoaded(
                                            state.dailyDishListEntity);
                                      }
                                    },
                                    builder: (context, state) {
                                      return state.maybeMap(
                                        orElse: () =>
                                            const ScreenNotImplementedError(),
                                        checkHealthProfileDone: (s) =>
                                            const ScreenNotImplementedError(),
                                        healthDashboardLoaded: (s) =>
                                            const ScreenNotImplementedError(),
                                        updateGoal: (s) =>
                                            const ScreenNotImplementedError(),
                                        goalUpdated: (s) =>
                                            const ScreenNotImplementedError(),
                                        recommendedSessionLoaded: (s) =>
                                            const ScreenNotImplementedError(),
                                        favoriteSessionsLoaded: (s) =>
                                            const ScreenNotImplementedError(),
                                        dailySessionCreated: (s) =>
                                            const ScreenNotImplementedError(),
                                        dailySessionsLoaded: (s) =>
                                            const ScreenNotImplementedError(),
                                        recommendedFoodLoaded: (s) =>
                                            const ScreenNotImplementedError(),
                                        favoriteDishesLoaded: (s) =>
                                            const ScreenNotImplementedError(),
                                        favoriteRecipesLoaded: (s) =>
                                            const ScreenNotImplementedError(),
                                        profileUpdated: (s) =>
                                            const ScreenNotImplementedError(),
                                        updateProfile: (s) =>
                                            const ScreenNotImplementedError(),
                                        answerQuestion: (s) =>
                                            const ScreenNotImplementedError(),
                                        questionAnswered: (s) =>
                                            const ScreenNotImplementedError(),
                                        createProfile: (s) =>
                                            const ScreenNotImplementedError(),
                                        profileCreated: (s) =>
                                            const ScreenNotImplementedError(),
                                        questionLoaded: (s) =>
                                            const ScreenNotImplementedError(),
                                        sessionListLoaded: (s) =>
                                            const ScreenNotImplementedError(),
                                        dishLoaded: (s) =>
                                            const ScreenNotImplementedError(),
                                        recipeLoaded: (s) =>
                                            const ScreenNotImplementedError(),
                                        recipeListLoaded: (s) =>
                                            const ScreenNotImplementedError(),
                                        dishListLoaded: (s) =>
                                            const ScreenNotImplementedError(),
                                        healthInitState: (s) => WaitingWidget(),
                                        healthLoadingState: (s) =>
                                            WaitingWidget(),
                                        createDailyDish: (s) =>
                                            const ScreenNotImplementedError(),
                                        uploadImage: (s) =>
                                            const ScreenNotImplementedError(),
                                        dailyDishCreated: (s) =>
                                            const ScreenNotImplementedError(),
                                        healthErrorState: (s) =>
                                            ErrorScreenWidget(
                                          error: s.error,
                                          callback: s.callback,
                                        ),
                                        foodCategoriesLoaded: (s) =>
                                            const ScreenNotImplementedError(),
                                        updateDailyWater: (s) => Container(
                                          height: itemHeight * 0.3,
                                          width: itemHeight * 0.3,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 40.h,
                                            vertical: 32.h,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30.r),
                                            gradient: const LinearGradient(
                                              colors:
                                                  AppColors.healthBlueGradiant,
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            ),
                                          ),
                                          child: const Center(
                                            child: CircularProgressIndicator
                                                .adaptive(),
                                          ),
                                        ),
                                        dailyWaterUpdated: (s) => WaterCard(
                                          hieght: itemHeight * 0.3,
                                          completedCupNum: sn.completedCupNum,
                                          totalCupNum: sn.totalCupNum,
                                          onAddTap: sn.onAddWaterTap,
                                          onRemoveTap: sn.onRemoveWaterTap,
                                          style: WaterCardStyle.STYLE2,
                                        ),
                                        dailyDishListLoaded: (s) => WaterCard(
                                          hieght: itemHeight * 0.3,
                                          completedCupNum: sn.completedCupNum,
                                          totalCupNum: sn.totalCupNum,
                                          onAddTap: sn.onAddWaterTap,
                                          onRemoveTap: sn.onRemoveWaterTap,
                                          style: WaterCardStyle.STYLE2,
                                        ),
                                        healthResultsLoaded: (s) =>
                                            const ScreenNotImplementedError(),
                                      );
                                    },
                                  ),
                                  /*  BlocListener<HealthCubit,HealthState>(
                                    bloc: sn.healthCubit,
                                    child:   WaterCard(
                                      hieght: itemHeight * 0.3,
                                      completedCupNum: sn.completedCupNum,
                                      totalCupNum: sn.totalCupNum,
                                      onAddTap: sn.onAddWaterTap,
                                      onRemoveTap: sn.onRemoveWaterTap,
                                      style: WaterCardStyle.STYLE2,
                                    ),
                                    listener: (context,state){
                                      if(state is DailyWaterUpdated){
                                        setState(() {

                                        });
                                      }

                                    },
                                    listenWhen: (previousState, state) {
                                      return  previousState != state;
                                    },
                                  ),*/

                                  SizedBox(
                                    height: 50.w,
                                  ),
                                  Expanded(
                                    child: NutritionsCard(
                                      carb: sn.dailyDishListEntity.carbs,
                                      fat: sn.dailyDishListEntity.fat,
                                      protein: sn.dailyDishListEntity.protein,
                                      calories: 3000,
                                      removeTitle: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gaps.vGap64,
                      _buildfoodLists()
                    ],
                  ),
                  dailyDishListLoaded: (s) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: HeathPercentIndicatorCard(
                              height: itemHeight,
                              title: Translation.current.intake,
                              value: '${sn.dailyDishListEntity.intake}',
                              valueTitle: Translation.current.kcal_eaten,
                              gradiant: AppColors.healthGreenGradiant,
                              percent: sn.dailyDishListEntity.intake /
                                  sn.dailyDishListEntity.totalValueOfCalories,
                            ),
                          ),
                          SizedBox(
                            width: 50.w,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: itemHeight,
                              child: Column(
                                children: [
                                  BlocListener<HealthCubit, HealthState>(
                                    bloc: sn.healthCubit,
                                    child: WaterCard(
                                      hieght: itemHeight * 0.3,
                                      completedCupNum: sn
                                          .dailyDishListEntity.totalCupsOfWater,
                                      totalCupNum: sn.totalCupNum,
                                      onAddTap: sn.onAddWaterTap,
                                      onRemoveTap: sn.onRemoveWaterTap,
                                      style: WaterCardStyle.STYLE2,
                                    ),
                                    listener: (context, state) {
                                      if (state is DailyWaterUpdated) {
                                        setState(() {});
                                      }
                                    },
                                    listenWhen: (previousState, state) {
                                      return previousState != state;
                                    },
                                  ),
                                  SizedBox(
                                    height: 50.w,
                                  ),
                                  Expanded(
                                    child: NutritionsCard(
                                      carb: sn.dailyDishListEntity.carbs,
                                      fat: sn.dailyDishListEntity.fat,
                                      protein: sn.dailyDishListEntity.protein,
                                      calories: 3000,
                                      removeTitle: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gaps.vGap64,
                      _buildfoodLists()
                    ],
                  ),
                  updateDailyWater: (s) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: HeathPercentIndicatorCard(
                              height: itemHeight,
                              title: Translation.current.intake,
                              value: '${sn.dailyDishListEntity.intake}',
                              valueTitle: Translation.current.kcal_eaten,
                              gradiant: AppColors.healthGreenGradiant,
                              percent: sn.dailyDishListEntity.intake /
                                  sn.dailyDishListEntity.totalValueOfCalories,
                            ),
                          ),
                          SizedBox(
                            width: 50.w,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: itemHeight,
                              child: Column(
                                children: [
                                  Container(
                                    height: itemHeight * 0.3,
                                    width: itemHeight * 0.3,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 40.h,
                                      vertical: 32.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.r),
                                      color: AppColors.mansourLightGreyColor_6,
                                    ),
                                    child: const Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50.w,
                                  ),
                                  Expanded(
                                    child: NutritionsCard(
                                      carb: sn.dailyDishListEntity.carbs,
                                      fat: sn.dailyDishListEntity.fat,
                                      protein: sn.dailyDishListEntity.protein,
                                      calories: 3000,
                                      removeTitle: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gaps.vGap64,
                      _buildfoodLists()
                    ],
                  ),
                  healthResultsLoaded: (s) => const ScreenNotImplementedError(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildfoodLists() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DailyDishListView(
          itemHeight: 300.h,
          title: Translation.current.breakfast,
          icon: AppConstants.SVG_BREAKFAST,
          items: sn.breakfastFoods,
          onTap: (index) => {},
        ),
        Gaps.vGap64,
        DailyDishListView(
          itemHeight: 300.h,
          title: Translation.current.lunch,
          icon: AppConstants.SVG_LUNCH,
          items: sn.lunchFoods,
          onTap: (index) => {},
        ),
        Gaps.vGap64,
        DailyDishListView(
          itemHeight: 300.h,
          title: Translation.current.dinner,
          icon: AppConstants.SVG_DINNER2,
          items: sn.dinnerFoods,
          onTap: (index) => {},
        ),
        Gaps.vGap64,
        DailyDishListView(
          itemHeight: 300.h,
          title: Translation.current.snack,
          icon: AppConstants.SVG_SNACKS,
          items: sn.snackFoods,
          onTap: (index) => {},
        ),
        SizedBox(
          height: AppConstants.bottomNavigationBarHeight + 100.h,
        ),
      ],
    );
  }
}
