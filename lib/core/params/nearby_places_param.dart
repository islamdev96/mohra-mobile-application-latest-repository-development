import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/params/base_params.dart';

class nearbyPlacesParam extends BaseParams {
  final LatLng location;
  final double? radius;
  final String? type;
  final String? keyword;

  /// Google Map Api Key
  final String? key;

  nearbyPlacesParam({
    required this.location,
    this.key,
    this.radius,
    this.type,
    this.keyword,
  });

  Map<String, dynamic> toMap() {
    return {
      'location': "${location.latitude},${location.longitude}",
      'radius': radius ?? 5000,
      if (type != null) 'type': type,
      'keyword': keyword,
      'key': key ?? AppConstants.API_KEY_GOOGLE_MAPS
    };
  }

  nearbyPlacesParam copyWith(
      {LatLng? location, double? radius, String? type, String? keyword}) {
    return nearbyPlacesParam(
      location: location ?? this.location,
      radius: radius ?? this.radius,
      type: type ?? this.type,
      keyword: keyword ?? this.keyword,
    );
  }
}
