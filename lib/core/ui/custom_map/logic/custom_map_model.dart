import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'custom_marker.dart';
import 'distance_window_data.dart';
import 'info_window_data.dart';

enum WindowType {
  INFO_WINDOW,
  DISTANCE_WINDOW,
}

class CustomMapModel extends ChangeNotifier {
  /// Map variables
  List<Marker> _markers = [];
  double _mapWidth = ScreenUtil().screenWidth;
  double _mapHeight = ScreenUtil().screenHeight;
  GoogleMapController? controller;

  /// Info Window Variables
  double? _infoWindowLeftMargin;
  double? _infoWindowTopMargin;
  InfoWIndowData _infoWindowData = InfoWIndowData(vOffset: 0, windowWidth: 0);

  /// Distance Window Variables
  DistanceWindowData _distanceWindowData =
      DistanceWindowData(vOffset: 0, windowWidth: 0);
  double? _distanceLeftMargin;
  double? _distanceRightMargin;
  double? _distanceTopMargin;
  double? _distanceBottomMargin;

  Future<void> updateMapStyle(String? route) async {
    if (controller != null) {
      if (route == null) {
        controller!.setMapStyle(null);
        return;
      }
      String? mapStyle;
      mapStyle = await rootBundle.loadString(route);
      controller!.setMapStyle(mapStyle);
    }
  }

  void setMapDimensions(
    double? width,
    double? height,
  ) {
    _mapHeight = height ?? _mapHeight;

    _mapWidth = width ?? _mapWidth;

    assert(
        _mapWidth <= ScreenUtil().screenWidth &&
            _mapHeight <= ScreenUtil().screenHeight,
        "mapWidth > ScreenWidth or mapHeight > screenHeight");
  }

  void addMarker(
      bool isMyLocationMarker,
      bool firstAdd,
      CustomMarker marker,
      int? index,
      BitmapDescriptor icon,
      Function({
    bool isMyLocationMarker,
    CustomMarker marker,
    int index,
    bool isInitialMarker,
  })
          onMarkerTap,
      {bool notify = true}) {
    // print("index: $index, isUser: $isMyLocationMarker");
    if (index == null || _markers.length < index || marker.location == null)
      return;

    /// If it is not the first add then we are updating an old marker and we should remove the old one first
    if (!firstAdd) {
      _markers.removeAt(index);
    }

    _markers.insert(
      index,
      Marker(
        markerId: marker.markerId!,
        position: marker.location!,
        onTap: () {
          onMarkerTap(
            isMyLocationMarker: isMyLocationMarker,
            marker: marker,
            index: index,
          );
        },
        icon: icon,
      ),
    );
    if (notify) notifyListeners();
  }

  void clear() {
    markers.clear();
    _distanceWindowData = DistanceWindowData(vOffset: 0, windowWidth: 0);
    _infoWindowData = InfoWIndowData(vOffset: 0, windowWidth: 0);
    controller = null;
  }

  void updateInfoWindowData({
    int? windowId,
    Widget Function()? windowWidget,
    bool? showWindow,
    bool? windowInScreen,
    LatLng? location,
    bool notify = true,
    double? vOffset,
    double? windowWidth,
  }) {
    _infoWindowData = _infoWindowData.copyWith(
      windowId: windowId,
      windowWidget: windowWidget,
      showWindow: showWindow,
      windowInScreen: windowInScreen,
      location: location,
      vOffset: vOffset,
      windowWidth: windowWidth,
    );
    if (notify) notifyListeners();
  }

  void updateDistanceWindowData({
    int? windowId,
    Widget Function()? windowWidget,
    bool? showWindow,
    bool? windowInScreen,
    LatLng? location,
    bool notify = true,
    double? vOffset,
    double? windowWidth,
  }) {
    _distanceWindowData = _distanceWindowData.copyWith(
      location: location,
      showWindow: showWindow,
      windowId: windowId,
      windowInScreen: windowInScreen,
      windowWidget: windowWidget,
      vOffset: vOffset,
      windowWidth: windowWidth,
    );
    if (notify) notifyListeners();
  }

