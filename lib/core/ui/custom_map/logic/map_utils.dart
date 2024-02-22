import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:starter_application/core/ui/custom_map/api/datasource/map_remote_datasource.dart';
import 'package:starter_application/core/ui/custom_map/api/model/map_distance_model.dart';
import 'package:starter_application/core/ui/custom_map/api/params/map_distance_params.dart';
import 'package:starter_application/core/ui/custom_map/extension/either_error_model_extension.dart';

/// This file Contains methods that we may use in for the CustomMap.
///
/// We use this function to transform icon images to Uint8List that we will later pass to the BitmapDescriptor
/// [Note] Every thing with logical word means the real values what we use to draw in the screen ,
/// for Example Logical pixel is the actual value that we give to height, width, top,left, ... ect
///
///
class MapUtils {
  MapUtils._();
  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  //TODO Use this in CustomMapModel
  ///
  /// transform latlng to logical screen coordinate
  ///
  static Future<Point> latLngToLogicalScreenCoordinate(
    BuildContext context, {
    required GoogleMapController controller,
    required LatLng latLng,
  }) async {
    ScreenCoordinate screenCoordinate =
        await controller.getScreenCoordinate(latLng);
    double devicePixelRatio = getDevicePixelRatio(context);

    double x = (screenCoordinate.x.toDouble() / devicePixelRatio);
    double y = (screenCoordinate.y.toDouble() / devicePixelRatio);

    return Point(x, y);
  }

  ///
  /// transform logical screen coordinate to latlng
  ///
  static Future<LatLng> logicalScreenCoordinateToLatlng(
    BuildContext context, {
    required GoogleMapController controller,
    required Point coordinate,
  }) async {
    ScreenCoordinate screenCoordinate =
        getRawScreenCoordinate(context, coordinate: coordinate);
    return controller.getLatLng(screenCoordinate);
  }

  /// Get the logical value of a pixel
  static double getLogicalPixel(
    BuildContext context,
    double value,
  ) {
    double devicePixelRatio = getDevicePixelRatio(context);
    return value / devicePixelRatio;
  }

  /// Get the raw value of a logical pixel
  static double getRawPixel(
    BuildContext context,
    double value,
  ) {
    double devicePixelRatio = getDevicePixelRatio(context);
    return value * devicePixelRatio;
  }

  /// Get the raw pixels screen coordinate from a logical pixel coordinate
  static ScreenCoordinate getRawScreenCoordinate(
    BuildContext context, {
    required Point coordinate,
  }) {
    return ScreenCoordinate(
      x: getRawPixel(context, coordinate.x.toDouble()).toInt(),
      y: getRawPixel(context, coordinate.y.toDouble()).toInt(),
    );
  }

  /// Get the logical pixel coordinate  from a raw pixels screen coordinate
  static Point getLogicalScreenCoordinate(
    BuildContext context, {
    required ScreenCoordinate coordinate,
  }) {
    return Point(
      getLogicalPixel(context, coordinate.x.toDouble()).toInt(),
      getLogicalPixel(context, coordinate.y.toDouble()).toInt(),
    );
  }

  /// This fucntion enusure that the current location is on the [targetCoordinate] of the device screen
  static Future<void> animateLatlngToCoordinate(
    BuildContext context,
    GoogleMapController? controller,
    LatLng? location,
    Point<double> targetCoordinate,
  ) async {
    if (controller == null || location == null) return;
    final oldCoordinate = await MapUtils.latLngToLogicalScreenCoordinate(
      context,
      controller: controller,
      latLng: location,
    );

    final dx = targetCoordinate.x - oldCoordinate.x;
    final dy = targetCoordinate.y - oldCoordinate.y;

    await controller.animateCamera(CameraUpdate.scrollBy(
      -dx,
      -dy,
    ));
  }

  /// Get the duration  and distance between two locations
  static Future<ElementModel?> getDistanceAndDuration(
      MapDistanceParam param) async {
    var mapDatasource = MapRemoteDataSource();
    final result = (await mapDatasource.getDistance(param)).result;
    if (result.hasDataOnly) {
      if ((result.data!.rows.length) > 0 &&
          (result.data!.rows[0].elements.length) > 0) {
        return result.data!.rows[0].elements[0];
      }
    }
    return null;
  }

  /// Get Device pexil ratio
  static double getDevicePixelRatio(BuildContext context) =>
      Platform.isAndroid ? MediaQuery.of(context).devicePixelRatio : 1.0;
}
