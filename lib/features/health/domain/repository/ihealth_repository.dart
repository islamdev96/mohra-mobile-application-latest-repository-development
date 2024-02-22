import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/health/data/model/request/all_exercises_params.dart';
import 'package:starter_application/features/health/data/model/request/all_sessions_params.dart';
import 'package:starter_application/features/health/data/model/request/answer_params.dart';
import 'package:starter_application/features/health/data/model/request/create_daily_session_params.dart';
import 'package:starter_application/features/health/data/model/request/daily_dish_list_params.dart';
import 'package:starter_application/features/health/data/model/request/daily_dish_params.dart';
import 'package:starter_application/features/health/data/model/request/date_params.dart';
import 'package:starter_application/features/health/data/model/request/get_dish_list_params.dart';
import 'package:starter_application/features/health/data/model/request/get_dish_params.dart';
import 'package:starter_application/features/health/data/model/request/health_profile_params.dart';
import 'package:starter_application/features/health/data/model/request/image_params.dart';
import 'package:starter_application/features/health/data/model/request/search_params.dart';
import 'package:starter_application/features/health/data/model/request/update_daily_steps_request_model.dart';
import 'package:starter_application/features/health/data/model/request/update_daily_water.dart';
import 'package:starter_application/features/health/data/model/request/update_goal.dart';
import 'package:starter_application/features/health/data/model/response/get_questions_response.dart';
import 'package:starter_application/features/health/domain/entity/check_health_profile_entity.dart';
import 'package:starter_application/features/health/domain/entity/daily_dish_entity.dart';
import 'package:starter_application/features/health/domain/entity/daily_session_entity.dart';
import 'package:starter_application/features/health/domain/entity/dishes_list_entity.dart';
import 'package:starter_application/features/health/domain/entity/exercises_entity.dart';
import 'package:starter_application/features/health/domain/entity/favorite_dish_entity.dart';
import 'package:starter_application/features/health/domain/entity/favorite_recipe_entity.dart';
import 'package:starter_application/features/health/domain/entity/favorite_session_entity.dart';
import 'package:starter_application/features/health/domain/entity/food_categories_entity.dart';
import 'package:starter_application/features/health/domain/entity/health_dashboard_entity.dart';
import 'package:starter_application/features/health/domain/entity/health_profile_entity.dart';
import 'package:starter_application/features/health/domain/entity/health_result_response_entity.dart';
import 'package:starter_application/features/health/domain/entity/image_urls_entity.dart';
import 'package:starter_application/features/health/domain/entity/question_entity.dart';
import 'package:starter_application/features/health/domain/entity/recipe_list_entity.dart';
import 'package:starter_application/features/health/domain/entity/recommended_food_entity.dart';
import 'package:starter_application/features/health/domain/entity/recommended_session_entity.dart';
import 'package:starter_application/features/health/domain/entity/session_entity.dart';

import '../../../../core/repositories/repository.dart';

abstract class IHealthRepository extends Repository {

  Future<Result<AppErrors, FoodCategoriesEntity>> getFoodCategory(SearchParam params);
  Future<Result<AppErrors, ImageUrlsEntity>> uploadImage(ImageParams params);
  Future<Result<AppErrors, DailyDishEntity>> createDailyDish(DailyDishParams params);
  Future<Result<AppErrors, DailyDishListEntity>> getDailyDishList(DailyDishListParamms params);
  Future<Result<AppErrors, DishesEntity>> getDishesByCategory(GetDishListParams params);
  Future<Result<AppErrors, RecipesEntity>> getRecipesByCategory(GetDishListParams params);
  Future<Result<AppErrors, ExercisesEntity>> getAllExercises(AllExercisesParams params);
  Future<Result<AppErrors, SessionsEntity>> getAllSessions(AllSessionsParams params);
  Future<Result<AppErrors, DishEntity>> getDishById(GetDishParams params);
  Future<Result<AppErrors, HealthProfileEntity>> createHealthProfile(HealthProfileParams params);
  Future<Result<AppErrors, QuestionsEntity>> getAllQuestions(NoParams params);
  Future<Result<AppErrors, EmptyResponse>> answerQuestion(AnswerParams params);
  Future<Result<AppErrors, HealthProfileEntity>> updateHealthProfile(HealthProfileParams params);
  Future<Result<AppErrors, FavortieDishListEntity>> getFavoriteDishes(NoParams params);
  Future<Result<AppErrors, FavoriteRecipesListEntity>> getFavoriteRecipes(NoParams params);
  Future<Result<AppErrors, FavoriteSessionListEntity>> getFavoriteSessions(NoParams params);
  Future<Result<AppErrors, RecommendedFoodIListEntity>> getRecommendedFood(NoParams params);
  Future<Result<AppErrors, DailySessionListEntity>> getDailySessions(DateParams params);
  Future<Result<AppErrors, EmptyResponse>> createDailySession(CreateDailySessionParams params);
  Future<Result<AppErrors, RecommendedSessionListEntity>> getRecommendedSession(NoParams params);
  Future<Result<AppErrors, EmptyResponse>> updateDailyWater(UpdateDailyWaterParams params);
  Future<Result<AppErrors, HealthProfileEntity>> updateGoal(UpdateGoalParams params);
  Future<Result<AppErrors, HealthDashboardEntity>> getHealthDashboard(DateParams params);
  Future<Result<AppErrors, CheckHealthProfileEntity>> checkHealthProfile(NoParams params);
  Future<Result<AppErrors, HealthResultResponseEntity>> getUserResults(NoParams params);
  Future<Result<AppErrors, EmptyResponse>> updateDailySteps(UpdateDailyStepsParams params);


}

