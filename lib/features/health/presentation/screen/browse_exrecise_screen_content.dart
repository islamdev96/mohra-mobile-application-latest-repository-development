import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/search_textfield.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/health/presentation/screen/workout_details_screen.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/health/presentation/widget/browse_exrecise/workout_recommendations.dart';
import 'package:starter_application/features/health/presentation/widget/health_item_card.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/browse_exrecise_screen_notifier.dart';

class BrowseExreciseScreenContent extends StatefulWidget {
  @override
  State<BrowseExreciseScreenContent> createState() =>
      _BrowseExreciseScreenContentState();
}

class _BrowseExreciseScreenContentState
    extends State<BrowseExreciseScreenContent> {
  late BrowseExreciseScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<BrowseExreciseScreenNotifier>(context);
    sn.context = context;
    return SingleChildScrollView(
      child: BlocConsumer<HealthCubit, HealthState>(
        bloc: sn.healthCubit,
        listener: (context, state) {
          if (state is SessionListLoaded) {
            sn.onLSessionLoaded(state.sessionsEntity);
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
            answerQuestion: (s) => const ScreenNotImplementedError(),
            questionAnswered: (s) => const ScreenNotImplementedError(),
            createProfile: (s) => const ScreenNotImplementedError(),
            profileCreated: (s) => const ScreenNotImplementedError(),
            questionLoaded: (s) => const ScreenNotImplementedError(),
            dishLoaded: (s) => const ScreenNotImplementedError(),
            recipeLoaded: (s) => const ScreenNotImplementedError(),
            recipeListLoaded: (s) => const ScreenNotImplementedError(),
            healthInitState: (s) => WaitingWidget(),
            healthLoadingState: (s) => WaitingWidget(),
            createDailyDish: (s) => const ScreenNotImplementedError(),
            uploadImage: (s) => const ScreenNotImplementedError(),
            dailyDishListLoaded: (s) => const ScreenNotImplementedError(),
            dailyDishCreated: (s) => const ScreenNotImplementedError(),
            dishListLoaded: (s) => const ScreenNotImplementedError(),
            healthErrorState: (s) => ErrorScreenWidget(
              error: s.error,
              callback: s.callback,
            ),
            foodCategoriesLoaded: (s) => const ScreenNotImplementedError(),
            sessionListLoaded: (s) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.vGap32,
                Padding(
                  padding: AppConstants.screenPadding,
                  child: SearchTextField(
                    textKey: GlobalKey(),
                    controller: TextEditingController(),
                    focusNode: FocusNode(),
                    backgroundColor: AppColors.mansourLightGreyColor_4,
                    iconColor: AppColors.mansourLightGreyColor_8,
                    hint: Translation.current.search_exercise,
                    onFieldSubmitted: (value) {
                      sn.searchForSession();
                    },
                    onChange: (value) {
                      sn.searchText = value;
                    },
                  ),
                ),
                Gaps.vGap64,
                _buildCard(
                  title: Translation.current.workout_reccommendation,
                  child: CarouselSlider.builder(
                      itemCount: sn.sliderList.length,
                      itemBuilder: (context, item, index) {
                        return WorkoutRecommendationsCard(
                          heroTag: 'hero${sn.sliderList[item].id}',
                          title: '${sn.sliderList[item].title}',
                          imageUrl: "${sn.sliderList[item].imageUrl}",
                          calories: sn.sliderList[item].amountOfCalories,
                          time: sn.sliderList[item].timeInMinutes,
                          onTap: () {
                            Nav.to(WorkoutDetailsScreen.routeName,
                                arguments: sn.sliderList[item]);
                          },
                        );
                      },
                      options: CarouselOptions(
                        pauseAutoPlayOnTouch: true,
                        height: 550.h,
                        aspectRatio: 9 / 16,
                        viewportFraction: 0.95,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      )),
                ),
                /*Gaps.vGap64,
          _buildCard(
            title: "Other Workout",
            child: OtherWorkouts(
              height: 550.h,
              itemWidth: 400.w,
            ),
          ),*/
                Gaps.vGap64,
                Padding(
                  padding: AppConstants.screenPadding,
                  child: Text(
                    Translation.current.exercise_library,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 50.sp,
                    ),
                  ),
                ),
                Gaps.vGap32,
                ListView.separated(
                  itemCount: sn.sessionsEntity.sessionList.length,
                  padding: AppConstants.screenPadding,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return HealthItemCard(
                      height: 300.h,
                      image: '${sn.sessionsEntity.sessionList[index].imageUrl}',
                      name: '${sn.sessionsEntity.sessionList[index].title}',
                      description:
                          '${sn.sessionsEntity.sessionList[index].amountOfCalories} kcal | ${sn.sessionsEntity.sessionList[index].timeInMinutes}  minute',
                      onTap: () {
                        Nav.to(WorkoutDetailsScreen.routeName,
                            arguments: sn.sessionsEntity.sessionList[index]);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Gaps.vGap32;
                  },
                ),
              ],
            ),
              orElse: ()=>Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.vGap32,
                  Padding(
                    padding: AppConstants.screenPadding,
                    child: SearchTextField(
                      textKey: GlobalKey(),
                      controller: TextEditingController(),
                      focusNode: FocusNode(),
                      backgroundColor: AppColors.mansourLightGreyColor_4,
                      iconColor: AppColors.mansourLightGreyColor_8,
                      hint: Translation.current.search_exercise,
                      onFieldSubmitted: (value) {
                        sn.searchForSession();
                      },
                      onChange: (value) {
                        sn.searchText = value;
                      },
                    ),
                  ),
                  Gaps.vGap64,
                  _buildCard(
                    title: Translation.current.workout_reccommendation,
                    child: CarouselSlider.builder(
                        itemCount: sn.sliderList.length,
                        itemBuilder: (context, item, index) {
                          return WorkoutRecommendationsCard(
                            heroTag: 'hero${sn.sliderList[item].id}',
                            title: '${sn.sliderList[item].title}',
                            imageUrl: "${sn.sliderList[item].imageUrl}",
                            calories: sn.sliderList[item].amountOfCalories,
                            time: sn.sliderList[item].timeInMinutes,
                            onTap: () {
                              Nav.to(WorkoutDetailsScreen.routeName,
                                  arguments: sn.sliderList[item]);
                            },
                          );
                        },
                        options: CarouselOptions(
                          pauseAutoPlayOnTouch: true,
                          height: 550.h,
                          aspectRatio: 9 / 16,
                          viewportFraction: 0.95,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        )),
                  ),
                  /*Gaps.vGap64,
          _buildCard(
            title: "Other Workout",
            child: OtherWorkouts(
              height: 550.h,
              itemWidth: 400.w,
            ),
          ),*/
                  Gaps.vGap64,
                  Padding(
                    padding: AppConstants.screenPadding,
                    child: Text(
                      Translation.current.exercise_library,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 50.sp,
                      ),
                    ),
                  ),
                  Gaps.vGap32,
                  ListView.separated(
                    itemCount: sn.sessionsEntity.sessionList.length,
                    padding: AppConstants.screenPadding,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return HealthItemCard(
                        height: 300.h,
                        image: '${sn.sessionsEntity.sessionList[index].imageUrl}',
                        name: '${sn.sessionsEntity.sessionList[index].title}',
                        description:
                        '${sn.sessionsEntity.sessionList[index].amountOfCalories} kcal | ${sn.sessionsEntity.sessionList[index].timeInMinutes}  minute',
                        onTap: () {
                          Nav.to(WorkoutDetailsScreen.routeName,
                              arguments: sn.sessionsEntity.sessionList[index]);
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Gaps.vGap32;
                    },
                  ),
                ],
              )
          );
        },
      ),
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppConstants.screenPadding,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 50.sp,
            ),
          ),
        ),
        Gaps.vGap32,
        child,
      ],
    );
  }
}
