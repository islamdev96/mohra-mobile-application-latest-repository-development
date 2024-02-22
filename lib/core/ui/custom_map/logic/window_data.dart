import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class WindowData {
  /// The WindowId is the index of the window marker except for distance window(it dosen't have a marker)
  final int? windowId;
  final Widget Function()? windowWidget;
  final bool showWindow;
  final LatLng? location;
  final double windowWidth;
  final double vOffset;

  /// This Check if the  window is inside the screen coordinate
  final bool windowInScreen;

  WindowData({
    this.windowId,
    this.windowWidget,
    this.showWindow = false,
    this.windowInScreen = false,
    this.location,
    required this.vOffset,
    required this.windowWidth,
  });
}
