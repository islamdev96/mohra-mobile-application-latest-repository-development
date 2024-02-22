part of 'health_cubit.dart';

@freezed
class HealthState with _$HealthState {
  const factory HealthState.healthInitState() = HealthInitState;

  const factory HealthState.healthLoadingState() = HealthLoadingState;

  const factory HealthState.healthErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = HealthErrorState;

  const factory HealthState.foodCategoriesLoaded(
      FoodCategoriesEntity foodCategoriesEntity) = FoodCategoriesLoaded;

  const factory HealthState.uploadImage() = UploadImage;

  const factory HealthState.createDailyDish(ImageUrlsEntity imageUrlsEntity) =
      CreateDailyDish;

  const factory HealthState.dailyDishCreated(DailyDishEntity dailyDishEntity) =
      DailyDishCreated;

  const factory HealthState.dailyDishListLoaded(
      DailyDishListEntity dailyDishListEntity) = DailyDishListLoaded;

  const factory HealthState.dishListLoaded(
      DishesEntity dishesEntity) = DishListLoaded;

  const factory HealthState.recipeListLoaded(
      RecipesEntity recipesEntity) = RecipeListLoaded;

  const factory HealthState.recipeLoaded(
      RecipesEntity recipesEntity) = RecipeLoaded;

  const factory HealthState.dishLoaded(
      DishEntity dishEntity) = DishLoaded;

  const factory HealthState.sessionListLoaded(
      SessionsEntity sessionsEntity) = SessionListLoaded;

  const factory HealthState.questionLoaded(
      QuestionsEntity questionsEntity) = QuestionLoaded;

  const factory HealthState.createProfile() = CreateProfile;
  const factory HealthState.profileCreated(
      HealthProfileEntity profileEntity) = ProfileCreated;

  const factory HealthState.answerQuestion() = AnswerQuestion;
  const factory HealthState.questionAnswered() = QuestionAnswered;


  const factory HealthState.updateProfile() = UpdateProfile;
  const factory HealthState.profileUpdated(
      HealthProfileEntity profileEntity) = ProfileUpdated;

  const factory HealthState.favoriteDishesLoaded(
      FavortieDishListEntity favortieDishListEntity) = FavoriteDishesLoaded;


  const factory HealthState.favoriteRecipesLoaded(
      FavoriteRecipesListEntity favoriteRecipesListEntity) = FavoriteRecipesLoaded;

  const factory HealthState.recommendedFoodLoaded(
      RecommendedFoodIListEntity recommendedFoodIListEntity) = RecommendedFoodLoaded;

  const factory HealthState.dailySessionsLoaded(
      DailySessionListEntity dailySessionListEntity) = DailySessionsLoaded;


  const factory HealthState.dailySessionCreated() = DailySessionCreated;

  const factory HealthState.favoriteSessionsLoaded(
      FavoriteSessionListEntity favoriteSessionListEntity) = FavoriteSessionsLoaded;

  const factory HealthState.recommendedSessionLoaded(
      RecommendedSessionListEntity recommendedSessionListEntity) = RecommendedSessionLoaded;

  const factory HealthState.goalUpdated(
      HealthProfileEntity healthProfileEntity) = GoalUpdated;

  const factory HealthState.updateGoal() = UpdateGoal;
  const factory HealthState.updateDailyWater() = UpdateDailyWater;

  const factory HealthState.dailyWaterUpdated ()= DailyWaterUpdated;

  const factory HealthState.healthDashboardLoaded (
      HealthDashboardEntity healthDashboardEntity
      )= HealthDashboardLoaded;

  const factory HealthState.checkHealthProfileDone(
      CheckHealthProfileEntity checkHealthProfileEntity) =CheckHealthProfileDone;



  const factory HealthState.healthResultsLoaded(
      HealthResultResponseEntity healthResultResponseEntity) =HealthResultsLoaded;

  const factory HealthState.stepsUpdated() =StepsUpdated;


}

