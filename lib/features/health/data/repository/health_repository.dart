import 'package:injectable/injectable.dart';
import 'package:starter_application/core/common/extensions/either_error_model_extension.dart';
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
import 'package:starter_application/features/health/data/model/response/health_profile_response.dart';
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
import '../datasource/../../domain/repository/ihealth_repository.dart';
import '../datasource/ihealth_remote.dart';

@Singleton(as: IHealthRepository)
class HealthRepository extends IHealthRepository {
  final IHealthRemoteSource iHealthRemoteSource;

  HealthRepository(this.iHealthRemoteSource);

  @override
  Future<Result<AppErrors, FoodCategoriesEntity>> getFoodCategory(SearchParam params) async {

    final remote = await iHealthRemoteSource.getAllCategories(params);
    return remote.result<FoodCategoriesEntity>();
  }

  @override
  Future<Result<AppErrors, ImageUrlsEntity>> uploadImage(ImageParams params)async {
    final remote = await iHealthRemoteSource.uploadImage(params);
    return remote.result<ImageUrlsEntity>();
  }

  @override
  Future<Result<AppErrors, DailyDishEntity>> createDailyDish(DailyDishParams params) async {
    final remote = await iHealthRemoteSource.createDailyDish(params);
    return remote.result<DailyDishEntity>();
  }

  @override
  Future<Result<AppErrors, DailyDishListEntity>> getDailyDishList(DailyDishListParamms params) async {
    final remote = await iHealthRemoteSource.getDailyDishList(params);
    return remote.result<DailyDishListEntity>();
  }



  @override
  Future<Result<AppErrors, RecipesEntity>> getRecipesByCategory(GetDishListParams params) async {
    final remote = await iHealthRemoteSource.getRecipesByCategory(params);
    return remote.result<RecipesEntity>();
  }

  @override
  Future<Result<AppErrors, ExercisesEntity>> getAllExercises(AllExercisesParams params) async {
    final remote = await iHealthRemoteSource.getAllExercises(params);
    return remote.result<ExercisesEntity>();
  }

  @override
  Future<Result<AppErrors, SessionsEntity>> getAllSessions(AllSessionsParams params) async {
    final remote = await iHealthRemoteSource.getAllSession(params);
    return remote.result<SessionsEntity>();
  }

  @override
  Future<Result<AppErrors, DishEntity>> getDishById(GetDishParams params) async {
    final remote = await iHealthRemoteSource.getDishById(params);
    return remote.result<DishEntity>();
  }

  @override
  Future<Result<AppErrors, HealthProfileEntity>> createHealthProfile(HealthProfileParams params) async {
    final remote = await iHealthRemoteSource.createHealthProfile(params);
    return remote.result<HealthProfileEntity>();
  }
  @override
  Future<Result<AppErrors, QuestionsEntity>> getAllQuestions(NoParams params) async {
    final remote = await iHealthRemoteSource.getAllQuestions(params);
    return remote.result<QuestionsEntity>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> answerQuestion(AnswerParams params) async {
    final remote = await iHealthRemoteSource.answerQuestions(params);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, HealthProfileEntity>> updateHealthProfile(HealthProfileParams params) async {
    final remote = await iHealthRemoteSource.updateHealthProfile(params);
    return remote.result<HealthProfileEntity>();
  }

  @override
  Future<Result<AppErrors, FavortieDishListEntity>> getFavoriteDishes(NoParams params) async {
    final remote = await iHealthRemoteSource.getFavoriteDishes(params);
    return remote.result<FavortieDishListEntity>();
  }

  @override
  Future<Result<AppErrors, FavoriteRecipesListEntity>> getFavoriteRecipes(NoParams params) async {
    final remote = await iHealthRemoteSource.getFavoriteRecipes(params);
    return remote.result<FavoriteRecipesListEntity>();
  }

  @override
  Future<Result<AppErrors, RecommendedFoodIListEntity>> getRecommendedFood(NoParams params) async {
    final remote = await iHealthRemoteSource.getRecommendedFood(params);
    return remote.result<RecommendedFoodIListEntity>();
  }

  @override
  Future<Result<AppErrors, DailySessionListEntity>> getDailySessions(DateParams params) async {
    final remote = await iHealthRemoteSource.getDailySessions(params);
    return remote.result<DailySessionListEntity>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> createDailySession(CreateDailySessionParams params) async {
    final remote = await iHealthRemoteSource.createDailySession(params);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, FavoriteSessionListEntity>> getFavoriteSessions(NoParams params) async {
    final remote = await iHealthRemoteSource.getFavoriteSessions(params);
    return remote.result<FavoriteSessionListEntity>();
  }

  @override
  Future<Result<AppErrors, RecommendedSessionListEntity>> getRecommendedSession(NoParams params) async {
    final remote = await iHealthRemoteSource.getRecommendedSession(params);
    return remote.result<RecommendedSessionListEntity>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> updateDailyWater(UpdateDailyWaterParams params) async {
    final remote = await iHealthRemoteSource.updateDailyWater(params);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, HealthProfileEntity>> updateGoal(UpdateGoalParams params) async {
    final remote = await iHealthRemoteSource.updateGoal(params);
    return remote.result<HealthProfileEntity>();
  }

  @override
  Future<Result<AppErrors, HealthDashboardEntity>> getHealthDashboard(DateParams params) async {
    final remote = await iHealthRemoteSource.getHealthDashboard(params);
    return remote.result<HealthDashboardEntity>();
  }

  @override
  Future<Result<AppErrors, CheckHealthProfileEntity>> checkHealthProfile(NoParams params) async {
    final remote = await iHealthRemoteSource.checkHealthProfile(params);
    return remote.result<CheckHealthProfileEntity>();
  }

  @override
  Future<Result<AppErrors, DishesEntity>> getDishesByCategory(GetDishListParams params) async {
    final remote = await iHealthRemoteSource.getDishesByCategory(params);
    return remote.result<DishesEntity>();
  }

  @override
  Future<Result<AppErrors, HealthResultResponseEntity>> getUserResults(NoParams params) async {
    final remote = await iHealthRemoteSource.getUserResults(params);
    return remote.result<HealthResultResponseEntity>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> updateDailySteps(UpdateDailyStepsParams params) async {
    final remote = await iHealthRemoteSource.updateDailySteps(params);
    return remote.result<EmptyResponse>();
  }








  
}
