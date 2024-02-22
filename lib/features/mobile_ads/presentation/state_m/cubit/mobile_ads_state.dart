part of 'mobile_ads_cubit.dart';

@freezed
class MobileAdsState with _$MobileAdsState {
  const factory MobileAdsState.mobileAdsInitState() = MobileAdsInitState;

  const factory MobileAdsState.mobileAdsLoadingState() = MobileAdsLoadingState;

  const factory MobileAdsState.mobileAdsErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = MobileAdsErrorState;

  
}

