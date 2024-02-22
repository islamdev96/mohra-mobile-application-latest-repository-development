import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarker {
  final Widget Function() customInfoWindow;
  //Todo implemet this
  // final InfoWindow? infoWindow;
  final VoidCallback? onTap;
  final MarkerId? markerId;
  final Uint8List? _unSelectedIcon;
  final Uint8List? _selectedIcon;
  final BitmapDescriptor _defaultIcon;
  LatLng? location;
  final double customInfoWindowWidth;
  final double customInfoWindowHeight;
  final double? tailHeight;
  final double? tailWidth;
  final Widget Function()? tailWidget;
  final customInfoWindowVOffset;

  CustomMarker(
      {Uint8List? unSelectedIcon,
      Uint8List? selectedIcon,
      BitmapDescriptor defaultIcon = BitmapDescriptor.defaultMarker,
      this.location,
      required this.customInfoWindowWidth,
      required this.customInfoWindowHeight,
      this.tailHeight,
      this.tailWidth,
      this.tailWidget,
      this.customInfoWindowVOffset,
      required this.customInfoWindow,
      // this.infoWindow,
      this.onTap,
      this.markerId})
      : _unSelectedIcon = unSelectedIcon,
        _selectedIcon = selectedIcon,
        _defaultIcon = defaultIcon;

  

  BitmapDescriptor getMarkerIcon({bool isSelected = false}) {
    if (!isSelected) {
      return _getUnSelectedIcon();
    }
    return _selectedIcon != null
        ? BitmapDescriptor.fromBytes(_selectedIcon!)
        : _getUnSelectedIcon();
  }

  BitmapDescriptor _getUnSelectedIcon() {
    return _unSelectedIcon != null
        ? BitmapDescriptor.fromBytes(_unSelectedIcon!)
        : _defaultIcon;
  }

  bool get hasSelectedIcon => _selectedIcon != null;

  CustomMarker copyWith({
    Widget Function()? customInfoWindow,
    VoidCallback? onTap,
    MarkerId? markerId,
    Uint8List? unSelectedIcon,
    Uint8List? selectedIcon,
    BitmapDescriptor? defaultIcon,
    LatLng? location,
    double? customInfoWindowWidth,
    double? customInfoWindowHeight,
    double? tailHeight,
    double? tailWidth,
    Widget Function()? tailWidget,
  }) {
    return CustomMarker(
   customInfoWindow :   customInfoWindow ?? this.customInfoWindow,
      onTap: onTap ?? this.onTap,
      markerId: markerId ?? this.markerId,
      unSelectedIcon : unSelectedIcon ?? this._unSelectedIcon,
      selectedIcon: selectedIcon ?? this._selectedIcon,
      defaultIcon: defaultIcon ?? this._defaultIcon,
      location: location ?? this.location,
      customInfoWindowWidth: customInfoWindowWidth ?? this.customInfoWindowWidth,
      customInfoWindowHeight: customInfoWindowHeight ?? this.customInfoWindowHeight,
      tailHeight :tailHeight ?? this.tailHeight,
      tailWidth: tailWidth ?? this.tailWidth,
      tailWidget: tailWidget ?? this.tailWidget,
    );
  }
}
