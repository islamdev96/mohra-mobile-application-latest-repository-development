import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/common/provider/session_data.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/ui/mansour/wheel_picker.dart';
import 'package:starter_application/features/health/data/model/request/create_daily_session_params.dart';
import 'package:starter_application/features/health/data/model/request/daily_dish_params.dart';
import 'package:starter_application/features/health/domain/entity/recommended_food_entity.dart';
import 'package:starter_application/features/health/domain/entity/recommended_session_entity.dart';
import 'package:starter_application/features/health/domain/entity/session_entity.dart';
import 'package:starter_application/features/health/presentation/screen/browse_exrecise_screen.dart';
import 'package:starter_application/features/health/presentation/screen/create_calories/create_calories_screen.dart';
import 'package:starter_application/features/health/presentation/screen/favorite_session_screen.dart';
import 'package:starter_application/features/health/presentation/screen/food_categories_screen.dart';
import 'package:starter_application/features/health/presentation/screen/food_details_screen.dart';
import 'package:starter_application/features/health/presentation/screen/food_favorite_screen.dart';
import 'package:starter_application/features/health/presentation/screen/health_main_screen.dart';
import 'package:starter_application/features/health/presentation/screen/workout_details_screen.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/health/presentation/widget/exercise_add_bottomsheet.dart';
import 'package:starter_application/features/health/presentation/widget/exrecise/health_list_view.dart';
import 'package:starter_application/features/health/presentation/widget/health_add_bottomsheet.dart';
import 'package:starter_application/features/home/presentation/screen/app_main_screen.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/app_main_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

class HealthMainScreenNotifier extends ScreenNotifier {
  late BuildContext context;
  static const NAV_ICON = 0;
  static const NAV_TITLE = 1;
  late PageController controller;
  int recommendedFoodType = 0;
  int _selectedIndex = 0;
  final healthCubit = HealthCubit();
  late RecommendedFoodIListEntity recommendedFoodIListEntity;
  late RecommendedFoodItemEntity recommendedFoodItemEntity;
  late RecommendedSessionListEntity recommendedSessionListEntity;
  late OneSessionEntity oneSessionEntity;
  List<Map<int, dynamic>> navItems = [
    {
      NAV_ICON: AppConstants.SVG_HOME,
      NAV_TITLE: "",
    },
    {
      NAV_ICON: AppConstants.SVG_DUMBLES,
      NAV_TITLE: "",
    },
    {
      NAV_ICON: AppConstants.SVG_PLUS,
      NAV_TITLE: "",
    },
    {
      NAV_ICON: AppConstants.SVG_FOOD,
      NAV_TITLE: "",
    },
    {
      NAV_ICON: AppConstants.SVG_PERSON,
      NAV_TITLE: "",
    },
  ];

  /// Getters and Setters
  /// If index > 1 we add 1 to ignore the add button
  int get selectedIndex =>
      this._selectedIndex > 1 ? this._selectedIndex + 1 : this._selectedIndex;

  set selectedIndex(int value) {
    print(value);
    this._selectedIndex = value;
    notifyListeners();
  }

  /// Methods
  @override
  void closeNotifier() {
    controller.dispose();
  }

  void onBottomNavigationTap(
    int value, {
    required List<Widget> items,
    required double itemRadius,
    required double centerRadius,
  }) {
    if (value != 2) {
      int newValue = value > 1 ? value - 1 : value;

      if (value == 0 && selectedIndex == 0) {
        onHomeDoubleTap();
      } else {
        controller.jumpToPage(
          newValue,
        );
        selectedIndex = newValue;
      }
    }

    /// On Add button tap
    else {
      onAddButtonTap(
        centerRadius: centerRadius,
        itemRadius: itemRadius,
        items: items,
      );
    }
  }

  void onHomeDoubleTap() {
    context.read<AppMainScreenNotifier>().controller!.jumpTo(0);
    Nav.pop();
  }

  initController(int index) {
    controller = PageController(initialPage: index);
    this._selectedIndex = index;
  }

  void onAddButtonTap({
    required List<Widget> items,
    required double itemRadius,
    required double centerRadius,
  }) {
    showWheelPickerDialog(
      context,
      centerRadius: centerRadius,
      itemRadius: itemRadius,
      items: items,
    );
  }

