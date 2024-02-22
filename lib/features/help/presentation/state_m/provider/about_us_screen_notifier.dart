import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';
import '../../../../../core/params/no_params.dart';
import '../../../domain/entity/about_us_entity.dart';
import '../cubit/help_cubit.dart';

class AboutUsScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  GoogleMapController? controller;
  late LatLng kMapCenter;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  late LatLng position;
  late LatLng result;
  late Marker marker;
  late AboutUsEntity aboutUsEntity;
  final helpCubit = HelpCubit();

  /// Getters and Setters

  /// Methods
  getAboutUs() {
    print("AboutUs");
    helpCubit.getAboutUs(NoParams());
  }

  getAboutUsLoaded(AboutUsEntity entity) {
    aboutUsEntity = entity;
    notifyListeners();
  }

  initData() {
    position = LatLng(22.584770961288953, 44.7493039816618);
    kMapCenter = LatLng(position.latitude, position.longitude);
    marker = Marker(
      markerId: MarkerId('1'),
      position: LatLng(position.latitude, position.longitude),
    );
    markers[marker.markerId] = marker;
    result = LatLng(position.latitude, position.longitude);
  }

  void onMapCreated(GoogleMapController controllerParam) {
    controller = controllerParam;
    notifyListeners();
  }

  @override
  void closeNotifier() {
    this.dispose();
  }
}
