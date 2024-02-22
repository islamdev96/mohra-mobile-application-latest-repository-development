import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/custom_map/logic/custom_map_model.dart';
import 'package:starter_application/core/ui/custom_map/logic/custom_marker.dart';
import 'package:starter_application/core/ui/custom_map/logic/location_wrapper.dart';
import 'package:starter_application/core/ui/custom_map/logic/map_utils.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/single_message_screen_notifier.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class MessageLocationScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;

  /// CustomMap fields
  Uint8List? userMarkerIcon;
  Uint8List? unSelectedMarkerIcon;
  late final GoogleMapController? controller;
  final location = const LatLng(33.510414, 36.278336);
  bool isFirstMarker = true;
  LatLng? _selectedLoc;
  Placemark? _selectedPlacemark;
  bool isShareLiveLocation = false;

  /// custom markers list
  List<CustomMarker> markers = [];
  CustomMarker? myLocationMarker;
  LatLng? myLocation;

  final double infoWindowWidth = 0.8.sw;
  final double infoWidnowHeight = 150.h;
  final double markerInfoWindowOffset = 290.h;
  bool _isSendLocationDisabled = true;

  // final double userInfoWindowWidth = 250.w;
  // final double userInfoWidnowHeight = 100.h;
  // final double userMarkerOffset = 250.h;

  /// Getters and Setters

  bool get isSendLocationDisabled => _isSendLocationDisabled;

  set isSendLocationDisabled(bool value) {
    _isSendLocationDisabled = value;
    notifyListeners();
  }

  LatLng? get selectedLoc => _selectedLoc;

  set selectedLoc(LatLng? value) {
    _selectedLoc = value;
    notifyListeners();
  }

  Placemark? get selectedPlacemark => _selectedPlacemark;

  set selectedPlacemark(Placemark? value) {
    _selectedPlacemark = value;
    notifyListeners();
  }

  /// Methods
  Future<void> onMapCreated(
      BuildContext context, GoogleMapController? conteroller) async {
    controller = conteroller;
    onGoToMyLocationTap();
  }

  onMapTap(LatLng latLng) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    if (placemarks.isEmpty) return;
    addToMarkers(latLng: latLng, title: getPlaceMarkInfo(placemarks.first));
    selectedLoc = latLng;
    selectedPlacemark = placemarks.first;
  }

  onSave() {
    Nav.pop(
        context,
        LocationScreenResultParam(
          isShareLiveLocation: isShareLiveLocation,
          latLng: isShareLiveLocation ? myLocation : selectedLoc,
          placeMark: selectedPlacemark,
        ));
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    return MapUtils.getBytesFromAsset(
      path,
      width,
    );
  }

  Future<void> setMarkersIcons() async {
    final int size = ScreenUtil().setHeight(300).floor();
    unSelectedMarkerIcon =
        await getBytesFromAsset(AppConstants.IMG_MARKER1, size);
  }

  Future<void> setMarkers(
    BuildContext context,
  ) async {
    /* markers.add(
      getCustomMarker(
          latLng: location,
          title: 'Set this Location',
          subTitle: 'location info, location'),
    );*/
  }
  shareLiveLocation() {
    isShareLiveLocation = true;
    onSave();
  }

  CustomMarker getCustomMarker(
      {required LatLng latLng,
      required String title,
      required String subTitle}) {
    return CustomMarker(
      unSelectedIcon: unSelectedMarkerIcon,
      location: latLng,
      onTap: () {},
      customInfoWindowWidth: infoWindowWidth,
      customInfoWindowHeight: infoWidnowHeight,
      customInfoWindowVOffset: markerInfoWindowOffset,
      customInfoWindow: () => Container(
        width: infoWindowWidth,
        height: infoWidnowHeight,
        decoration: BoxDecoration(
          color: AppColors.primaryColorLight,
          borderRadius: BorderRadius.circular(
            20.r,
          ),
        ),
        child: Center(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: TextStyle(
                    fontSize: 40.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                    text: subTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w300,
                    )),
              ],
            ),
          ),
        ),
      ),
      tailHeight: 0,
      markerId: const MarkerId("1"),
    );
  }

  void onGoToMyLocationTap() async {
    if (controller != null) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      if (position != null &&
          position.latitude != null &&
          position.longitude != null) {
        final latLng = LatLng(position.latitude, position.longitude);
        myLocation = latLng;
        controller!.animateCamera(CameraUpdate.newLatLng(latLng));
      }
    }
  }

  addToMarkers(
      {required LatLng latLng, String title = '', String subTitle = ''}) {
    Provider.of<CustomMapModel>(context, listen: false).addMarker(
      false,
      isFirstMarker,
      getCustomMarker(latLng: latLng, title: title, subTitle: subTitle),
      0,
      getCustomMarker(latLng: latLng, title: title, subTitle: subTitle)
          .getMarkerIcon(isSelected: false),
      (
          {bool? isMyLocationMarker,
          CustomMarker? marker,
          int? index,
          bool? isInitialMarker}) {},
    );
    isFirstMarker = false;
    notifyListeners();
  }

  @override
  void closeNotifier() {
    this.dispose();
  }
}
