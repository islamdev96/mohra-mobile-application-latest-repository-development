/*import 'dart:async';

import 'package:background_location/background_location.dart';

enum TrackingType {
  /// Get location on each [duration]
  BY_DURATION,

  /// Get location after passing a [distance]
  BY_DISTANCE
}

class TrackingService {
  static final _instance = TrackingService._singleton();

  factory TrackingService() {
    return _instance;
  }
  TrackingService._singleton();

  bool trackingOn = false;
  Timer? timer;

  Future<void> startTrackingService(
    void onLocationChanged(Location newLocation), {

    /// [distanceFilter] used if [type] = TrackingType.BY_DISTANCE
    double distanceFilter = 0,

    /// [duration] used if [type] = TrackingType.BY_DURATION
    Duration duration = const Duration(seconds: 0),
    String? title,
    String? message,
    String? iconUrl,
    TrackingType type = TrackingType.BY_DURATION,
  }) async {
    trackingOn = true;
    print("Location Tracking Has Started ");
    await BackgroundLocation.setAndroidNotification(
      title: title ?? 'Background service is running',
      message: message ?? 'Background location in progress',
      icon: iconUrl ?? '@mipmap/ic_launcher',
    );
    await BackgroundLocation.startLocationService(
        distanceFilter: distanceFilter);

    /// Start tracking by distance
    if (type == TrackingType.BY_DISTANCE) {
      BackgroundLocation.getLocationUpdates((location) {
        print("Location Changed");
        onLocationChanged(location);
      });

      /// Start tracking by duration
    } else if (type == TrackingType.BY_DURATION) {
      if (timer == null || !timer!.isActive) {
        timer = Timer.periodic(duration, (timer) async {
          final location = await getCurrentLocation();
          if (location != null) {
            print("Location recived from tracking service");
            onLocationChanged(location);
          }
        });
      }
    }
  }

  void stopLocationService() {
    if (trackingOn) {
      if (timer?.isActive ?? false) timer!.cancel();
      trackingOn = false;
      BackgroundLocation.stopLocationService();
    }
  }

  Future<Location?> getCurrentLocation() async {
    return await BackgroundLocation().getCurrentLocation();
  }
}*/
