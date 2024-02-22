import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/di/service_locator.dart';
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
import 'package:starter_application/features/health/domain/entity/check_health_profile_entity.dart';
import 'package:starter_application/features/health/domain/entity/daily_dish_entity.dart';
import 'package:starter_application/features/health/domain/entity/daily_session_entity.dart';
import 'package:starter_application/features/health/domain/entity/dishes_list_entity.dart';
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
import 'package:starter_application/features/health/domain/usecase/answer_quesition_use_case.dart';
import 'package:starter_application/features/health/domain/usecase/check_health_profile_usecase.dart';
import 'package:starter_application/features/health/domain/usecase/create_daily_dish_usecase.dart';
import 'package:starter_application/features/health/domain/usecase/create_daily_session_usecase.dart';
import 'package:starter_application/features/health/domain/usecase/create_health_profile_usecase.dart';
import 'package:starter_application/features/health/domain/usecase/get_daily_dish_list_usecase.dart';
import 'package:starter_application/features/health/domain/usecase/get_daily_session_usecase.dart';
import 'package:starter_application/features/health/domain/usecase/get_dish_by_id_usecase.dart';
import 'package:starter_application/features/health/domain/usecase/get_dish_list_by_category_usecase.dart';
import 'package:starter_application/features/health/domain/usecase/get_favorite_dishes_usecase.dart';
import 'package:starter_application/features/health/domain/usecase/get_favorite_recipes_usecase.dart';
import 'package:starter_application/features/health/domain/usecase/get_favorite_sessions_usecase.dart';
import 'package:starter_application/features/health/domain/usecase/get_food_categories_usecase.dart';
import 'package:starter_application/features/health/domain/usecase/get_health_dashboard_usecase.dart';
import 'package:starter_application/features/health/domain/usecase/get_questions_usecase.dart';
import 'package:starter_application/features/health/domain/usecase/get_recipe_list_by_category_usecase.dart';
import 'package:starter_application/features/health/domain/usecase/get_recommended_food.dart';
import 'package:starter_application/features/health/domain/usecase/get_recommended_session_usecase.dart';
import 'package:starter_application/features/health/domain/usecase/get_sessions_usecase.dart';
import 'package:starter_application/features/health/domain/usecase/get_user_results_usecase.dart';
import 'package:starter_application/features/health/domain/usecase/update_daily_steps_usecase.dart';
import 'package:starter_application/features/health/domain/usecase/update_daily_water_usecase.dart';
import 'package:starter_application/features/health/domain/usecase/update_goal_usecase.dart';
import 'package:starter_application/features/health/domain/usecase/update_health_profile_usecase.dart';
import 'package:starter_application/features/health/domain/usecase/upload_image_usecase.dart';

import '../../../../../core/errors/app_errors.dart';

part 'health_cubit.freezed.dart';

part 'health_state.dart';

class HealthCubit extends Cubit<HealthState> {
  HealthCubit() : super(const HealthState.healthInitState());

