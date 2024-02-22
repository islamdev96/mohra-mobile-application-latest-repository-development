part of 'news_cubit.dart';

@freezed
class NewsState with _$NewsState {
  const factory NewsState.newsInitState() = NewsInitState;

  const factory NewsState.newsLoadingState() = NewsLoadingState;

  const factory NewsState.newsErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = NewsErrorState;

  const factory NewsState.newsCategoryLoaded(
    NewsCategoryEntity newsCategoryEntity,
  ) = NewsCategoryLoaded;

  const factory NewsState.newsSingleCategoryLoaded(
    NewsOfCategoryEntity newsSingleCategoryEntity,
  ) = NewsSingleCategoryLoaded;

  const factory NewsState.newsOfSingleCategoryLoaded(
    NewsOfCategoryEntity newsOfCategoryEntity,
  ) = NewsOfSingleCategoryLoaded;

  const factory NewsState.newsOfCategory1HomeLoaded(
    NewsOfCategoryEntity newsOfCategory1Entity,
  ) = NewsOfCategory1HomeLoaded;
  const factory NewsState.newsOfCategory2HomeLoaded(
    NewsOfCategoryEntity newsOfCategory1Entity,
  ) = NewsOfCategory2HomeLoaded;
  const factory NewsState.newsOfCategory3HomeLoaded(
    NewsOfCategoryEntity newsOfCategory1Entity,
  ) = NewsOfCategory3HomeLoaded;
  const factory NewsState.newsOfCategory4HomeLoaded(
    NewsOfCategoryEntity newsOfCategory1Entity,
  ) = NewsOfCategory4HomeLoaded;
  const factory NewsState.newsOfCategory5HomeLoaded(
    NewsOfCategoryEntity newsOfCategory1Entity,
  ) = NewsOfCategory5HomeLoaded;
  const factory NewsState.creationTimeNewsLoaded(
    NewsOfCategoryEntity newsOfCategory1Entity,
  ) = CreationTimeNewsLoaded;
  const factory NewsState.summeryNewsLoaded(
    SummryNewsEntity summeryNewsEntity,
  ) = SummeryNewsLoaded;
  const factory NewsState.newsLoadedState(NewsEntity newsEntity) =
      NewsLoadedState;
}
