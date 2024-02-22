import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/custom_map/widget/custom_map.dart';
import 'package:starter_application/features/religion/presentation/state_m/provider/mosque_map_screen_notifier.dart';

class MosqueMapScreenContent extends StatefulWidget {
  @override
  State<MosqueMapScreenContent> createState() => _MosqueMapScreenContentState();
}

class _MosqueMapScreenContentState extends State<MosqueMapScreenContent> {
  late MosqueMapScreenNotifier sn;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<MosqueMapScreenNotifier>().setMarkers(context);
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<MosqueMapScreenNotifier>(context);
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
        target: sn.param.mosqueLocation,
        zoom: 15,
      ),
      onCameraMove: (l) async {
        // print("${l.target.latitude}, ${l.target.longitude}");
      },
    );
  }
}
