import 'package:starter_application/core/params/base_params.dart';

class GetDishListParams extends BaseParams {
  int? maxResultCount;
  int? FoodCategoryId;

  GetDishListParams({
    this.maxResultCount,
    this.FoodCategoryId,
  });

  @override
  Map<String, dynamic> toMap() {
    if(maxResultCount != null && FoodCategoryId != null){
      return {
        'MaxResultCount': maxResultCount,
        'FoodCategoryId': FoodCategoryId,
      };
    }
    if(maxResultCount != null){
      return {
        'MaxResultCount': maxResultCount,
      };
    }
    if(FoodCategoryId != null){
      return {
        'FoodCategoryId': FoodCategoryId,
      };
    }
    return {};

  }
}
