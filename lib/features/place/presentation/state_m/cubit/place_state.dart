part of 'place_cubit.dart';

@freezed
class PlaceState with _$PlaceState {
  const factory PlaceState.placeInitState() = PlaceInitState;

  const factory PlaceState.placeLoadingState() = PlaceLoadingState;

  const factory PlaceState.placeErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = PlaceErrorState;
  const factory PlaceState.reverseGeocodingLoaded(
    ReverseGeocodingEntity reverseGeocodingEntity
  ) = ReverseGeocodingLoaded;
}
