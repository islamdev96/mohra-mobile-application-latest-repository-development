import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/health/presentation/screen/workout_details_screen.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/health/presentation/widget/health_item_card.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/favorite_session_screen_notifier.dart';

class FavoriteSessionScreenContent extends StatelessWidget {
  late FavoriteSessionScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<FavoriteSessionScreenNotifier>(context);
    sn.context = context;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.vGap32,
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
          BlocConsumer<HealthCubit, HealthState>(
            bloc: sn.healthCubit,
            listener: (context, state) {
              if (state is FavoriteSessionsLoaded) {
                sn.onFavoriteSessionsLoaded(state.favoriteSessionListEntity);
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
                sessionListLoaded: (s) => const ScreenNotImplementedError(),
                favoriteSessionsLoaded: (s) => ListView.separated(
                  itemCount: sn.favoriteSessionListEntity.items.length,
                  padding: AppConstants.screenPadding,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return HealthItemCard(
                      height: 300.h,
                      image:
                          '${sn.favoriteSessionListEntity.items[index].session.imageUrl}',
                      name:
                          '${sn.favoriteSessionListEntity.items[index].session.title}',
                      description:
                          '${sn.favoriteSessionListEntity.items[index].session.amountOfCalories} kcal | ${sn.favoriteSessionListEntity.items[index].session.timeInMinutes}  minute',
                      onTap: () {
                        sn.favoriteSessionListEntity.items[index].session
                                .favoriteId =
                            sn.favoriteSessionListEntity.items[index].id;
                        sn.favoriteSessionListEntity.items[index].session
                            .isFavorite = true;
                        Nav.to(WorkoutDetailsScreen.routeName,
                            arguments: sn.favoriteSessionListEntity.items[index]
                                .session);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Gaps.vGap32;
                  },
                ),
                orElse: ()=>ListView.separated(
                  itemCount: sn.favoriteSessionListEntity.items.length,
                  padding: AppConstants.screenPadding,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return HealthItemCard(
                      height: 300.h,
                      image:
                      '${sn.favoriteSessionListEntity.items[index].session.imageUrl}',
                      name:
                      '${sn.favoriteSessionListEntity.items[index].session.title}',
                      description:
                      '${sn.favoriteSessionListEntity.items[index].session.amountOfCalories} kcal | ${sn.favoriteSessionListEntity.items[index].session.timeInMinutes}  minute',
                      onTap: () {
                        sn.favoriteSessionListEntity.items[index].session
                            .favoriteId =
                            sn.favoriteSessionListEntity.items[index].id;
                        sn.favoriteSessionListEntity.items[index].session
                            .isFavorite = true;
                        Nav.to(WorkoutDetailsScreen.routeName,
                            arguments: sn.favoriteSessionListEntity.items[index]
                                .session);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Gaps.vGap32;
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
