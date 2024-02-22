import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/global_messages_notifier.dart';

import '../screen/../state_m/provider/live_location_screen_notifier.dart';

class LiveLocationScreenContent extends StatefulWidget {
  @override
  State<LiveLocationScreenContent> createState() =>
      _LiveLocationScreenContentState();
}

class _LiveLocationScreenContentState extends State<LiveLocationScreenContent> {
  late LiveLocationScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<LiveLocationScreenNotifier>(context);
    sn.context = context;
    LatLng? latLng;

    List<LocationInfo> locs =
        Provider.of<GlobalMessagesNotifier>(context, listen: true).locations;
    LocationInfo locationInfo;
    if (locs.isNotEmpty) {
      locationInfo =
          locs.firstWhere((element) => element.receiverId == sn.params.id);
      latLng = locationInfo.location;
    }
    return latLng == null
        ? WaitingWidget()
        : GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(latLng.latitude, latLng.longitude),
              zoom: 13.5,
            ),
            markers: {
              Marker(
                markerId: const MarkerId("currentLocation"),
                position: LatLng(latLng.latitude, latLng.longitude),
              ),
            },
          );
  }
}
