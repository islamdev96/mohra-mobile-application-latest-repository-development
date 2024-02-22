import 'dart:async';
import 'dart:io';

import 'package:clippy_flutter/clippy_flutter.dart' as cf;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart' as geolocat;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/ui/custom_map/api/model/distance_result.dart';
import 'package:starter_application/core/ui/custom_map/api/params/map_distance_params.dart';
import 'package:starter_application/core/ui/custom_map/cubit/cubit.dart';
import 'package:starter_application/core/ui/custom_map/cubit/map_cubit.dart';
import 'package:starter_application/core/ui/custom_map/logic/custom_map_model.dart';
import 'package:starter_application/core/ui/custom_map/logic/custom_marker.dart';
import 'package:starter_application/core/ui/custom_map/logic/distance_window_data.dart';
import 'package:starter_application/core/ui/custom_map/logic/info_window_data.dart';
import 'package:starter_application/core/ui/custom_map/logic/location_wrapper.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/dialog/errv_dialog_options.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/generated/l10n.dart';

class CustomMap extends StatefulWidget {
  /// [custom fields]: Those are new added field or edited google map fields
  final initialIndex;
  final List<CustomMarker> markers;
  final CustomMarker? myLocationMarker;
  final String? mapApiKey;
  final ArgumentCallback<LatLng>? onTap;
  final bool? distanceInfoWindowEnabled;
  final bool disableMyLocationIcon;
  final bool disableMyLocationButton;
  final String? style;
  final double? width;
  final double? height;
  final bool mapToolbarEnabled;
  final Widget Function(String distance, String time)? distanceWindowWidget;
  final double? distanceWindowWidth;
  final double? distanceWindowHeight;
  final EdgeInsets padding;
  final MapType mapType;
  final bool zoomControlsEnabled;
  final void Function(CameraPosition)? onCameraMove;
  final CameraPosition initialCameraPosition;
  final void Function(GoogleMapController)? onMapCreated;
  final Color polylinesColor;
  final int polylinesWdith;

  /// Disabel Polylines between my location and last selected marker
  final bool disableMyLocationPolylines;

  /// Those are unused google map fields

  final bool buildingsEnabled;
  final CameraTargetBounds cameraTargetBounds;
  final bool compassEnabled;
  final MinMaxZoomPreference minMaxZoomPreference;
  final bool rotateGesturesEnabled;
  final bool scrollGesturesEnabled;
  final bool zoomGesturesEnabled;
  final bool liteModeEnabled;
  final bool tiltGesturesEnabled;
  final Set<Polygon> polygons;
  final Set<Polyline> polylines;
  final Set<Circle> circles;
  final Set<TileOverlay> tileOverlays;
  final VoidCallback? onCameraMoveStarted;
  final VoidCallback? onCameraIdle;
  final ArgumentCallback<LatLng>? onLongPress;
  final bool indoorViewEnabled;
  final bool trafficEnabled;

  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;

  CustomMap({
    Key? key,
    this.distanceWindowWidget,
    this.distanceWindowWidth,
    this.distanceWindowHeight,
    this.initialIndex,
    this.markers = const [],
    this.myLocationMarker,
    this.mapApiKey,
    this.onTap,
    this.distanceInfoWindowEnabled,
    this.disableMyLocationIcon = false,
    this.disableMyLocationButton = false,
    this.style,
    this.width,
    this.height,
    this.mapToolbarEnabled = true,
    this.padding = const EdgeInsets.all(0),
    this.mapType = MapType.normal,
    this.zoomControlsEnabled = true,
    required this.initialCameraPosition,
    this.onMapCreated,
    this.polylinesColor = Colors.blue,
    this.polylinesWdith = 5,
    this.disableMyLocationPolylines = false,
    this.buildingsEnabled = true,
    this.cameraTargetBounds = CameraTargetBounds.unbounded,
    this.circles = const <Circle>{},
    this.compassEnabled = true,
    this.gestureRecognizers = const <Factory<OneSequenceGestureRecognizer>>{},
    this.minMaxZoomPreference = MinMaxZoomPreference.unbounded,
    this.rotateGesturesEnabled = true,
    this.scrollGesturesEnabled = true,
    this.zoomGesturesEnabled = true,
    this.liteModeEnabled = false,
    this.tiltGesturesEnabled = true,
    this.indoorViewEnabled = false,
    this.trafficEnabled = false,
    this.polygons = const <Polygon>{},
    this.polylines = const <Polyline>{},
    this.onCameraMoveStarted,
    this.tileOverlays = const <TileOverlay>{},
    this.onCameraIdle,
    this.onLongPress,
    this.onCameraMove,
  }) : super(key: key);

