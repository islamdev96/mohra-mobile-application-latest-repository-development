import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/health/domain/entity/recipe_list_entity.dart';

class FavoriteRecipesListEntity extends BaseEntity {
  FavoriteRecipesListEntity({
    required this.totalCount,
    required this.items,
  });

  int totalCount;
  List<FavoriteRecipeEntity> items;

  @override
  // TODO: implement props
  List<Object?> get props => [];


}

class FavoriteRecipeEntity extends BaseEntity {
  FavoriteRecipeEntity({
    required this.recipeId,
    required this.recipe,
    required this.id,
    required this.clientId,
  });

  int recipeId;
  RecipeEntity recipe;
  int id;
  int clientId;

  @override
  // TODO: implement props
  List<Object?> get props => [];



}