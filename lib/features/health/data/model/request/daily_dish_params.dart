import 'package:starter_application/core/params/base_params.dart';

class DailyDishParams extends BaseParams {
  String? amountOfCalories , fats,carbs,protein;
  String? dishName, dishImage;
  int? type, dishId, recipeId;
  String? creationTime;

  DailyDishParams({
    this.amountOfCalories,
    this.dishImage,
    this.dishName,
    this.type,
    this.dishId,
    this.recipeId,
    this.protein,
    this.carbs,
    this.fats,
    this.creationTime,
  });

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> res = {};
    if(type != null) res['type'] = type;
    if(dishImage != null) res['dishImage'] = dishImage;
    if(dishName != null) res['dishName'] = dishName;
    if(amountOfCalories != null) res['amountOfCalories'] = amountOfCalories;
    if(dishId != null) res['dishId'] = dishId;
    if(recipeId != null) res['recipeId'] = recipeId;
    if(carbs != null) res['carbs'] = carbs;
    if(fats != null) res['ats'] = fats;
    if(protein != null) res['protein'] = protein;
    if(creationTime != null) res['creationTime'] = creationTime;
    return res;
  }
}
