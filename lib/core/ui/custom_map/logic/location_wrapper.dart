import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

///
/// This class has location related functions
///
class LocationWrapper {
  static final _instance = LocationWrapper._getInstance();

  factory LocationWrapper.singleton() {
    return _instance;
  }

  LocationWrapper._getInstance() {}

  LocationWrapper();

  /// Check if GPS/LocationService is currently open or not
  final loc.Location _checkGps = loc.Location();

  /// LocationData destinationLocation; // wrapper around the location API
  final Location location = Location();

  /// Map Location realted functions

  /// Check if the Gps/locationService is enabled
  Future<bool> isLocationServiceEnabled() {
    return _checkGps.serviceEnabled();
  }

  Future<bool> requestGpsServiceActivation() async {
    bool _serviceEnabled = await isLocationServiceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _checkGps.requestService();
    }
    return Future.value(_serviceEnabled);
  }

  Future<bool> checkLocationPermissons() async {
    /// Request the user for access to location permisson, if access hasn't already been grant access before

    bool result = true;
    if (!(await Permission.location.isGranted))
      result = (await Permission.location.request()).isGranted;

    /// Request the activation of the location/GPS service
    if (!(await isLocationServiceEnabled())) {
      result = result && (await requestGpsServiceActivation());
    }
    return result;
  }

  /// Get the current location of the user and if not available return the latest available loaction
  Future<LocationData?> getMyLocation() async {
    if (await checkLocationPermissons()) {
      return await location.getLocation();
    }
    return null;
  }

  /// Transform latlng to position
  Position latlngToPosition(LatLng location) {
    return Position(
      longitude: location.longitude,
      latitude: location.latitude,
      accuracy: 0,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
      timestamp: DateTime.now(),
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
    );
  }
}
