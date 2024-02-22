part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.homeInitState() = HomeInitState;

  const factory HomeState.homeLoadingState() = HomeLoadingState;

  const factory HomeState.homeLoadedState(EmptyResponse emptyResponse) =
      HomeLoadedState;

  const factory HomeState.bannersLoadedState(BannersEntity bannersEntity) =
  BannersLoadedState;

  const factory HomeState.bannersLoadingState() = BannersLoadingState;
  const factory HomeState.bannersLoadingError(
      AppErrors error,
      VoidCallback callback,
      ) = BannersLoadingError;


  const factory HomeState.homeErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = HomeErrorInitState;
}
