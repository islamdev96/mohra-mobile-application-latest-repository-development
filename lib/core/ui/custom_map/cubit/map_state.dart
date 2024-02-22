part of 'map_cubit.dart';

@freezed
abstract class MapState with _$MapState {
  const factory MapState.mapInitial() = MapInitial;
  const factory MapState.mapLoading() = MapLoading;
  const factory MapState.mapDistanceLoaded(
      {required MapDistanceModel mapDistanceResult}) = MapDistanceLoaded;
  const factory MapState.mapError({required AppErrors error, required VoidCallback callback}) =
      MapError;
}