  @override
  CustomMapState createState() => CustomMapState();
}

class CustomMapState extends State<CustomMap> {
  /// Map distance related ..
  final MapCubit _mapCubit = MapCubit();
  DistanceResult? _distanceWindowResult;

  /// --- ///
  GoogleMapController? mapController;
  StreamSubscription<LocationData>? _locationStream;

  /// this is the current selected marker, it will be null if their is no marker selected.
  int? currentSelectedMarkerIndex;

  /// for my drawn routes on the map
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints? polylinePoints;

  /// This bool used to check if initial myLocation marker was set or not
  var _initialMyLocationMarkerSet = false;

  /// info window variables
  // CustomMapModel providerObject;

  /// this bool check if MyLocation Marker info window was open (this also mean that myLocation marker is selected).
  // Todo refactor and replace this with more clear way
  bool _isMyLocationInfoWindowOpen = false;

  /// this check if we are searching for distance window location
  bool _isDistanceWindowLocationSearching = false;

  /// this is the index of myLocation custom info widget
  int? myLocationInfoWindowIndex;

  /// This is the last  selected marker even if it is not selected right now (This does't store myLocation marker index).
  int? lastSelectedMarkerIndex;

  /// for my location marker
  /// the user's initial location and current location
  /// as it moves
  LocationData? _currentLocation; // a reference to the destination location

  /// Distance window variables
  late double _distanceWindowWidth;
  late double _distanceWindowHeight;

  /// This used to prevent updateDistanceWindowLocation from being called inside onCameraMove, until setPolylines function is finshed to prevent re showing  old distance window.
  bool _isSetPolyLines = false;

  /// This object containes location related functions
  final locationWrapper = LocationWrapper();

