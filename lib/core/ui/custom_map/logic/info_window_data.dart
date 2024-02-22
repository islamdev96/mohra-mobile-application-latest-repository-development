import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'window_data.dart';

class InfoWIndowData extends WindowData {
  InfoWIndowData(
      {int? windowId,
      Widget Function()? windowWidget,
      bool showWindow = false,
      bool windowInScreen = false, LatLng? location,required double vOffset,
      required double windowWidth})
      : super(
          windowId: windowId,
          windowWidget: windowWidget,
          showWindow: showWindow,
          windowInScreen: windowInScreen,
          location: location,
          vOffset: vOffset,
            windowWidth: windowWidth
        );
        

        

  InfoWIndowData copyWith({
    int? windowId,
    Widget Function()? windowWidget,
    bool? showWindow,
    bool? windowInScreen,
    LatLng? location,
     double? vOffset,
       double? windowWidth
  }) {
    return InfoWIndowData(
      windowId: windowId ?? this.windowId,
      windowWidget: windowWidget ?? this.windowWidget,
      showWindow: showWindow ?? this.showWindow,
      windowInScreen: windowInScreen ?? this.windowInScreen,
      location: location ?? this.location,
     vOffset: vOffset ?? this.vOffset,
      windowWidth: windowWidth ?? this.windowWidth,
    );
  }

  
}
