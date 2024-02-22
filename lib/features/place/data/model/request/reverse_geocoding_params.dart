import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:starter_application/core/params/base_params.dart';

class ReverseGeocodingParam extends BaseParams {
  final LatLng latlng;
  final apiKey;
  final String language;
  final String? addressType;
  final String? locationType;

  ReverseGeocodingParam({
    required this.latlng, 
    required this.apiKey,
    required this.language,
     this.addressType,
     this.locationType,
  });

  @override
  Map<String, dynamic> toMap() {
    Map<String,dynamic> map = {
      "latlng": latlng.latitude.toString() + "," + latlng.longitude.toString(),
      "key": apiKey,
      "language": language,
    };
    if(addressType != null) map['result_type'] = addressType;
    if(locationType != null) map['location_type'] = locationType;
  return map;
  }

}
