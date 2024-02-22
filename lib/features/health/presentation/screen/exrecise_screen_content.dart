import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/health/presentation/widget/daily_sessions_list_view.dart';
import 'package:starter_application/features/health/presentation/widget/exrecise/training_walking.dart';
import 'package:starter_application/features/health/presentation/widget/health_days_list.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/exrecise_screen_notifier.dart';

class ExreciseScreenContent extends StatefulWidget {
  @override
  State<ExreciseScreenContent> createState() => _ExreciseScreenContentState();
}

class _ExreciseScreenContentState extends State<ExreciseScreenContent> {
  late ExreciseScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<ExreciseScreenNotifier>(context);
    sn.context = context;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppConstants.screenPadding,
            child: Text(
              sn.getTodayFormattedDate(),
              style: TextStyle(
                color: AppColors.mansourLightGreyColor_11,
                fontSize: 40.sp,
              ),
            ),
          ),
          Gaps.vGap32,
          HealthDaysList(
            height: 120.h,
            selectedDay: sn.selectedDay,
            onDayChange: sn.onDayChange,
          ),
          Gaps.vGap32,
          BlocConsumer<HealthCubit, HealthState>(
            bloc: sn.healthCubit,
            listener: (context, state) {
              if (state is DailySessionsLoaded) {
                sn.onDailyDishListLoaded(state.dailySessionListEntity);
              }
            },
            builder: (context, state) {
              return state.maybeMap(
                checkHealthProfileDone: (s) =>
                    const ScreenNotImplementedError(),
                healthDashboardLoaded: (s) => const ScreenNotImplementedError(),
                updateDailyWater: (s) => const ScreenNotImplementedError(),
                updateGoal: (s) => const ScreenNotImplementedError(),
                dailyWaterUpdated: (s) => const ScreenNotImplementedError(),
                goalUpdated: (s) => const ScreenNotImplementedError(),
                recommendedSessionLoaded: (s) =>
                    const ScreenNotImplementedError(),
                favoriteSessionsLoaded: (s) =>
                    const ScreenNotImplementedError(),
                dailySessionCreated: (s) => const ScreenNotImplementedError(),
                recommendedFoodLoaded: (s) => const ScreenNotImplementedError(),
                favoriteDishesLoaded: (s) => const ScreenNotImplementedError(),
                favoriteRecipesLoaded: (s) => const ScreenNotImplementedError(),
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
                foodCategoriesLoaded: (s) => const ScreenNotImplementedError(),
                dailyDishListLoaded: (s) => const ScreenNotImplementedError(),
                dailySessionsLoaded: (s) => _buildDayExrcises(),
                orElse: ()=>_buildDayExrcises(),
              );
            },
          ),
        ],
      ),
    );
  }

  Padding _buildDayExrcises() {
    return Padding(
      padding: AppConstants.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TrainingWalking(
            traning: sn.dailySessionListEntity.trainingKcal,
            walking: sn.dailySessionListEntity.walkingKcal,
          ),
          Gaps.vGap64,
          InkWell(
            onTap: (){
              sn.onAddNewTapped();
            },
            child: Row(

              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.add , color:  AppColors.greenColor,),
                Text(Translation.current.add_new_exercise,
                style: TextStyle(
                  color:  Colors.black,
                  fontSize: 50.sp,

                ),
                ),
              ],
            ),
          ),
          Gaps.vGap64,
          DailySessionsListView(
            itemHeight: 300.h,
            title: Translation.current.daily_activity,
            icon: AppConstants.SVG_DUMBELL,
            items: sn.dailySessionListEntity.items,
          ),
          SizedBox(
            height: AppConstants.bottomNavigationBarHeight + 100.h,
          ),
        ],
      ),
    );
  }
}
