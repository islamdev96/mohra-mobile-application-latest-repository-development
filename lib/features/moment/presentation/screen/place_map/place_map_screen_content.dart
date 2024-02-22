import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/custom_map/widget/custom_map.dart';
import 'package:starter_application/features/moment/presentation/state_m/provider/place_map_screen_notifier.dart';

class PlaceMapScreenContent extends StatefulWidget {
  @override
  State<PlaceMapScreenContent> createState() => _PlaceMapScreenContentState();
}

class _PlaceMapScreenContentState extends State<PlaceMapScreenContent> {
  late PlaceMapScreenNotifier sn;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<PlaceMapScreenNotifier>().setMarkers(context);
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<PlaceMapScreenNotifier>(context);
    sn.context = context;
    return CustomMap(
      mapApiKey: AppConstants.API_KEY_GOOGLE_MAPS,
      polylinesColor: Colors.blue,
      distanceInfoWindowEnabled: false,
      // disableMyLocationPolylines: true,
      disableMyLocationIcon: false,
      disableMyLocationButton: false,

      markers: sn.markers,
      myLocationMarker: sn.myLocationMarker,
      initialIndex: 0,
      onTap: (lat) {
        setState(() {});
      },
      mapToolbarEnabled: false,
      zoomControlsEnabled: false,
      initialCameraPosition: CameraPosition(
        target: sn.param.placeLocation,
        zoom: 15,
      ),
      onCameraMove: (l) async {
        // print("${l.target.latitude}, ${l.target.longitude}");
      },
    );
  }
}
