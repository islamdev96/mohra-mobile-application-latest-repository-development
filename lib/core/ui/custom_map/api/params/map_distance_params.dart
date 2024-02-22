import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:starter_application/core/params/base_params.dart';

class MapDistanceParam extends BaseParams {
  final LatLng source, destination;
  final apiKey;

  MapDistanceParam({
    required this.source,
    required this.destination,
    required this.apiKey,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      "units": "metric",
      "origins": source.latitude.toString() + "," + source.longitude.toString(),
      "destinations": destination.latitude.toString() +
          "," +
          destination.longitude.toString(),
      "key": apiKey,
    };
  }
}
