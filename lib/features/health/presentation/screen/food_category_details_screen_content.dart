import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/errors/app_errors.dart' as errorWidget;
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/health/presentation/screen/food_details_screen.dart';
import 'package:starter_application/features/health/presentation/screen/reciepe_details_screen.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/health/presentation/widget/dish_item_card.dart';
import 'package:starter_application/features/health/presentation/widget/recipe_item_card.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/food_category_details_screen_notifier.dart';

class FoodCategoryDetailsScreenContent extends StatefulWidget {
  @override
  State<FoodCategoryDetailsScreenContent> createState() =>
      _FoodCategoryDetailsScreenContentState();
}

class _FoodCategoryDetailsScreenContentState
    extends State<FoodCategoryDetailsScreenContent>
    with SingleTickerProviderStateMixin {
  late FoodCategoryDetailsScreenNotifier sn;
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<FoodCategoryDetailsScreenNotifier>(context);
    sn.context = context;
    return Padding(
      padding: EdgeInsets.only(
        top: 64.h,
        left: AppConstants.hPadding,
        right: AppConstants.hPadding,
      ),
      child: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.topStart,
            child: TabBar(
                onTap: (tapIndex) {
                  switch (tapIndex) {
                    case 0:
                      sn.getDishedByCategory();
                      break;
                    case 1:
                      sn.getRecipesByCategory();
                      break;
                  }
                },
                controller: tabController,
                labelStyle: TextStyle(
                  color: AppColors.mansourLightGreenColor,
                  fontSize: 50.sp,
                  fontWeight: FontWeight.bold,
                ),
                labelColor: AppColors.mansourLightGreenColor,
                unselectedLabelStyle: TextStyle(
                  color: AppColors.accentColorLight,
                  fontSize: 50.sp,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelColor: AppColors.accentColorLight,
                indicatorColor: AppColors.mansourLightGreenColor,
                indicatorWeight: 3,
                labelPadding: EdgeInsetsDirectional.only(
                  bottom: 64.h,
                  end: 90.w,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                isScrollable: true,
                tabs: sn.myTabs),
          ),
          Gaps.vGap64,
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                BlocConsumer<HealthCubit, HealthState>(
                  bloc: sn.healthCubit,
                  listener: (context, state) {
                    if (state is DishListLoaded) {
                      sn.onDishedListLoaded(state.dishesEntity);
                    }
                  },
                  builder: (context, state) {
                    return state.maybeMap(
                      checkHealthProfileDone: (s) =>
                          const ScreenNotImplementedError(),
                      healthDashboardLoaded: (s) =>
                          const ScreenNotImplementedError(),
                      updateDailyWater: (s) =>
                          const ScreenNotImplementedError(),
                      updateGoal: (s) => const ScreenNotImplementedError(),
                      dailyWaterUpdated: (s) =>
                          const ScreenNotImplementedError(),
                      goalUpdated: (s) => const ScreenNotImplementedError(),
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
                      profileUpdated: (s) => const ScreenNotImplementedError(),
                      updateProfile: (s) => const ScreenNotImplementedError(),
                      answerQuestion: (s) => const ScreenNotImplementedError(),
                      questionAnswered: (s) =>
                          const ScreenNotImplementedError(),
                      createProfile: (s) => const ScreenNotImplementedError(),
                      profileCreated: (s) => const ScreenNotImplementedError(),
                      questionLoaded: (s) => const ScreenNotImplementedError(),
                      sessionListLoaded: (s) =>
                          const ScreenNotImplementedError(),
                      dishLoaded: (s) => const ScreenNotImplementedError(),
                      recipeLoaded: (s) => const ScreenNotImplementedError(),
                      healthInitState: (s) => WaitingWidget(),
                      healthLoadingState: (s) => WaitingWidget(),
                      createDailyDish: (s) => const ScreenNotImplementedError(),
                      uploadImage: (s) => const ScreenNotImplementedError(),
                      dailyDishListLoaded: (s) =>
                          const ScreenNotImplementedError(),
                      dailyDishCreated: (s) =>
                          const ScreenNotImplementedError(),
                      healthErrorState: (s) => ErrorScreenWidget(
                        error: s.error,
                        callback: s.callback,
                      ),
                      foodCategoriesLoaded: (s) =>
                          const ScreenNotImplementedError(),
                      recipeListLoaded: (s) =>
                          const ScreenNotImplementedError(),
                      dishListLoaded: (s) => sn.dishesEntity.dishesList.isEmpty
                          ? ErrorScreenWidget(
                              error: errorWidget.AppErrors.customError(
                                message:
                                    Translation.current.no_dish_for_category,
                              ),
                              callback: () {},
                            )
                          : ListView.separated(
                              itemCount: sn.dishesEntity.dishesList.length,
                              padding: EdgeInsets.only(
                                bottom: 32.h,
                              ),
                              itemBuilder: (context, index) {
                                return DishItemCard(
                                  onTap: () {
                                    Nav.to(FoodDetailsScreen.routeName,
                                        arguments: [
                                          sn.dishesEntity.dishesList[index],
                                          sn.foodType
                                        ]);
                                  },
                                  dishEntity: sn.dishesEntity.dishesList[index],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 60.h,
                                );
                              },
                            ),
                      orElse: ()=> sn.dishesEntity.dishesList.isEmpty
                          ? ErrorScreenWidget(
                        error: errorWidget.AppErrors.customError(
                          message:
                          Translation.current.no_dish_for_category,
                        ),
                        callback: () {},
                      )
                          : ListView.separated(
                        itemCount: sn.dishesEntity.dishesList.length,
                        padding: EdgeInsets.only(
                          bottom: 32.h,
                        ),
                        itemBuilder: (context, index) {
                          return DishItemCard(
                            onTap: () {
                              Nav.to(FoodDetailsScreen.routeName,
                                  arguments: [
                                    sn.dishesEntity.dishesList[index],
                                    sn.foodType
                                  ]);
                            },
                            dishEntity: sn.dishesEntity.dishesList[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 60.h,
                          );
                        },
                      )
                    );
                  },
                ),
                BlocConsumer<HealthCubit, HealthState>(
                  bloc: sn.healthCubit,
                  listener: (context, state) {
                    if (state is RecipeListLoaded) {
                      sn.onRecipeListLoaded(state.recipesEntity);
                    }
                  },
                  builder: (context, state) {
                    return state.maybeMap(
                      checkHealthProfileDone: (s) =>
                          const ScreenNotImplementedError(),
                      healthDashboardLoaded: (s) =>
                          const ScreenNotImplementedError(),
                      updateDailyWater: (s) =>
                          const ScreenNotImplementedError(),
                      updateGoal: (s) => const ScreenNotImplementedError(),
                      dailyWaterUpdated: (s) =>
                          const ScreenNotImplementedError(),
                      goalUpdated: (s) => const ScreenNotImplementedError(),
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
                      profileUpdated: (s) => const ScreenNotImplementedError(),
                      updateProfile: (s) => const ScreenNotImplementedError(),
                      answerQuestion: (s) => const ScreenNotImplementedError(),
                      questionAnswered: (s) =>
                          const ScreenNotImplementedError(),
                      createProfile: (s) => const ScreenNotImplementedError(),
                      profileCreated: (s) => const ScreenNotImplementedError(),
                      questionLoaded: (s) => const ScreenNotImplementedError(),
                      sessionListLoaded: (s) =>
                          const ScreenNotImplementedError(),
                      dishLoaded: (s) => const ScreenNotImplementedError(),
                      recipeLoaded: (s) => const ScreenNotImplementedError(),
                      healthInitState: (s) => WaitingWidget(),
                      healthLoadingState: (s) => WaitingWidget(),
                      createDailyDish: (s) => const ScreenNotImplementedError(),
                      uploadImage: (s) => const ScreenNotImplementedError(),
                      dailyDishListLoaded: (s) =>
                          const ScreenNotImplementedError(),
                      dailyDishCreated: (s) =>
                          const ScreenNotImplementedError(),
                      healthErrorState: (s) => ErrorScreenWidget(
                        error: s.error,
                        callback: s.callback,
                      ),
                      foodCategoriesLoaded: (s) =>
                          const ScreenNotImplementedError(),
                      dishListLoaded: (s) => const ScreenNotImplementedError(),
                      recipeListLoaded: (s) => sn
                              .recipesEntity.recipeEntity.isEmpty
                          ? ErrorScreenWidget(
                              error: errorWidget.AppErrors.customError(
                                message:
                                    Translation.current.no_dish_for_category,
                              ),
                              callback: () {},
                            )
                          : ListView.separated(
                              itemCount: sn.recipesEntity.recipeEntity.length,
                              padding: EdgeInsets.only(
                                bottom: 32.h,
                              ),
                              itemBuilder: (context, index) {
                                return RecipeItemCard(
                                  onTap: () {
                                    Nav.to(ReciepeDetailsScreen.routeName,
                                        arguments: [
                                          sn.recipesEntity.recipeEntity[index],
                                          sn.foodType
                                        ]);
                                  },
                                  recipeEntity:
                                      sn.recipesEntity.recipeEntity[index],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 60.h,
                                );
                              },
                            ),
                      orElse: ()=> sn
                          .recipesEntity.recipeEntity.isEmpty
                          ? ErrorScreenWidget(
                        error: errorWidget.AppErrors.customError(
                          message:
                          Translation.current.no_dish_for_category,
                        ),
                        callback: () {},
                      )
                          : ListView.separated(
                        itemCount: sn.recipesEntity.recipeEntity.length,
                        padding: EdgeInsets.only(
                          bottom: 32.h,
                        ),
                        itemBuilder: (context, index) {
                          return RecipeItemCard(
                            onTap: () {
                              Nav.to(ReciepeDetailsScreen.routeName,
                                  arguments: [
                                    sn.recipesEntity.recipeEntity[index],
                                    sn.foodType
                                  ]);
                            },
                            recipeEntity:
                            sn.recipesEntity.recipeEntity[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 60.h,
                          );
                        },
                      )
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