  @override
  void initState() {
    super.initState();

    _distanceWindowWidth = widget.distanceWindowWidth ?? 140.w;
    _distanceWindowHeight = widget.distanceWindowHeight ?? 150.h;

    Provider.of<CustomMapModel>(context, listen: false).setMapDimensions(
      widget.width,
      widget.height,
    );

    polylinePoints = PolylinePoints();

    ///delete old markers
    Provider.of<CustomMapModel>(context, listen: false).clear();
    _initializeMarkers();

    /// my location marker is the last marker added to the markers list, we save its index here
    myLocationInfoWindowIndex = widget.markers.length;

    _handLocationPermissionsAndIntitalMarker();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    mapController?.dispose();
    _locationStream?.cancel();
    _mapCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MapCubit, MapState>(
      bloc: _mapCubit,
      listener: (context, state) {
        state.mapOrNull(
          mapInitial: (s) {},
          mapLoading: _mapLoading,
          mapDistanceLoaded: _mapDistanceLoaded,
          mapError: _mapError,
        );
      },
      child: Container(
        child: Consumer<CustomMapModel>(
          builder: (context, model, child) {
            return Stack(
              children: [
                child!,
                Positioned(
                  left:
                      Provider.of<CustomMapModel>(context).distanceLeftMargin ??
                          0.0,
                  top: Provider.of<CustomMapModel>(context).distanceTopMargin ??
                      0.0,
                  child: Visibility(
                    visible:
                        Provider.of<CustomMapModel>(context).showDistanceWindow,
                    child: (distanceWindowData()?.windowWidget == null ||
                            !Provider.of<CustomMapModel>(
                              context,
                            ).showDistanceWindow)
                        ? Container()
                        : distanceWindowData()!.windowWidget!(),
                  ),
                ),
                Positioned(
                  left:
                      Provider.of<CustomMapModel>(context).infoWindowLeftMargin,
                  top: Provider.of<CustomMapModel>(context).infoWindowTopMargin,
                  child: Visibility(
                    visible:
                        Provider.of<CustomMapModel>(context).showInfoWindow,
                    child: (Provider.of<CustomMapModel>(context)
                                    .infoWindowData
                                    .windowWidget ==
                                null ||
                            !Provider.of<CustomMapModel>(
                              context,
                            ).showInfoWindow)
                        ? Container()
                        : SizedBox(
                            height: (_getCurrentMarker()!.tailHeight ?? 15) +
                                (_getCurrentMarker()!.customInfoWindowHeight),
                            width: _getCurrentMarker()!.customInfoWindowWidth,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                    top: 0,
                                    child: infoWIndowData().windowWidget!()),
                                Positioned(
                                  top: _getCurrentMarker()!
                                          .customInfoWindowHeight -
                                      1,
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                    child: _getCurrentMarker()!
                                            .tailWidget
                                            ?.call() ??
                                        cf.Triangle.isosceles(
                                          edge: cf.Edge.BOTTOM,
                                          child: Container(
                                            color: Colors.white,
                                            width: _getCurrentMarker()!
                                                    .tailWidth ??
                                                20,
                                            height: _getCurrentMarker()!
                                                    .tailHeight ??
                                                15,
                                          ),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ],
            );
          },
          child: Positioned(
            child: GoogleMap(
              mapToolbarEnabled: widget.mapToolbarEnabled,
              padding: widget.padding,
              mapType: widget.mapType,
              zoomControlsEnabled: widget.zoomControlsEnabled,
              myLocationButtonEnabled: !widget.disableMyLocationButton,
              onCameraMove: onCameraMove,
              initialCameraPosition: widget.initialCameraPosition,
              onMapCreated: onMapCreated,
              myLocationEnabled: !widget.disableMyLocationIcon,
              markers: Provider.of<CustomMapModel>(
                context,
              ).markers.toSet(),
              polylines: _polylines,
              onTap: onMapTap,
              buildingsEnabled: widget.buildingsEnabled,
              cameraTargetBounds: widget.cameraTargetBounds,
              circles: widget.circles,
              compassEnabled: widget.compassEnabled,
              gestureRecognizers: widget.gestureRecognizers,
              indoorViewEnabled: widget.indoorViewEnabled,
              liteModeEnabled: widget.liteModeEnabled,
              minMaxZoomPreference: widget.minMaxZoomPreference,
              onCameraIdle: widget.onCameraIdle,
              onCameraMoveStarted: widget.onCameraMoveStarted,
              onLongPress: widget.onLongPress,
              polygons: widget.polygons,
              rotateGesturesEnabled: widget.rotateGesturesEnabled,
              scrollGesturesEnabled: widget.scrollGesturesEnabled,
              tileOverlays: widget.tileOverlays,
              tiltGesturesEnabled: widget.tiltGesturesEnabled,
              trafficEnabled: widget.trafficEnabled,
              zoomGesturesEnabled: widget.zoomGesturesEnabled,
            ),
          ),
        ),
      ),
    );
  }

  /// Getters
  InfoWIndowData infoWIndowData({bool listen = true}) =>
      Provider.of<CustomMapModel>(context, listen: listen).infoWindowData;

  DistanceWindowData? distanceWindowData({bool listen = true}) =>
      Provider.of<CustomMapModel>(context, listen: listen).distanceWindowData;

  /// Logic
  //Todo move all the logic inside the CustomMapModel
  /*LocationData _positionToLocationData(geolocat.Position position) {
    return (position != null &&
            position.longitude != null &&
            position.latitude != null)
        ? LocationData.fromMap(
            {"latitude": position.latitude, "longitude": position.longitude})
        : null;
  }*/
  void _mapError(MapError e) {
    ErrorViewer.showError(
      context: context,
      error: e.error,
      callback: e.callback,
      errorViewerOptions: const ErrVDialogOptions(
        isDismissible: true,
      ),
    );
  }

  void _mapLoading(MapLoading s) {
    _distanceWindowResult = null;
    Provider.of<CustomMapModel>(context, listen: false)
        .updateDistanceWindowData(
      showWindow: false,
    );
  }

  void _mapDistanceLoaded(MapDistanceLoaded s) {
    _distanceWindowResult = DistanceResult(
      distance: s.mapDistanceResult.rows[0].elements[0].distance!.text!,
      time: s.mapDistanceResult.rows[0].elements[0].duration!.text!,
      distanceM: s.mapDistanceResult.rows[0].elements[0].distance!.value!,
      timeSec: s.mapDistanceResult.rows[0].elements[0].duration!.value!,
    );
    _updateDistanceWindowLocation(
      locations: polylineCoordinates,
    );
    Provider.of<CustomMapModel>(context, listen: false)
        .updateDistanceWindowData(
      showWindow: false,
    );
  }

  void onCameraMove(CameraPosition langLit) {
    widget.onCameraMove?.call(langLit);

    _updateInfoWindowScreenCoordinates();

    /// Don't show old distance window while setting new polylines
    if (!_isSetPolyLines)
      _updateDistanceWindowLocation(
        locations: polylineCoordinates,
      );
  }

  void onMapTap(LatLng position) {
    widget.onTap?.call(position);
    _unSelectCurrentMarker();
  }

  void onMapCreated(GoogleMapController controller) async {
    widget.onMapCreated?.call(controller);
    mapController = controller;
    Provider.of<CustomMapModel>(context, listen: false).controller = controller;
    mapController!.setMapStyle(widget.style);
    if (widget.initialIndex != null &&
        widget.initialIndex >= 0 &&
        widget.initialIndex < (widget.markers.length)) {
      onMarkerTap(
          marker: widget.markers[widget.initialIndex],
          index: widget.initialIndex,
          isInitialMarker: true);
      mapController!.animateCamera(
        CameraUpdate.newLatLng(
          widget.markers[widget.initialIndex].location!,
        ),
      );
    }
  }

  /// Markers and InfoWindow functions

  CustomMarker? _getCurrentMarker() {
    /// If current selected marker is myLocation marker
    if (_isMyLocationInfoWindowOpen) {
      return widget.myLocationMarker!;
    }
    if (currentSelectedMarkerIndex != null) {
      return widget.markers[currentSelectedMarkerIndex!];
    }
    return null;
  }

  //Todo need test
  void setMyLocationPolylines(
    geolocat.Position? destinationLocation,
    BuildContext context, {
    bool? isInitialMarker,
  }) async {
    if (widget.disableMyLocationPolylines) return;
    setPolylines(
      _currentLocation == null
          ? null
          : geolocat.Position(
              latitude: _currentLocation!.latitude!,
              longitude: _currentLocation!.longitude!,
              accuracy: 0,
              altitudeAccuracy: 0,
              headingAccuracy: 0,
              timestamp: DateTime.now(),
              altitude: 0,
              heading: 0,
              speed: 0,
              speedAccuracy: 0,
            ),
      destinationLocation,
      context,
      isInitialMarker: isInitialMarker,
    );
  }

  void setPolylines(
    geolocat.Position? startLocation,
    geolocat.Position? destinationLocation,
    BuildContext context, {
    bool? isInitialMarker,
  }) async {
    ///clear old polyline
    _polylines.clear();

    _isSetPolyLines = true;

    /// hide the previous distance window before getting the new polylines and distance window
    if (widget.distanceInfoWindowEnabled == true) {
      Provider.of<CustomMapModel>(context, listen: false)
          .updateDistanceWindowData(
        showWindow: false,
      );
    }

    if (startLocation == null ||
        destinationLocation == null ||
        widget.mapApiKey == null) {
      if (isInitialMarker == null || !isInitialMarker) {
        // ErrorViewer.showError(
        //   context: context,
        //   error: AppErrors.customError(
        //     message: "الموقع غير متوفر",
        //   ),
        //   errorViewerOptions: ErrVDialogOptions(),
        //   callback: () => setPolylines(
        //       // currentLocation,
        //       destinationLocation,
        //       context,
        //       isInitialMarker: isInitialMarker),
        // );
      }
      return;
    }

    List<PointLatLng> points = [];
    PolylineResult? result;

    try {
      result = await polylinePoints?.getRouteBetweenCoordinates(
        widget.mapApiKey!,
        PointLatLng(
          startLocation.latitude,
          startLocation.longitude,
        ),
        PointLatLng(
          destinationLocation.latitude,
          destinationLocation.longitude,
        ),
      );
      points = result?.points ?? [];
    } on SocketException catch (_) {
      ErrorViewer.showError(
        context: context,
        error: CustomError(
          message: Translation.of(context).connectionErrorMessage,
        ),
        callback: () => setMyLocationPolylines(
          // currentLocation,
          destinationLocation,
          context,
          isInitialMarker: isInitialMarker,
        ),
        errorViewerOptions: const ErrVDialogOptions(),
      );
    } catch (_) {
      ErrorViewer.showError(
        context: context,
        error: CustomError(
          message: Translation.of(context).mapPathError,
        ),
        callback: () => setMyLocationPolylines(
            // currentLocation,
            destinationLocation,
            context,
            isInitialMarker: isInitialMarker),
        errorViewerOptions: const ErrVDialogOptions(),
      );
      return;
    }

    if (!mounted) return;

    /// clear old poly lines coordinates
    polylineCoordinates.clear();

    if (points.isNotEmpty) {
      points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      if (widget.distanceInfoWindowEnabled == true) {
        /// get the distance and duration info between start and destination
        await _getDistanceMatrixApiData(
          LatLng(startLocation.latitude, startLocation.longitude),
          LatLng(destinationLocation.latitude, destinationLocation.longitude),
        );

        /// set the visibility of the distance window to false after getting new polyline because the location of the window does't update if it is visible

        Provider.of<CustomMapModel>(context, listen: false)
            .updateDistanceWindowData(
          showWindow: false,
        );

        _updateDistanceWindowLocation(
          locations: polylineCoordinates,
        );
      }

      setState(() {
        _polylines.add(Polyline(
            width: widget.polylinesWdith, // set the width of the polylines
            polylineId: const PolylineId("poly"),
            color: widget.polylinesColor,
            points: polylineCoordinates));
      });
    }

    _isSetPolyLines = false;
  }

  void _unSelectCurrentMarker() {
    if (Provider.of<CustomMapModel>(context, listen: false).showInfoWindow) {
      Provider.of<CustomMapModel>(context, listen: false).updateInfoWindowData(
        showWindow: false,
      );
    }
    currentSelectedMarkerIndex = null;

    /// set myLocation marker icon to unSelected
    if (_isMyLocationInfoWindowOpen && widget.myLocationMarker != null) {
      BitmapDescriptor icon =
          widget.myLocationMarker!.getMarkerIcon(isSelected: false);
      Provider.of<CustomMapModel>(context, listen: false).addMarker(
        true,
        false,
        widget.myLocationMarker!,
        myLocationInfoWindowIndex,
        icon,
        onMarkerTap,
      );
    }

    _isMyLocationInfoWindowOpen = false;

    /// set last selected marker icon to  unSelected
    if (lastSelectedMarkerIndex != null) {
      CustomMarker marker = widget.markers[lastSelectedMarkerIndex!];

      /// If the marker don't have unSelected Icon then we don't need to reset marker icon to unSelected
      if (marker.hasSelectedIcon) {
        Provider.of<CustomMapModel>(context, listen: false).addMarker(
            false,
            false,
            marker,
            lastSelectedMarkerIndex,
            marker.getMarkerIcon(isSelected: false),
            onMarkerTap);
      }
    }

    // });
  }

  _initializeMarkers() {
    for (int index = 0; index < widget.markers.length; index++) {
      CustomMarker marker = widget.markers[index];

      BitmapDescriptor icon = marker.getMarkerIcon(isSelected: false);
      // : BitmapDescriptor.defaultMarker;

      // MapOrderParam order = widget.markers[index];
      Provider.of<CustomMapModel>(context, listen: false).addMarker(
          false, true, marker, index, icon, onMarkerTap,
          notify: false);
    }
  }

  ///
  /// This function will show info window in the selected location and update the selected and unselected markers icons
  ///
  _changeInfoWindowAndMarker({
    /// the marker index is the windowId
    required int windowId,
    required CustomMarker customMarker,
    required bool isMyLocationInfoWindow,
  }) {
    int? tempPrevInfoWindowId = infoWIndowData(listen: false).windowId;

    Provider.of<CustomMapModel>(context, listen: false).updateInfoWindowData(
      windowWidget: customMarker.customInfoWindow,
      windowId: windowId,
      location: customMarker.location,
      vOffset: customMarker.customInfoWindowVOffset,
      windowWidth: customMarker.customInfoWindowWidth,
      showWindow: true,
      notify: false,
    );

    _updateInfoWindowScreenCoordinates();

    BitmapDescriptor icon = infoWIndowData(listen: false).windowId == windowId
        ? customMarker.getMarkerIcon(isSelected: true)
        : customMarker.getMarkerIcon(isSelected: false);

    Provider.of<CustomMapModel>(context, listen: false).addMarker(
        isMyLocationInfoWindow,
        false,
        customMarker,
        windowId,
        icon,
        onMarkerTap);

    /// set myLocation marker icon to unSelected

    if (!isMyLocationInfoWindow &&
        tempPrevInfoWindowId == myLocationInfoWindowIndex &&
        widget.myLocationMarker != null) {
      BitmapDescriptor icon =
          widget.myLocationMarker!.getMarkerIcon(isSelected: false);
      // : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)

      Provider.of<CustomMapModel>(context, listen: false).addMarker(
          true,
          false,
          widget.myLocationMarker!,
          myLocationInfoWindowIndex,
          icon,
          onMarkerTap);
    }

    /// set last selected marker icon to  unSelected
    if (lastSelectedMarkerIndex != null &&
        lastSelectedMarkerIndex != windowId) {
      BitmapDescriptor icon = widget.markers[lastSelectedMarkerIndex!]
          .getMarkerIcon(isSelected: false);

      Provider.of<CustomMapModel>(context, listen: false).addMarker(
          false,
          false,
          widget.markers[lastSelectedMarkerIndex!],
          lastSelectedMarkerIndex,
          icon,
          onMarkerTap);
    }
  }

  ///
  /// This function will update the current Marker info window coordinates in the screen as needed
  ///
  _updateInfoWindowScreenCoordinates() {
    Provider.of<CustomMapModel>(context, listen: false)
        .updateWindowScreenCoordinates(
      context,
      WindowType.INFO_WINDOW,
    );
  }

  ///
  /// This function will update the location of MyLocation marker and its infoWindow if it was open.
  ///
  void _updateMyLocationMarker() {
    if (widget.myLocationMarker == null || !isUserLocationAvilable()) return;
    _isMyLocationInfoWindowOpen = false;

    if (infoWIndowData(listen: false).windowWidget != null &&
        infoWIndowData(listen: false).windowId == myLocationInfoWindowIndex &&
        infoWIndowData(listen: false).showWindow) {
      _isMyLocationInfoWindowOpen = true;
    }

    /// this is the user new location
    LatLng yourLocation = LatLng(
      _currentLocation!.latitude!,
      _currentLocation!.longitude!,
    );
    widget.myLocationMarker!.location = yourLocation;

    BitmapDescriptor icon;
    icon = _isMyLocationInfoWindowOpen
        ? widget.myLocationMarker!.getMarkerIcon(isSelected: true)
        : widget.myLocationMarker!.getMarkerIcon(isSelected: false);
    // : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)

    Provider.of<CustomMapModel>(context, listen: false).addMarker(
        true,
        !_initialMyLocationMarkerSet,
        widget.myLocationMarker!,
        myLocationInfoWindowIndex,
        icon,
        onMarkerTap);

    /// this will update the location of myLocation marker info window if it was opened
    if (_isMyLocationInfoWindowOpen) {
      Provider.of<CustomMapModel>(context, listen: false).updateInfoWindowData(
        location: widget.myLocationMarker!.location,
        notify: false,
      );
      _updateInfoWindowScreenCoordinates();
    }

    _initialMyLocationMarkerSet = true;
  }

  void onMarkerTap(
      {bool? isMyLocationMarker,
      CustomMarker? marker,
      int? index,
      bool? isInitialMarker}) async {
    _isMyLocationInfoWindowOpen =
        isMyLocationMarker == null ? false : isMyLocationMarker;

    /// if the selected marker is my Location marker then the current selected marker is null;
    currentSelectedMarkerIndex =
        isMyLocationMarker == true ? myLocationInfoWindowIndex : index;

    if (marker?.onTap != null) marker!.onTap!();

    // _scrollToIndex(orderIndex);

    int? tempLastSelectedMarkerIndex = lastSelectedMarkerIndex;
    _changeInfoWindowAndMarker(
      customMarker: marker!,
      windowId: index!,
      isMyLocationInfoWindow:
          isMyLocationMarker == null ? false : isMyLocationMarker,
    );
    if (index != myLocationInfoWindowIndex) lastSelectedMarkerIndex = index;

    if (isMyLocationMarker != true) {
      _isMyLocationInfoWindowOpen = false;

      if ((tempLastSelectedMarkerIndex != index || _polylines.isEmpty)) {
        setMyLocationPolylines(
          geolocat.Position(
            altitudeAccuracy: 0,
            headingAccuracy: 0,
            longitude: marker.location!.longitude,
            latitude: marker.location!.latitude,
            accuracy: 0,
            timestamp: DateTime.now(),
            altitude: 0,
            heading: 0,
            speed: 0,
            speedAccuracy: 0,
          ),
          context,
          isInitialMarker: isInitialMarker,
        );
      }
    }
  }

  ///
  /// This function will set the user initial location
  ///
  void getInitialMarkerPolylines(bool hasLocationPermissions) async {
    ///If we don't has all the location permssions return and stop execution
    if (!hasLocationPermissions) return;

    /// get the initial location by pulling the user's
    /// current location from the location's getLocation()
    if (_currentLocation == null) {
      _currentLocation = await getMyLocation();
      if (_currentLocation == null) return;
      _updateMyLocationMarker();
    }

    if ((widget.initialIndex != null &&
        widget.initialIndex >= 0 &&
        widget.initialIndex < widget.markers.length &&
        widget.initialIndex == currentSelectedMarkerIndex &&
        _polylines.isEmpty)) {
      setMyLocationPolylines(
        geolocat.Position(
          longitude: widget.markers[widget.initialIndex].location!.longitude,
          latitude: widget.markers[widget.initialIndex].location!.latitude,
          accuracy: 0,
          altitudeAccuracy: 0,
          headingAccuracy: 0,
          timestamp: DateTime.now(),
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
        ),
        context,
      );
    }
  }

  /// DistanceWindow realted functions

  Future<void> _getDistanceMatrixApiData(
      LatLng? origin, LatLng? destination) async {
    if (origin == null || destination == null) return;
    _mapCubit.getDistance(
      MapDistanceParam(
        source: origin,
        destination: destination,
        apiKey: widget.mapApiKey,
      ),
      context: context,
    );
  }

  Widget _buildDistanceWindow() {
    if (_distanceWindowResult == null) return Container();
    if (widget.distanceWindowWidget != null)
      return widget.distanceWindowWidget!(
          _distanceWindowResult!.distance, _distanceWindowResult!.time);

    return SizedBox(
      height: _distanceWindowHeight,
      width: _distanceWindowWidth,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Card(
          elevation: 1,
          color: Theme.of(context).backgroundColor,
          child: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  _distanceWindowResult!.time,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  _distanceWindowResult!.distance,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _updateDistanceWindowLocation({
    List<LatLng>? locations,
  }) async {
    if (widget.distanceInfoWindowEnabled != true) return;

    /// the number of locations that we will ignore from the start and from the end of locations array
    int locationLimits = 3;

    bool success = false;
    Provider.of<CustomMapModel>(context, listen: false)
        .updateDistanceWindowData(
      windowWidth: _distanceWindowWidth,
      vOffset: _distanceWindowHeight,
      windowWidget: _buildDistanceWindow,
      notify: false,
    );
    if (Provider.of<CustomMapModel>(context, listen: false)
        .showDistanceWindow) {
      success = await Provider.of<CustomMapModel>(context, listen: false)
          .updateWindowScreenCoordinates(
        context,
        WindowType.DISTANCE_WINDOW,
      );
    }
    if (locations != null &&
        locations.length > locationLimits &&
        !_isDistanceWindowLocationSearching &&
        !success) {
      /// we use this boolean to prevent running multiple searches in the same time
      _isDistanceWindowLocationSearching = true;

      for (int i = 3; i < locations.length - 3; i++) {
        Provider.of<CustomMapModel>(context, listen: false)
            .updateDistanceWindowData(
          location: locations[i],
          notify: false,
        );
        success = await Provider.of<CustomMapModel>(context, listen: false)
            .updateWindowScreenCoordinates(
          context,
          WindowType.DISTANCE_WINDOW,
        );
        if (success) break;
      }
      _isDistanceWindowLocationSearching = false;
    }
    Provider.of<CustomMapModel>(context, listen: false)
        .updateDistanceWindowData(
      showWindow: success,
    );
  }

  /// Map Location realted functions

  bool isUserLocationAvilable() {
    return (this._currentLocation != null &&
        this._currentLocation!.longitude != null &&
        this._currentLocation!.latitude != null);
  }

  /// Get the current location of the user and if nut available return the latest available loaction
  Future<LocationData?> getMyLocation() async {
    final result = await locationWrapper.getMyLocation();
    return result ?? _currentLocation;
  }

  Future<bool> _locationChangesListener() async {
    // await Permission.location.request();
    bool hasLocationPermissions =
        await locationWrapper.checkLocationPermissons();
    if (hasLocationPermissions) {
      // if (!(await _getLocationPermission())) return;

      /// subscribe to changes in the user's location
      /// by "listening" to the location's onLocationChanged event
      _locationStream = locationWrapper.location.onLocationChanged.listen(
        (LocationData cLoc) {
          /// cLoc contains the lat and long of the
          /// current user's position in real time,
          /// so we're holding on to it
          _currentLocation = cLoc;

          _updateMyLocationMarker();
        },
      ); // set custom marker pins
    }
    return hasLocationPermissions;
  }

  /// got to the user location
  moveToUserLocation({bool openMyLocationInfoWindow = false}) async {
    _currentLocation = await getMyLocation();

    if (!isUserLocationAvilable()) {
      return;
    }

    _updateMyLocationMarker();
    if (openMyLocationInfoWindow)
      onMarkerTap(
          index: myLocationInfoWindowIndex,
          isInitialMarker: false,
          marker: widget.myLocationMarker,
          isMyLocationMarker: true);

    mapController?.animateCamera(CameraUpdate.newLatLng(
        LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!)));
  }

  /// Check for location permission and listen to location change then getInitialMarkerPlylines
  void _handLocationPermissionsAndIntitalMarker() async {
    /// ask for locations permissions and listen on my location position changes.
    bool hasLocationPermissions = await _locationChangesListener();

    /// get Initial Marker Polylines
    getInitialMarkerPolylines(hasLocationPermissions);
  }
}
