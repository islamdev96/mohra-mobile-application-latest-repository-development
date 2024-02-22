import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:starter_application/core/params/screen_params/event_location_screen_params.dart';
import 'package:starter_application/core/ui/custom_map/logic/custom_marker.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class EventLocationScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  static const MARKER_ID = 'EVENT_LOC';
  EventLocationScreenParams params;
  List<CustomMarker> markers = [];

  EventLocationScreenNotifier({required this.params}) {
    markers.add(
      CustomMarker(
        markerId: const MarkerId(MARKER_ID),
        customInfoWindowWidth: 30.w,
        customInfoWindowHeight: 40.w,
        customInfoWindow: () => const SizedBox.shrink(),
        location: params.location,
        tailHeight: 0,
      ),
    );
  }

  /// Getters and Setters

  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }
}