  void getFoodCategories(SearchParam params) async {
    emit(const HealthState.healthLoadingState());
    final result = await getIt<GetFoodCategoriesUsecase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(HealthState.foodCategoriesLoaded(data)),
      onError: (error) =>
          emit(
            HealthState.healthErrorState(
                error, () => this.getFoodCategories(params)),
          ),
    );
  }

  void uploadImage(ImageParams params) async {
    emit(const HealthState.uploadImage());
    final result = await getIt<UploadImageUsecase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(HealthState.createDailyDish(data)),
      onError: (error) =>
          emit(
            HealthState.healthErrorState(error, () => this.uploadImage(params)),
          ),
    );
  }

  void createDailyDish(DailyDishParams params) async {
    emit(const HealthState.healthLoadingState());
    final result = await getIt<CreateDailyDishUsecase>()(params);
    result.pick(
      onData: (data) => emit(HealthState.dailyDishCreated(data)),
      onError: (error) =>
          emit(
            HealthState.healthErrorState(
                error, () => this.createDailyDish(params)),
          ),
    );
  }

  void eatDailyDish(DailyDishParams params) async {
    final result = await getIt<CreateDailyDishUsecase>()(params);
    result.pick(
      onData: (data) => emit(HealthState.dailyDishCreated(data)),
      onError: (error) =>
          emit(
            HealthState.healthErrorState(
                error, () => this.createDailyDish(params)),
          ),
    );
  }

  void getDailyDishList(DailyDishListParamms params) async {
    emit(const HealthState.healthLoadingState());
    final result = await getIt<GetDailyDishListUsecase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(HealthState.dailyDishListLoaded(data)),
      onError: (error) =>
          emit(
            HealthState.healthErrorState(
                error, () => this.getDailyDishList(params)),
          ),
    );
  }

  void getDishedByCategory(GetDishListParams params) async {
    emit(const HealthState.healthLoadingState());
    final result = await getIt<GetDishedListByCategoryUsecase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(HealthState.dishListLoaded(data)),
      onError: (error) =>
          emit(
            HealthState.healthErrorState(
                error, () => this.getDishedByCategory(params)),
          ),
    );
  }

  void getRecipesByCategory(GetDishListParams params) async {
    emit(const HealthState.healthLoadingState());
    final result = await getIt<GetRecipeListByCategoryUsecase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(HealthState.recipeListLoaded(data)),
      onError: (error) =>
          emit(
            HealthState.healthErrorState(
                error, () => this.getDishedByCategory(params)),
          ),
    );
  }

  void getDishById(GetDishParams params) async {
    emit(const HealthState.healthLoadingState());
    final result = await getIt<GetDishByIdUsecase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(HealthState.dishLoaded(data)),
      onError: (error) =>
          emit(
            HealthState.healthErrorState(error, () => this.getDishById(params)),
          ),
    );
  }

  void getSessions(AllSessionsParams params) async {
    emit(const HealthState.healthLoadingState());
    final result = await getIt<GetSessionsUsecase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(HealthState.sessionListLoaded(data)),
      onError: (error) =>
          emit(
            HealthState.healthErrorState(error, () => this.getSessions(params)),
          ),
    );
  }

  void getAllQuesions(NoParams params) async {
    print('aaa');
    emit(const HealthState.healthLoadingState());
    final result = await getIt<GetQuestionsUsecase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(HealthState.questionLoaded(data)),
      onError: (error) =>
          emit(
            HealthState.healthErrorState(
                error, () => this.getAllQuesions(params)),
          ),
    );
  }

  void createProfile(HealthProfileParams params) async {
    emit(const HealthState.createProfile());
    final result = await getIt<CreateHealthProfileUsecase>()(params);
    result.pick(
      onData: (data) => emit(HealthState.profileCreated(data)),
      onError: (error) =>
          emit(
            HealthState.healthErrorState(
                error, () => this.createProfile(params)),
          ),
    );
  }

  void answerQuestion(AnswerParams params) async {
    emit(const HealthState.answerQuestion());
    final result = await getIt<AnswerQuestionUsecase>()(params);
    result.pick(
      onData: (data) => emit(HealthState.questionAnswered()),
      onError: (error) =>
          emit(
            HealthState.healthErrorState(
                error, () => this.answerQuestion(params)),
          ),
    );
  }


  void updateProfile(HealthProfileParams params) async {
    emit(const HealthState.updateProfile());
    final result = await getIt<UpdateHealthProfileUsecase>()(params);
    result.pick(
      onData: (data) => emit(HealthState.profileUpdated(data)),
      onError: (error) =>
          emit(
            HealthState.healthErrorState(
                error, () => this.createProfile(params)),
          ),
    );
  }

  void getFavoriteDishes(NoParams params) async {
    emit(const HealthState.healthLoadingState());
    final result = await getIt<GetFavoriteDishesUseCase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(HealthState.favoriteDishesLoaded(data)),
      onError: (error) =>
          emit(
            HealthState.healthErrorState(
                error, () => this.getFavoriteDishes(params)),
          ),
    );
  }

  void getFavoriteRecipes(NoParams params) async {
    emit(const HealthState.healthLoadingState());
    final result = await getIt<GetFavoriteRecipesUseCase>()(params);
    result.pick(
      onData: (data) => emit(HealthState.favoriteRecipesLoaded(data)),
      onError: (error) =>
          emit(
            HealthState.healthErrorState(
                error, () => this.getFavoriteRecipes(params)),
          ),
    );
  }

  void getRecommendedFood(NoParams params) async {
    emit(const HealthState.healthLoadingState());
    final result = await getIt<GetRecommendedFood>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(HealthState.recommendedFoodLoaded(data)),
      onError: (error) =>
          emit(
            HealthState.healthErrorState(
                error, () => this.getRecommendedFood(params)),
          ),
    );
  }
  void getDailySessions(DateParams params) async {
    emit(const HealthState.healthLoadingState());
    final result = await getIt<GetDailySessionUsecase>()(params);
    result.pick(
      onData: (data) => emit(HealthState.dailySessionsLoaded(data)),
      onError: (error) => emit(
        HealthState.healthErrorState(
            error, () => this.getDailySessions(params)),
      ),
    );
  }

  void getFavorateSession(NoParams params) async{
    emit(const HealthState.healthLoadingState());
    final result = await getIt<GetFavoriteSessionListUsecase>()(params);
    result.pick(
      onData: (data) => emit(HealthState.favoriteSessionsLoaded(data)),
      onError: (error) =>
          emit(
            HealthState.healthErrorState(
                error, () => this.getFavoriteRecipes(params)),
          ),
    );
  }
  void createDailySession(CreateDailySessionParams params) async {
    emit(const HealthState.healthLoadingState());
    final result = await getIt<CreateDailySessionUseCase>()(params);
    result.pick(
      onData: (data) => emit(HealthState.dailySessionCreated()),
      onError: (error) =>
          emit(
            HealthState.healthErrorState(
                error, () => this.createDailySession(params)),
          ),
    );
  }

  void getRecommendedSessions(NoParams params) async {
    emit(const HealthState.healthLoadingState());
    final result = await getIt<GetRecommendedSessionUseCase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(HealthState.recommendedSessionLoaded(data)),
      onError: (error) =>
          emit(
            HealthState.healthErrorState(
                error, () => this.getRecommendedSessions(params)),
          ),
    );
  }
  void updateGoal(UpdateGoalParams params) async {
    emit(const HealthState.updateGoal());
    final result = await getIt<UpdateGoalUsecase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(HealthState.goalUpdated(data)),
      onError: (error) =>
          emit(
            HealthState.healthErrorState(
                error, () => this.updateGoal(params)),
          ),
    );
  }
  void updateDailyWater(UpdateDailyWaterParams params) async {
    emit(const HealthState.updateDailyWater());
    final result = await getIt<UpdateDailyWaterUsecase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(const HealthState.dailyWaterUpdated()),
      onError: (error) =>
          emit(
            HealthState.healthErrorState(
                error, () => this.updateDailyWater(params)),
          ),
    );
  }

  void getHealthDashboard(DateParams params) async {
    emit(const HealthState.healthLoadingState());
    final result = await getIt<GetHealthDashboardUsecase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(HealthState.healthDashboardLoaded(data)),
      onError: (error) =>
          emit(
            HealthState.healthErrorState(
                error, () => this.getHealthDashboard(params)),
          ),
    );
  }
  void checkHealthProfile(NoParams params) async {
    emit(const HealthState.healthLoadingState());
    final result = await getIt<CheckHealthProfileUsecase>()(params);
    result.pick(
      onData: (data) => emit(HealthState.checkHealthProfileDone(data)),
      onError: (error) =>
          emit(
            HealthState.healthErrorState(
                error, () => this.checkHealthProfile(params)),
          ),
    );
  }

  void getHealthResults(NoParams params) async {
    emit(const HealthState.healthLoadingState());
    final result = await getIt<GetUserResultsUsecase>()(params);
    result.pick(
      onData: (data) => emit(HealthState.healthResultsLoaded(data)),
      onError: (error) =>
          emit(
            HealthState.healthErrorState(
                error, () => this.getHealthResults(params)),
          ),
    );
  }

  void updateDailyStep(UpdateDailyStepsParams params) async {
    final result = await getIt<UpdateDailyStepsUsecase>()(params);
    result.pick(
      onData: (data) => emit(HealthState.stepsUpdated()),
      onError: (error) =>
          emit(
            HealthState.healthErrorState(
                error, () => this.updateDailyStep(params)),
          ),
    );
  }
}
