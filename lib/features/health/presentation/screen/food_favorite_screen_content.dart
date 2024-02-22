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
import 'package:starter_application/features/health/presentation/state_m/provider/food_favorite_screen_notifier.dart';
import 'package:starter_application/features/health/presentation/widget/dish_item_card.dart';
import 'package:starter_application/features/health/presentation/widget/recipe_item_card.dart';
import 'package:starter_application/generated/l10n.dart';

class FoodFavoriteScreenContent extends StatefulWidget {
  @override
  State<FoodFavoriteScreenContent> createState() =>
      _FoodFavoriteScreenContentState();
}

class _FoodFavoriteScreenContentState extends State<FoodFavoriteScreenContent>
    with SingleTickerProviderStateMixin {
  late FoodFavoriteScreenNotifier sn;
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
    sn = Provider.of<FoodFavoriteScreenNotifier>(context);
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
                    if (state is FavoriteDishesLoaded) {
                      sn.onDishedListLoaded(state.favortieDishListEntity);
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
                      dailyWaterUpdated: (s) =>
                          const ScreenNotImplementedError(),
                      goalUpdated: (s) => const ScreenNotImplementedError(),
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
                      dishListLoaded: (s) => const ScreenNotImplementedError(),
                      favoriteRecipesLoaded: (s) =>
                          const ScreenNotImplementedError(),
                      favoriteDishesLoaded: (s) => sn.dishesEntity.items.isEmpty
                          ? ErrorScreenWidget(
                              error: errorWidget.AppErrors.customError(
                                message: Translation.current.no_favorite_dish,
                              ),
                              callback: () {},
                            )
                          : ListView.separated(
                              itemCount: sn.dishesEntity.items.length,
                              padding: EdgeInsets.only(
                                bottom: 32.h,
                              ),
                              itemBuilder: (context, index) {
                                return DishItemCard(
                                  onTap: () {
                                    sn.dishesEntity.items[index].dish
                                        .isFavorite = true;
                                    sn.dishesEntity.items[index].dish
                                            .favoriteId =
                                        sn.dishesEntity.items[index].id;
                                    Nav.to(FoodDetailsScreen.routeName,
                                        arguments: [
                                          sn.dishesEntity.items[index].dish,
                                          sn.foodType
                                        ]);
                                  },
                                  dishEntity: sn.dishesEntity.items[index].dish,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 60.h,
                                );
                              },
                            ),
                        orElse: ()=>  sn.dishesEntity.items.isEmpty
                            ? ErrorScreenWidget(
                          error: errorWidget.AppErrors.customError(
                            message: Translation.current.no_favorite_dish,
                          ),
                          callback: () {},
                        )
                            : ListView.separated(
                          itemCount: sn.dishesEntity.items.length,
                          padding: EdgeInsets.only(
                            bottom: 32.h,
                          ),
                          itemBuilder: (context, index) {
                            return DishItemCard(
                              onTap: () {
                                sn.dishesEntity.items[index].dish
                                    .isFavorite = true;
                                sn.dishesEntity.items[index].dish
                                    .favoriteId =
                                    sn.dishesEntity.items[index].id;
                                Nav.to(FoodDetailsScreen.routeName,
                                    arguments: [
                                      sn.dishesEntity.items[index].dish,
                                      sn.foodType
                                    ]);
                              },
                              dishEntity: sn.dishesEntity.items[index].dish,
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
                    if (state is FavoriteRecipesLoaded) {
                      sn.onRecipeListLoaded(state.favoriteRecipesListEntity);
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
                      dailySessionCreated: (s) =>
                          const ScreenNotImplementedError(),
                      favoriteSessionsLoaded: (s) =>
                          const ScreenNotImplementedError(),
                      dailySessionsLoaded: (s) =>
                          const ScreenNotImplementedError(),
                      recommendedFoodLoaded: (s) =>
                          const ScreenNotImplementedError(),
                      favoriteDishesLoaded: (s) =>
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
                      recipeListLoaded: (s) =>
                          const ScreenNotImplementedError(),
                      favoriteRecipesLoaded: (s) => sn
                              .recipesEntity.items.isEmpty
                          ? ErrorScreenWidget(
                              error: errorWidget.AppErrors.customError(
                                message: Translation.current.no_favorite_dish,
                              ),
                              callback: () {},
                            )
                          : ListView.separated(
                              itemCount: sn.recipesEntity.items.length,
                              padding: EdgeInsets.only(
                                bottom: 32.h,
                              ),
                              itemBuilder: (context, index) {
                                return RecipeItemCard(
                                  onTap: () {
                                    sn.recipesEntity.items[index].recipe
                                            .favoriteId =
                                        sn.recipesEntity.items[index].id;
                                    sn.recipesEntity.items[index].recipe
                                        .isFavorite = true;
                                    Nav.to(ReciepeDetailsScreen.routeName,
                                        arguments: [
                                          sn.recipesEntity.items[index].recipe,
                                          sn.foodType
                                        ]);
                                  },
                                  recipeEntity:
                                      sn.recipesEntity.items[index].recipe,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 60.h,
                                );
                              },
                            ),
                      orElse: ()=> sn
                          .recipesEntity.items.isEmpty
                          ? ErrorScreenWidget(
                        error: errorWidget.AppErrors.customError(
                          message: Translation.current.no_favorite_dish,
                        ),
                        callback: () {},
                      )
                          : ListView.separated(
                        itemCount: sn.recipesEntity.items.length,
                        padding: EdgeInsets.only(
                          bottom: 32.h,
                        ),
                        itemBuilder: (context, index) {
                          return RecipeItemCard(
                            onTap: () {
                              sn.recipesEntity.items[index].recipe
                                  .favoriteId =
                                  sn.recipesEntity.items[index].id;
                              sn.recipesEntity.items[index].recipe
                                  .isFavorite = true;
                              Nav.to(ReciepeDetailsScreen.routeName,
                                  arguments: [
                                    sn.recipesEntity.items[index].recipe,
                                    sn.foodType
                                  ]);
                            },
                            recipeEntity:
                            sn.recipesEntity.items[index].recipe,
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

/*  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<FoodFavoriteScreenNotifier>(context);
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
              tabs: [
                const Text(
                  "Food",
                ),
                const Text(
                  "Reciepe",
                ),
              ],
            ),
          ),
          Gaps.vGap64,
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                _buildFoodRecipeListView(
                  onTap: sn.onFoodCardTap,
                ),
                _buildFoodRecipeListView(
                  onTap: sn.onReciepeCardTap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }*/

}
