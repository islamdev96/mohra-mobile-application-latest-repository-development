part of 'religion_cubit.dart';

@freezed
class ReligionState with _$ReligionState {
  const factory ReligionState.religionInitState() = ReligionInitState;

  const factory ReligionState.religionLoadingState() = ReligionLoadingState;

  const factory ReligionState.religionErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = ReligionErrorState;

  const factory ReligionState.prayerTimesLoaded(
    PrayTimeEntity prayTimeEntity,
  ) = PrayerTimesLoaded;

  const factory ReligionState.prayerTimesWithPrevNextLoaded(
    PrayTimeEntity todayTimeEntity,
    PrayTimeEntity prevTimeEntity,
    PrayTimeEntity nextTimeEntity,
  ) = PrayerTimesWithPrevNextLoaded;

  const factory ReligionState.nearbyMosquesLoaded(
    NearbyPlacesEntity nearbyPlacesEntity,
  ) = NearbyMosquesLoaded;

  const factory ReligionState.azkarCategoryLoaded(
    AzkarEntity azkar,
  ) = AzkarCategoryLoaded;
}
