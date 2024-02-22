import 'package:dartz/dartz.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/features/favorite/data/model/request/get_favorites_params.dart';
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
import 'package:starter_application/features/health/data/model/response/check_health_profile_info.dart';
import 'package:starter_application/features/health/data/model/response/create_daily_food_model.dart';
import 'package:starter_application/features/health/data/model/response/get_all_daily_session_model.dart';
import 'package:starter_application/features/health/data/model/response/get_all_dish_model.dart';
import 'package:starter_application/features/health/data/model/response/get_all_exercies_model.dart';
import 'package:starter_application/features/health/data/model/response/get_all_session_model.dart';
import 'package:starter_application/features/health/data/model/response/get_daily_dish_list_model.dart';
import 'package:starter_application/features/health/data/model/response/get_favorite_dishes_response.dart';
import 'package:starter_application/features/health/data/model/response/get_favorite_recipes_response.dart';
import 'package:starter_application/features/health/data/model/response/get_favorite_sessions.dart';
import 'package:starter_application/features/health/data/model/response/get_food_categories_response.dart';
import 'package:starter_application/features/health/data/model/response/get_health_dashboard_response.dart';
import 'package:starter_application/features/health/data/model/response/get_questions_response.dart';
import 'package:starter_application/features/health/data/model/response/get_recipe_list_model.dart';
import 'package:starter_application/features/health/data/model/response/get_recommended_food.dart';
import 'package:starter_application/features/health/data/model/response/get_recommended_session.dart';
import 'package:starter_application/features/health/data/model/response/health_profile_response.dart';
import 'package:starter_application/features/health/data/model/response/health_result_response_model.dart';
import 'package:starter_application/features/health/data/model/response/image_upload_model.dart';
import 'package:starter_application/features/health/domain/entity/favorite_session_entity.dart';
import 'package:starter_application/features/health/domain/entity/recommended_session_entity.dart';
import '../../../../core/datasources/remote_data_source.dart';

abstract class IHealthRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, FoodCategoriesModel>> getAllCategories(SearchParam params);
  Future<Either<AppErrors, ImageUrlsModel>> uploadImage(ImageParams params);
  Future<Either<AppErrors, DailyDishModel>> createDailyDish(DailyDishParams params);
  Future<Either<AppErrors, DailyDishListModel>> getDailyDishList(DailyDishListParamms params);
  Future<Either<AppErrors, DishesModel>> getDishesByCategory(GetDishListParams params);
  Future<Either<AppErrors, RecipesModel>> getRecipesByCategory(GetDishListParams params);
  Future<Either<AppErrors, ExercisesModel>> getAllExercises(AllExercisesParams params);
  Future<Either<AppErrors, SessionsModel>> getAllSession(AllSessionsParams params);
  Future<Either<AppErrors, DishModel>> getDishById(GetDishParams params);
  Future<Either<AppErrors, HealthProfileModel>> createHealthProfile(HealthProfileParams params);
  Future<Either<AppErrors, EmptyResponse>> answerQuestions(AnswerParams params);
  Future<Either<AppErrors, GetQuestionsModel>> getAllQuestions(NoParams params);
  Future<Either<AppErrors, HealthProfileModel>> updateHealthProfile(HealthProfileParams params);
  Future<Either<AppErrors, FavortieDishListModel>> getFavoriteDishes(NoParams params);
  Future<Either<AppErrors, FavoriteRecipesListModel>> getFavoriteRecipes(NoParams params);
  Future<Either<AppErrors, RecommendedFoodIListModel>> getRecommendedFood(NoParams params);
  Future<Either<AppErrors, DailySessionListModel>> getDailySessions(DateParams params);
  Future<Either<AppErrors, EmptyResponse>> createDailySession(CreateDailySessionParams params);
  Future<Either<AppErrors, FavoriteSessionListModel>> getFavoriteSessions(NoParams params);
  Future<Either<AppErrors, RecommendedSessionListModel>> getRecommendedSession(NoParams params);
  Future<Either<AppErrors, HealthProfileModel>> updateGoal(UpdateGoalParams params);
  Future<Either<AppErrors, EmptyResponse>> updateDailyWater(UpdateDailyWaterParams params);
  Future<Either<AppErrors, HealthDashboardModel>> getHealthDashboard(DateParams params);
  Future<Either<AppErrors, CheckHealthProfileModel>> checkHealthProfile(NoParams params);
  Future<Either<AppErrors, HealthResultResponseModel>> getUserResults(NoParams params);
  Future<Either<AppErrors, EmptyResponse>> updateDailySteps(UpdateDailyStepsParams params);





}