  Future<bool> updateWindowScreenCoordinates(
    BuildContext? context,
    WindowType type,
  ) async {
    if (context == null || controller == null) return false;

    final _location = type == WindowType.INFO_WINDOW
        ? _infoWindowData.location
        : _distanceWindowData.location;

    final _windowWidth = type == WindowType.INFO_WINDOW
        ? _infoWindowData.windowWidth
        : _distanceWindowData.windowWidth;

    final _vOffset = type == WindowType.INFO_WINDOW
        ? _infoWindowData.vOffset
        : _distanceWindowData.vOffset;

    if (_location == null) return false;

    /// this is the coordinate of the latLng on the device screen
    Map<String, double> screenCoordinate = await _latLngToScreenCoordinate(
        _location, _windowWidth, _vOffset, context);

    if (type == WindowType.INFO_WINDOW) {
      //TODO Check for top and bottom
      _infoWindowLeftMargin = screenCoordinate["left"];
      _infoWindowTopMargin = screenCoordinate["top"];
      if (!(screenCoordinate["left"]! < 0 || screenCoordinate["top"]! < 0))
        _infoWindowData = _infoWindowData.copyWith(windowInScreen: true);
      else
        _infoWindowData = _infoWindowData.copyWith(windowInScreen: false);

      notifyListeners();
      return (_infoWindowData.windowInScreen);
    }
    if (type == WindowType.DISTANCE_WINDOW) {
      _distanceLeftMargin = screenCoordinate["left"];
      _distanceTopMargin = screenCoordinate["top"];
      _distanceRightMargin = screenCoordinate["right"];
      _distanceBottomMargin = screenCoordinate["bottom"];
      if (!(screenCoordinate["left"]! < 0 ||
          screenCoordinate["top"]! < 0 ||
          screenCoordinate["right"]! > mapWidth ||

          /// ScreenUtil().setHeight(150) is almost the height of the appbar
          screenCoordinate["bottom"]! > mapHeight)) {
        // showDistanceWindow =  false;
        _distanceWindowData =
            _distanceWindowData.copyWith(windowInScreen: true);
      } else {
        _distanceWindowData =
            _distanceWindowData.copyWith(windowInScreen: false);
      }
      notifyListeners();

      return (_distanceWindowData.windowInScreen);
    }
    return false;
  }

  ///
  /// transform latlng to screen coordinate
  ///
  Future<Map<String, double>> _latLngToScreenCoordinate(
    LatLng latLng,
    double windowWidth,
    double vOffset,
    BuildContext context,
  ) async {
    assert(controller != null);
    ScreenCoordinate screenCoordinate =
        await controller!.getScreenCoordinate(latLng);
    double devicePixelRatio =
        Platform.isAndroid ? MediaQuery.of(context).devicePixelRatio : 1.0;
    double left =
        (screenCoordinate.x.toDouble() / devicePixelRatio) - (windowWidth / 2);
    double top = (screenCoordinate.y.toDouble() / devicePixelRatio) - vOffset;

    double right = left + windowWidth;
    double bottom = top + vOffset;

    return {
      "top": top,
      "bottom": bottom,
      "right": right,
      "left": left,
    };
  }

  InfoWIndowData get infoWindowData => _infoWindowData;

  List<Marker> get markers => _markers;

  bool get showInfoWindow => _infoWindowData.showWindow;

  bool get showDistanceWindow =>
      (_distanceWindowData.showWindow && _distanceWindowData.windowInScreen)
          ? true
          : false;

  double? get infoWindowLeftMargin => _infoWindowLeftMargin;

  double? get infoWindowTopMargin => _infoWindowTopMargin;

  // double get infoWindowRightMargin => _infoWindowRightMargin;

  double? get distanceBottomMargin => _distanceBottomMargin;

  double? get distanceLeftMargin => _distanceLeftMargin;

  double? get distanceTopMargin => _distanceTopMargin;

  double? get distanceRightMargin => _distanceRightMargin;

  DistanceWindowData get distanceWindowData => _distanceWindowData;

  double get mapWidth => _mapWidth;
  double get mapHeight => _mapHeight;

  // LatLng get location => _location;

  // set showDistanceWindow(bool value) {
  //   _showDistanceWindow = value;
  //   notifyListeners();
  // }
}
