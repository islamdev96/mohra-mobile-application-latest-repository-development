import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/challenge/presentation/widget/custom_stepper.dart';
import 'package:starter_application/features/favorite/data/model/request/create_favorite_params.dart';
import 'package:starter_application/features/favorite/data/model/request/delete_favorites_params.dart';
import 'package:starter_application/features/favorite/domain/entity/favorite_entity.dart';
import 'package:starter_application/features/favorite/presentation/state_m/cubit/favorite_cubit.dart';
import 'package:starter_application/features/health/data/model/request/daily_dish_params.dart';
import 'package:starter_application/features/health/domain/entity/recipe_list_entity.dart';
import 'package:starter_application/features/health/presentation/logic/nut_model_ui.dart';
import 'package:starter_application/features/health/presentation/logic/sub_nut_model_ui.dart';
import 'package:starter_application/features/health/presentation/screen/health_main_screen.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/health/presentation/state_m/provider/health_main_screen_notifier.dart';
import 'package:starter_application/features/home/presentation/screen/app_main_screen.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';
import 'dart:math' as math;

class ReciepeDetailsScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final RecipeEntity recipeEntity;
  bool _isTrackWalletOn = false;
  final healthCubit = HealthCubit();
  final favoriteCubit = FavoriteCubit();
  double totalValue = 0;

  late int foodType;
  ReciepeDetailsScreenNotifier(this.recipeEntity , this.foodType) {
    generateColorList();
    calcTotalValue();
    generateUiData();
    generateStepList();
  }

  List<NutritionModelUi> nutritionModels = [];
  List<Color> colorList = [];
  List<CustomStep> howToCookSteps = [];

  /// Getters and Setters
  bool get isTrackWalletOn => this._isTrackWalletOn;

  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }

  void onTrackWalletSwitchChange(bool value) {
    _isTrackWalletOn = value;
    notifyListeners();
  }

  generateUiData() {
    nutritionModels.add(NutritionModelUi(
      value: recipeEntity.amountOfCalories,
      totalValue: totalValue,
      title: 'Calories',
      showPercent: false,
    ));
    for (int i = 0; i < recipeEntity.nutritions.length; i++) {
      NutritionModelUi temp = NutritionModelUi(
        value: recipeEntity.nutritions[i].totalWeight,
        totalValue: totalValue,
        title: recipeEntity.nutritions[i].name,
        showPercent: true,
      );
      List<SubNutritionModelUi> tempSub = [];
      recipeEntity.nutritions[i].subNutritions.forEach((element) {
        SubNutritionModelUi subTemp =
            SubNutritionModelUi(element.name, element.totalWeight);
        tempSub.add(subTemp);
      });
      temp.list = [];
      temp.list.addAll(tempSub);
      nutritionModels.add(temp);
    }
    ;
  }

  generateColorList() {
    colorList.add(AppColors.mansourLightGreenColor);
    if (recipeEntity.nutritions.isEmpty) return;
    if (recipeEntity.nutritions.length == 1) {
      colorList.add(AppColors.mansourPurple);
    } else if (recipeEntity.nutritions.length == 2) {
      colorList.add(AppColors.mansourPurple);
      colorList.add(AppColors.mansourLightBlueColor_4);
    } else if (recipeEntity.nutritions.length == 3) {
      colorList.add(AppColors.mansourPurple);
      colorList.add(AppColors.mansourLightBlueColor_4);
      colorList.add(AppColors.mansourLightRed2);
    } else {
      colorList.add(AppColors.mansourPurple);
      colorList.add(AppColors.mansourLightBlueColor_4);
      colorList.add(AppColors.mansourLightRed2);
      for (int i = 0; i < recipeEntity.nutritions.length - 3; i++) {
        Color random = Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(1.0);
        colorList.add(random);
      }
    }
  }

  calcTotalValue() {
    totalValue += recipeEntity.amountOfCalories;
    recipeEntity.nutritions.forEach((element) {
      totalValue += element.totalWeight;
    });
  }

  generateStepList() {
    recipeEntity.steps.sort();
    recipeEntity.steps.forEach((element) {
      CustomStep temp = CustomStep(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.vGap5,
            Text(
              element.description,
              style: TextStyle(
                color: Colors.black,
                fontSize: 40.sp,
              ),
            ),
            if (element.imageUrl != null)
              SizedBox(
                height: 32.h,
              ),
            if (element.imageUrl != null)
              Container(
                height: 0.25.sh,
                width: .80.sw,

                child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: "${element.imageUrl}",
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator.adaptive()),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error)),
              ),
          ],
        ),
        height: 700.h,
         selectedIndecator: ClipOval(
          child: Container(
            height: 80.h,
            width: 80.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.mansourDarkGreenColor,
            ),
            child: Center(
                child: Text(
                  "${element.number}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.sp,
                  ),
                )),
          ),
        ),
        unSelectedIndecator: ClipOval(
          child: Container(
            height: 80.h,
            width: 80.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.mansourDarkGreenColor,
            ),
            child: Center(
                child: Text(
                  "${element.number}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.sp,
                  ),
                )),
          ),
        )  ,
      );
      howToCookSteps.add(temp);
    });
  }

  addToFavorite() {
    CreateFavoriteParams createFavoriteParams =
    CreateFavoriteParams(refId: '${this.recipeEntity.id}', refType: 4);
    favoriteCubit.createFavorites(createFavoriteParams);
  }

  deleteFavorite() {
    DeleteFavoriteParams deleteFavoriteParams = DeleteFavoriteParams(
      id: this.recipeEntity.favoriteId,
      refType: 10//TODO any number
    );
    favoriteCubit.deleteFavorites(deleteFavoriteParams);
  }

  addingDone(FavoriteEntity favoriteEntity) {
    recipeEntity.isFavorite = !recipeEntity.isFavorite;
    recipeEntity.favoriteId = favoriteEntity.id!;
    notifyListeners();
  }

  deleteDone() {
    recipeEntity.isFavorite = !recipeEntity.isFavorite;
    notifyListeners();
  }

  eatFood() {
    print('sdfffffffff');
    print(foodType);
    DailyDishParams params = DailyDishParams(
      type: foodType,
      recipeId: this.recipeEntity.id,
    );
    healthCubit.createDailyDish(params);
    notifyListeners();
  }

  onDailyDisheat(){
    notifyListeners();
    Nav.toAndPopUntil(HealthMainScreen.routeName,AppMainScreen.routeName ,arguments: BottomNavBarInitIndex(index: 2));

  }
}
