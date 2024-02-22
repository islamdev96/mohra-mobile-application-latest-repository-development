import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/health/presentation/widget/exrecise/exercise_list_view.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/workout_details_screen_notifier.dart';

class WorkoutDetailsScreenContent extends StatefulWidget {
  @override
  State<WorkoutDetailsScreenContent> createState() =>
      _WorkoutDetailsScreenContentState();
}

class _WorkoutDetailsScreenContentState
    extends State<WorkoutDetailsScreenContent> {
  late WorkoutDetailsScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<WorkoutDetailsScreenNotifier>(context);
    sn.context = context;
    return WillPopScope(
      onWillPop: () => sn.onWillPop(),
      child: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        controller: sn.scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.vGap32,
            _buildImage(),
            AnimatedSize(
              child: SizedBox(
                height: sn.isInitialPhase ? 64.h : 0,
              ),
              curve: sn.curve,
              duration: sn.animationDuration,
            ),
            _buildTitle(),
            Gaps.vGap12,
            _buildSubtitle(),
            AnimatedSize(
              child: SizedBox(
                height: sn.isInitialPhase ? 64.h : 0,
              ),
              curve: sn.curve,
              duration: sn.animationDuration,
            ),
            _buildDescription(),
            Gaps.vGap64,
            _buildworkoutLists(),
            Gaps.vGap64,
            BlocConsumer<HealthCubit, HealthState>(
                bloc: sn.healthCubit,
                listener: (context, state) {
                  if (state is DailySessionCreated) {
                    sn.onPlayFinish();
                  }
                },
                builder: (context, state) {
                  return state.maybeMap(
                    checkHealthProfileDone: (s) =>
                        const ScreenNotImplementedError(),
                    healthDashboardLoaded: (s) =>
                        const ScreenNotImplementedError(),
                    updateDailyWater: (s) => const ScreenNotImplementedError(),
                    updateGoal: (s) => const ScreenNotImplementedError(),
                    dailyWaterUpdated: (s) => const ScreenNotImplementedError(),
                    goalUpdated: (s) => const ScreenNotImplementedError(),
                    recommendedSessionLoaded: (s) =>
                        const ScreenNotImplementedError(),
                    favoriteSessionsLoaded: (s) =>
                        const ScreenNotImplementedError(),
                    dailySessionsLoaded: (s) =>
                        const ScreenNotImplementedError(),
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
                    recipeListLoaded: (s) => const ScreenNotImplementedError(),
                    dishListLoaded: (s) => const ScreenNotImplementedError(),
                    healthInitState: (s) => CustomMansourButton(
                      width: 1.sw,
                      borderRadius: Radius.circular(
                        20.r,
                      ),
                      titleText: Translation.current.play,
                      backgroundColor: AppColors.mansourDarkGreenColor,
                      onPressed: () {
                        sn.play();
                      },
                    ),
                    healthLoadingState: (s) => TextWaitingWidget(
                      Translation.current.add_to_daily_sessions,
                    ),
                    createDailyDish: (s) => const ScreenNotImplementedError(),
                    uploadImage: (s) => const ScreenNotImplementedError(),
                    dailyDishCreated: (s) => const ScreenNotImplementedError(),
                    healthErrorState: (s) => ErrorScreenWidget(
                      error: s.error,
                      callback: s.callback,
                    ),
                    foodCategoriesLoaded: (s) =>
                        const ScreenNotImplementedError(),
                    dailyDishListLoaded: (s) =>
                        const ScreenNotImplementedError(),
                    dishLoaded: (s) => const ScreenNotImplementedError(),
                    recipeLoaded: (s) => const ScreenNotImplementedError(),
                    sessionListLoaded: (s) => const ScreenNotImplementedError(),
                    questionLoaded: (s) => const ScreenNotImplementedError(),
                    dailySessionCreated: (s) => CustomMansourButton(
                      width: 1.sw,
                      borderRadius: Radius.circular(
                        20.r,
                      ),
                      titleText: "Play",
                      backgroundColor: AppColors.mansourDarkGreenColor,
                      onPressed: () {
                        sn.play();
                      },
                    ),
                    orElse: ()=>CustomMansourButton(
                      width: 1.sw,
                      borderRadius: Radius.circular(
                        20.r,
                      ),
                      titleText: Translation.current.play,
                      backgroundColor: AppColors.mansourDarkGreenColor,
                      onPressed: () {
                        sn.play();
                      },
                    )
                  );
                }),
            Gaps.vGap32,
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return AnimatedSize(
        curve: sn.curve,
        duration: sn.animationDuration,
        child: AnimatedOpacity(
            curve: sn.curve,
            duration: sn.animationDuration,
            opacity: sn.isInitialPhase ? 1 : 0,
            child: Container(
              height: sn.isInitialPhase ? 550.h : 0,
              width: 1.sw,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  30.r,
                ),
              ),
              child: Hero(
                tag: 'hero${sn.oneSessionEntity.id}',
                child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    height: sn.isInitialPhase ? 550.h : 0,
                    width: 1.sw,
                    imageUrl: "${sn.oneSessionEntity.imageUrl}",
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator.adaptive()),
                    errorWidget: (context, url, error) => Icon(Icons.error)),
              ),
            )));
  }

  Widget _buildTitle() {
    return Text(
      "${sn.oneSessionEntity.title}",
      style: TextStyle(
        fontSize: 55.sp,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      "${sn.oneSessionEntity.amountOfCalories} kcal | ${sn.oneSessionEntity.timeInMinutes} min | ${sn.oneSessionEntity.exercises.length} Exrecise",
      style: TextStyle(
        fontSize: 35.sp,
        color: AppColors.accentColorLight,
      ),
    );
  }

  Widget _buildDescription() {
    return AnimatedDefaultTextStyle(
      curve: sn.curve,
      duration: sn.animationDuration,
      style: TextStyle(
        fontSize: sn.isInitialPhase ? 35.sp : 0,
        color: AppColors.accentColorLight,
      ),
      child: AnimatedOpacity(
        curve: sn.curve,
        duration: sn.animationDuration,
        opacity: sn.isInitialPhase ? 1 : 0,
        child: Html(
            data:  sn.oneSessionEntity.description,
        ),
      ),
    );
  }

  Widget _buildworkoutLists() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExercisesListView(
          titleColor: AppColors.mansourLightGreenColor,
          itemHeight: 300.h,
          title: Translation.current.warm_up.toUpperCase(),
          items: sn.warmUpExrecises,
          indecatorColor: (index) => index <= sn.warmUpCurrentExrecise
              ? AppColors.mansourDarkGreenColor
              : AppColors.mansourLightGreyColor,
          onTap: (index){
            sn.onVideoTapped(0,index);
          },
        ),
        Gaps.vGap64,
        ExercisesListView(
          titleColor: AppColors.mansourLightGreenColor,
          itemHeight: 300.h,
          title: Translation.current.main_workout,
            items: sn.mainWorkoutExrecises,
          indecatorColor: (index) => index <= sn.mainWorkoutCurrentExrecise
              ? AppColors.mansourDarkGreenColor
              : AppColors.mansourLightGreyColor,
          onTap: (index){
            sn.onVideoTapped(1,index);
          },
        ),
        Gaps.vGap64,
        ExercisesListView(
          titleColor: AppColors.mansourLightGreenColor,
          itemHeight: 300.h,
          title: Translation.current.cool_down,
          items: sn.coolDownExrcises,
          indecatorColor: (index) => index <= sn.coolDownECurrentxrecise
              ? AppColors.mansourDarkGreenColor
              : AppColors.mansourLightGreyColor,
          onTap: (index){
            sn.onVideoTapped(2,index);
          },
        ),
      ],
    );
  }
}
