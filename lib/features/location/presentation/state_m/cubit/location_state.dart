part of 'location_cubit.dart';

@freezed
class LocationState with _$LocationState {
  const factory LocationState.locationInitState() = LocationInitState;

  const factory LocationState.locationLoadingState() = LocationLoadingState;
  const factory LocationState.locationsLoadedState(
      LocationsLiteEntity locationsLiteEntity) = LocationsLoadedState;

  const factory LocationState.locationErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = LocationErrorState;
}