  void onAddBreakfastTap() {
    this.getRecommendedFood();
    recommendedFoodType = 0;
    showHealthAddBottomSheet(
        sn: this,
        context: context,
        title: Translation.current.add_breakfast,
        searchHint: Translation.current.search_food,
        recommendedItems: [
          HealthItem(
            name: "Chese & Mushroom omlette",
            description: "2300 kcal",
            image: "assets/images/png/temp/food_category.png",
          ),
        ],
        actionsNames: [
          Translation.current.favorite,
          Translation.current.browse_food,
          Translation.current.create_new,
        ],
        onRecommendedItemTap: (i) => Nav.to(
              FoodDetailsScreen.routeName,
            ),
        actionsIcons: [
          AppConstants.SVG_HEART_FILL,
          AppConstants.SVG_DINNER,
          AppConstants.SVG_PLUS_CIRCLE,
        ],
        actionsCallbacks: [
          () => Nav.to(
                FoodFavoriteScreen.routeName,
                arguments: 0,
              ),
          () => Nav.to(
                FoodCategoriesScreen.routeName,
                arguments: 0,
              ),
          () => Nav.to(
                CreateCaloriesScreen.routeName,
                arguments: 0,
              ),
        ],
        onRefreshTap: onRefreshFood,
        onSelectTap: onSelectFoodTap);
  }

  void onAddDinnertTap() {
    this.getRecommendedFood();
    recommendedFoodType = 1;
    showHealthAddBottomSheet(
        sn: this,
        context: context,
        title: Translation.current.add_dinner,
        searchHint: Translation.current.search_food,
        recommendedItems: [
          HealthItem(
            name: "Chese & Mushroom omlette",
            description: "2300 kcal",
            image: "assets/images/png/temp/food_category.png",
          ),
        ],
        actionsNames: [
          Translation.current.favorite,
          Translation.current.browse_food,
          Translation.current.create_new,
        ],
        actionsIcons: [
          AppConstants.SVG_HEART_FILL,
          AppConstants.SVG_DINNER,
          AppConstants.SVG_PLUS_CIRCLE,
        ],
        onRecommendedItemTap: (i) => Nav.to(
              FoodDetailsScreen.routeName,
            ),
        actionsCallbacks: [
          () => Nav.to(
                FoodFavoriteScreen.routeName,
                arguments: 1,
              ),
          () => Nav.to(
                FoodCategoriesScreen.routeName,
                arguments: 1,
              ),
          () => Nav.to(
                CreateCaloriesScreen.routeName,
                arguments: 1,
              ),
        ],
        onRefreshTap: onRefreshFood,
        onSelectTap: onSelectFoodTap);
  }

  void onAddLunchTap() {
    this.getRecommendedFood();
    recommendedFoodType = 2;
    showHealthAddBottomSheet(
        sn: this,
        context: context,
        title: Translation.current.add_lunch,
        searchHint: Translation.current.search_food,
        recommendedItems: [
          HealthItem(
            name: "Chese & Mushroom omlette",
            description: "2300 kcal",
            image: "assets/images/png/temp/food_category.png",
          ),
        ],
        onRecommendedItemTap: (i) => Nav.to(
              FoodDetailsScreen.routeName,
            ),
        actionsNames: [
          Translation.current.favorite,
          Translation.current.browse_food,
          Translation.current.create_new,
        ],
        actionsIcons: [
          AppConstants.SVG_HEART_FILL,
          AppConstants.SVG_DINNER,
          AppConstants.SVG_PLUS_CIRCLE,
        ],
        actionsCallbacks: [
          () => Nav.to(
                FoodFavoriteScreen.routeName,
                arguments: 2,
              ),
          () => Nav.to(
                FoodCategoriesScreen.routeName,
                arguments: 2,
              ),
          () => Nav.to(
                CreateCaloriesScreen.routeName,
                arguments: 2,
              ),
        ],
        onRefreshTap: onRefreshFood,
        onSelectTap: onSelectFoodTap);
  }

