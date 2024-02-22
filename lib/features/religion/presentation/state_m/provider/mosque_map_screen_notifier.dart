import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:starter_application/core/theme/theme_colors.dart';
import 'package:starter_application/core/ui/custom_map/logic/custom_marker.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class MosqueMapScreenNotifier extends ScreenNotifier {
  /// Constructor
  MosqueMapScreenNotifier(this.param);

  /// Fields
  late BuildContext context;
  final MosqueMapScreenParam param;

  /// CustomMap fields
  List<CustomMarker> markers = [];
  CustomMarker? myLocationMarker;
  final double infoWindowWidth = 250.w;
  final double infoWidnowHeight = 100.h;
  final double markerInfoWindowOffset = 250.h;
  final double userInfoWindowWidth = 250.w;
  final double userInfoWidnowHeight = 100.h;
  final double userMarkerOffset = 250.h;

  /// Getters and Setters

  /// Methods
  Future<void> setMarkers(
    BuildContext context,
  ) async {
    myLocationMarker = CustomMarker(
        defaultIcon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueAzure,
        ),
        customInfoWindowWidth: userInfoWindowWidth,
        customInfoWindowVOffset: userMarkerOffset,
        customInfoWindowHeight: userInfoWidnowHeight,
        markerId: const MarkerId("you"),
        customInfoWindow: () => Container(
              color: Colors.white,
              width: userInfoWindowWidth,
              height: userInfoWidnowHeight,
              child: Center(
                child: FittedBox(
                  child: Text(
                    "You",
                    style: TextStyle(color: ThemeColors().textColor),
                  ),
                ),
              ),
            ),
        onTap: () {
          // notifyListeners();
        });

    markers.add(
      CustomMarker(
        location: param.mosqueLocation,
        customInfoWindowWidth: infoWindowWidth,
        customInfoWindowHeight: infoWidnowHeight,
        customInfoWindowVOffset: markerInfoWindowOffset,
        customInfoWindow: () => Container(
          color: Colors.white,
          width: infoWindowWidth,
          height: infoWidnowHeight,
          child: Center(
            child: FittedBox(
              child: Text(
                param.mosqueName,
                style: TextStyle(
                  color: ThemeColors().textColor,
                ),
              ),
            ),
          ),
        ),
        markerId: const MarkerId("1"),
      ),
    );
  }

  @override
  void closeNotifier() {
    this.dispose();
  }
}

class MosqueMapScreenParam {
  final LatLng mosqueLocation;
  final String mosqueName;

  MosqueMapScreenParam({
    required this.mosqueLocation,
    required this.mosqueName,
  });
}
