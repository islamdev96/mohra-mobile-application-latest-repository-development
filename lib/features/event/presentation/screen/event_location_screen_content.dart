import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/custom_map/widget/custom_map.dart';

import '../screen/../state_m/provider/event_location_screen_notifier.dart';

class EventLocationScreenContent extends StatefulWidget {
  @override
  State<EventLocationScreenContent> createState() =>
      _EventLocationScreenContentState();
}

class _EventLocationScreenContentState
    extends State<EventLocationScreenContent> {
  late EventLocationScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<EventLocationScreenNotifier>(context);
    sn.context = context;
    return CustomMap(
      height: 1.sh,
      width: 1.sw,
      mapApiKey: AppConstants.API_KEY_GOOGLE_MAPS,
      distanceInfoWindowEnabled: false,
      disableMyLocationIcon: false,
      disableMyLocationButton: true,
      disableMyLocationPolylines: true,
      initialIndex: 0,
      onTap: (lat) {
        setState(() {});
      },
      markers: sn.markers,
      mapToolbarEnabled: false,
      zoomControlsEnabled: false,
      initialCameraPosition: CameraPosition(
        target: sn.params.location,
        zoom: 10,
      ),
      onCameraMove: (l) async {
        // print("${l.target.latitude}, ${l.target.longitude}");
      },
    );
  }
}
