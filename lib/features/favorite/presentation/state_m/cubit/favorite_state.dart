part of 'favorite_cubit.dart';

@freezed
class FavoriteState with _$FavoriteState {
  const factory FavoriteState.favoriteInitState() = FavoriteInitState;

  const factory FavoriteState.favoriteLoadingState() = FavoriteLoadingState;

  const factory FavoriteState.getFavoritesSuccessState(
      FavoritesEntity favoritesEntity) = GetFavoritesSuccessState;
  const factory FavoriteState.createFavoriteSuccessState(
      FavoriteEntity favoriteEntity) = CreateFavoriteSuccessState;
  const factory FavoriteState.deleteFavoriteSuccessState() =
      DeleteFavoriteSuccessState;

  const factory FavoriteState.favoriteErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = FavoriteErrorState;
}