  void onAddSnackTap() {
    this.getRecommendedFood();
    recommendedFoodType = 3;
    showHealthAddBottomSheet(
        sn: this,
        context: context,
        title: Translation.current.add_snack,
        searchHint: Translation.current.search_food,
        recommendedItems: [
          HealthItem(
            name: "Chese & Mushroom omlette",
            description: "2300 kcal",
            image: "assets/images/png/temp/food_category.png",
          ),
        ],
        onRecommendedItemTap: (i) => Nav.to(
              FoodDetailsScreen.routeName,
            ),
        actionsNames: [
          Translation.current.favorite,
          Translation.current.browse_food,
          Translation.current.create_new,
        ],
        actionsIcons: [
          AppConstants.SVG_HEART_FILL,
          AppConstants.SVG_DINNER,
          AppConstants.SVG_PLUS_CIRCLE,
        ],
        actionsCallbacks: [
          () => Nav.to(
                FoodFavoriteScreen.routeName,
                arguments: 3,
              ),
          () => Nav.to(
                FoodCategoriesScreen.routeName,
                arguments: 3,
              ),
          () => Nav.to(
                CreateCaloriesScreen.routeName,
                arguments: 3,
              ),
        ],
        onRefreshTap: onRefreshFood,
        onSelectTap: onSelectFoodTap);
  }

  void onAddExrciseTap() {
    getRecommendedSession();
    showExerciseAddBottomSheet(
      sn: this,
      context: context,
      title: Translation.current.add_exercise,
      searchHint: Translation.current.search_exercise,
      recommendedItems: [
        HealthItem(
          name: "Full Body Challenge",
          description: "2300 kcal | 12 min",
          image: "assets/images/png/temp/exrcise.png",
        ),
      ],
      onRecommendedItemTap: (i) => Nav.to(
        WorkoutDetailsScreen.routeName,
      ),
      actionsNames: [
        Translation.current.favorite,
        Translation.current.browse_exercise,
      ],
      actionsIcons: [
        AppConstants.SVG_HEART_FILL,
        AppConstants.SVG_DUMBELL_FILL,
      ],
      actionsCallbacks: [
        () => Nav.to(FavoriteSessionScreen.routeName),
        () => Nav.to(BrowseExreciseScreen.routeName),
      ],
      onRefreshTap: onRefreshSession,
      onSelectTap: onSelectSessionTap,
    );
  }

  // for recomended food
  getRecommendedFood() {
    healthCubit.getRecommendedFood(NoParams());
  }

  onRecommendedFoodLoaded(
      RecommendedFoodIListEntity recommendedFoodIListEntity) {
    this.recommendedFoodIListEntity = recommendedFoodIListEntity;
    generateRandomFood();
    notifyListeners();
  }

  void onRefreshFood() {
    generateRandomFood();
    notifyListeners();
  }

  onSelectFoodTap() {
    DailyDishParams params = DailyDishParams(
      type: recommendedFoodType,
      dishId: this.recommendedFoodItemEntity.id,
    );
    healthCubit.createDailyDish(params);
    notifyListeners();
  }

  onDailyDisheat() {
    notifyListeners();
    Nav.toAndPopUntil(HealthMainScreen.routeName, AppMainScreen.routeName,
        arguments: BottomNavBarInitIndex(index: 2));
  }

  generateRandomFood() {
    this.recommendedFoodItemEntity = this
        .recommendedFoodIListEntity
        .items[Random().nextInt(recommendedFoodIListEntity.items.length)];
  }

  //for recommended session
  getRecommendedSession() {
    healthCubit.getRecommendedSessions(NoParams());
  }

  onRecommendedSessionLoaded(
      RecommendedSessionListEntity recommendedSessionListEntity) {
    this.recommendedSessionListEntity = recommendedSessionListEntity;
    generateRandomExercise();
    notifyListeners();
  }

  void onRefreshSession() {
    generateRandomExercise();
    notifyListeners();
  }

  onSelectSessionTap() {
    DateTime dateTime = DateTime.now();

    CreateDailySessionParams params = CreateDailySessionParams(
        exerciseSessionId: this.oneSessionEntity.id!,
        creationTime: DateTime(
                dateTime.year,
                dateTime.month,
                Provider.of<SessionData>(context, listen: false).dayAdded ??
                    dateTime.day)
            .toIso8601String());
    healthCubit.createDailySession(params);
    notifyListeners();
  }

  onDailySessionCreated() {
    notifyListeners();
    Nav.toAndPopUntil(HealthMainScreen.routeName, AppMainScreen.routeName,
        arguments: BottomNavBarInitIndex(index: 1));
  }

  generateRandomExercise() {
    this.oneSessionEntity = this
        .recommendedSessionListEntity
        .items[Random().nextInt(recommendedSessionListEntity.items.length)];
  }

  initIndex(int index) {
    this._selectedIndex = index;
    initController(2);
  }
}

class BottomNavBarInitIndex {
  int index;

  BottomNavBarInitIndex({
    this.index = 0,
  });
}
