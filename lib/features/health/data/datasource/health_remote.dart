import 'package:dartz/dartz.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/constants/enums/http_method.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/net/api_url.dart';
import 'package:starter_application/core/net/create_model_interceptor/default_create_model_inteceptor.dart';
import 'package:starter_application/core/net/create_model_interceptor/health_profile_question_interceptor.dart';
import 'package:starter_application/core/net/create_model_interceptor/live_socores_model_intercepter.dart';
import 'package:starter_application/core/net/create_model_interceptor/null_response_model_interceptor.dart';
import 'package:starter_application/core/net/response_validators/default_response_validator.dart';
import 'package:starter_application/core/params/no_params.dart';
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

import 'ihealth_remote.dart';

@Singleton(as: IHealthRemoteSource)
class HealthRemoteSource extends IHealthRemoteSource {
  @override
  Future<Either<AppErrors, FoodCategoriesModel>> getAllCategories(
      SearchParam params) {
    return request(
      converter: (json) {
        return FoodCategoriesModel.fromMap(json);
      },
      method: HttpMethod.GET,
      url: APIUrls.getAllFoodCategories,
      queryParameters: params.toMap(),
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, ImageUrlsModel>> uploadImage(ImageParams params) {
    print('aaaa');
    return requestUploadFile(
        converter: (json) {
          return ImageUrlsModel.fromMap(json);
        },
        url: APIUrls.uploadImageMahmoud,
        fileKey: 'input',
        filePath: params.image.path,
        data: {},
        responseValidator: DefaultResponseValidator(),
        createModelInterceptor: DefaultCreateModelInterceptor(),
        mediaType: MediaType('image', 'png'));
  }

  @override
  Future<Either<AppErrors, DailyDishModel>> createDailyDish(
      DailyDishParams params) {
    return request(
      converter: (json) {
        return DailyDishModel.fromMap(json);
      },
      method: HttpMethod.POST,
      url: APIUrls.createDailyFood,
      body: params.toMap(),
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, DailyDishListModel>> getDailyDishList(
      DailyDishListParamms params) {
    return request(
      converter: (json) {
        return DailyDishListModel.fromMap(json);
      },
      method: HttpMethod.GET,
      url: APIUrls.getDailyDishList,
      queryParameters: params.toMap(),
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, DishesModel>> getDishesByCategory(
      GetDishListParams params) {
    return request(
      converter: (json) {
        return DishesModel.fromMap(json);
      },
      method: HttpMethod.GET,
      url: APIUrls.getDishListByCategory,
      responseValidator: DefaultResponseValidator(),
      queryParameters: params.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, RecipesModel>> getRecipesByCategory(
      GetDishListParams params) {
    return request(
        converter: (json) {
          return RecipesModel.fromMap(json);
        },
        method: HttpMethod.GET,
        url: APIUrls.getRecipeListByCategory,
        responseValidator: DefaultResponseValidator(),
        queryParameters: params.toMap());
  }

  @override
  Future<Either<AppErrors, ExercisesModel>> getAllExercises(
      AllExercisesParams params) {
    return request(
        converter: (json) {
          return ExercisesModel.fromMap(json);
        },
        method: HttpMethod.GET,
        url: APIUrls.getAllExercises,
        responseValidator: DefaultResponseValidator(),
        queryParameters: params.toMap());
  }

  @override
  Future<Either<AppErrors, SessionsModel>> getAllSession(
      AllSessionsParams params) {
    return request(
        converter: (json) {
          return SessionsModel.fromMap(json);
        },
        method: HttpMethod.GET,
        url: APIUrls.getAllSessions,
        responseValidator: DefaultResponseValidator(),
        queryParameters: params.toMap());
  }

  @override
  Future<Either<AppErrors, DishModel>> getDishById(GetDishParams params) {
    return request(
        converter: (json) {
          return DishModel.fromMap(json);
        },
        method: HttpMethod.GET,
        url: APIUrls.getDishById,
        responseValidator: DefaultResponseValidator(),
        queryParameters: params.toMap());
  }

  @override
  Future<Either<AppErrors, HealthProfileModel>> createHealthProfile(
      HealthProfileParams params) {
    print('aass');
    print(params);
    return request(
      converter: (json) {
        return HealthProfileModel.fromMap(json);
      },
      method: HttpMethod.POST,
      url: APIUrls.createProfile,
      body: params.toMap(),
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, GetQuestionsModel>> getAllQuestions(
      NoParams params) {
    return request(
        converter: (json) {
          return GetQuestionsModel.fromMap(json);
        },
        method: HttpMethod.GET,
        url: APIUrls.getQuestions,
        responseValidator: DefaultResponseValidator(),
        createModelInterceptor: const HealthProfileQuestionInterceptor());
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> answerQuestions(
      AnswerParams params) {
    return request(
      converter: (json) {
        return EmptyResponse.fromMap(json);
      },
      method: HttpMethod.POST,
      body: params.toMap(),
      url: APIUrls.answerQuestions,
      responseValidator: DefaultResponseValidator(),
      createModelInterceptor: LiveSocoresModelIntercepter(),
    );
  }

  @override
  Future<Either<AppErrors, HealthProfileModel>> updateHealthProfile(
      HealthProfileParams params) {
    return request(
      converter: (json) {
        return HealthProfileModel.fromMap(json);
      },
      method: HttpMethod.PUT,
      url: APIUrls.updateProfile,
      body: params.toMap(),
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, FavortieDishListModel>> getFavoriteDishes(
      NoParams params) {
    return request(
      converter: (json) {
        return FavortieDishListModel.fromMap(json);
      },
      method: HttpMethod.GET,
      url: APIUrls.getFavoriteDishes,
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, FavoriteRecipesListModel>> getFavoriteRecipes(
      NoParams params) {
    return request(
      converter: (json) {
        return FavoriteRecipesListModel.fromMap(json);
      },
      method: HttpMethod.GET,
      url: APIUrls.getFavoriteRecipes,
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, RecommendedFoodIListModel>> getRecommendedFood(
      NoParams params) {
    return request(
      converter: (json) {
        return RecommendedFoodIListModel.fromMap(json);
      },
      method: HttpMethod.GET,
      url: APIUrls.getRecommendedFood,
      responseValidator: DefaultResponseValidator(),
      createModelInterceptor: LiveSocoresModelIntercepter(),
    );
  }

  @override
  Future<Either<AppErrors, DailySessionListModel>> getDailySessions(
      DateParams params) {
    return request(
      converter: (json) {
        return DailySessionListModel.fromMap(json);
      },
      method: HttpMethod.GET,
      url: APIUrls.getDailySessions,
      queryParameters: params.toMap(),
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> createDailySession(
      CreateDailySessionParams params) {
    return request(
      converter: (json) {
        return EmptyResponse.fromMap(json);
      },
      method: HttpMethod.POST,
      url: APIUrls.createDailySession,
      body: params.toMap(),
      responseValidator: DefaultResponseValidator(),
      createModelInterceptor: LiveSocoresModelIntercepter(),
    );
  }

  @override
  Future<Either<AppErrors, FavoriteSessionListModel>> getFavoriteSessions(
      NoParams params) {
    return request(
      converter: (json) {
        return FavoriteSessionListModel.fromMap(json);
      },
      method: HttpMethod.GET,
      url: APIUrls.getFavoriteSessions,
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, RecommendedSessionListModel>> getRecommendedSession(
      NoParams params) {
    return request(
      converter: (json) {
        return RecommendedSessionListModel.fromMap(json);
      },
      method: HttpMethod.GET,
      url: APIUrls.getRecommendedSession,
      responseValidator: DefaultResponseValidator(),
      createModelInterceptor: LiveSocoresModelIntercepter(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> updateDailyWater(
      UpdateDailyWaterParams params) {
    return request(
      converter: (json) {
        print('ddddddddddddddddddd');
        print(json);
        return EmptyResponse.fromMap({});
      },
      method: HttpMethod.PUT,
      url: APIUrls.updateDailyWater,
      body: params.toMap(),
      responseValidator: DefaultResponseValidator(),
      createModelInterceptor: LiveSocoresModelIntercepter(),
    );
  }

  @override
  Future<Either<AppErrors, HealthProfileModel>> updateGoal(
      UpdateGoalParams params) {
    return request(
      converter: (json) {
        return HealthProfileModel.fromMap(json);
      },
      method: HttpMethod.PUT,
      url: APIUrls.updateGoal,
      responseValidator: DefaultResponseValidator(),
      body: params.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, HealthDashboardModel>> getHealthDashboard(
      DateParams params) {
    return request(
      converter: (json) {
        return HealthDashboardModel.fromMap(json);
      },
      method: HttpMethod.GET,
      url: APIUrls.getHealthDashboard,
      queryParameters: params.toMap(),
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, CheckHealthProfileModel>> checkHealthProfile(
      NoParams params) {
    return request(
      converter: (json) {
        return CheckHealthProfileModel.fromMap(json);
      },
      method: HttpMethod.GET,
      url: APIUrls.checkHealthProfile,
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, HealthResultResponseModel>> getUserResults(NoParams params) {
    return request(
      converter: (json) {
        return HealthResultResponseModel.fromJson(json);
      },
      method: HttpMethod.GET,
      url: APIUrls.getUserResults,
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> updateDailySteps(UpdateDailyStepsParams params) {
    return request(
      converter: (json) {
        return EmptyResponse.fromMap(json);
      },
      method: HttpMethod.PUT,
      url: APIUrls.updateDailySteps,
        body: params.toMap(),
      createModelInterceptor: NullResponseModelInterceptor()
    );
  }
}
