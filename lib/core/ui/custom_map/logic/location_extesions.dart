import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

extension LocationDataGetters on LocationData {
  LatLng? get latLng => (this.latitude == null || this.longitude == null) ? null : LatLng(this.latitude!, this.longitude!);
}
