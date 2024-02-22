import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as Geo;
import 'package:location/location.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/account/domain/entity/city_entity.dart';
import 'package:starter_application/features/place/data/model/request/reverse_geocoding_params.dart';
import 'package:starter_application/features/place/domain/entity/reverse_geocoding_entity.dart';
import 'package:starter_application/features/place/domain/usecase/get_reverse_geocoding_usecase.dart';
import 'package:starter_application/features/place/presentation/state_m/cubit/place_cubit.dart';
import 'package:starter_application/features/user/presentation/state_m/cubit/user_cubit.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';
import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_error_snackbar.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/features/user/data/model/request/create_address_params.dart';
import 'package:starter_application/features/user/data/model/request/get_city_params.dart';
import 'package:starter_application/features/user/domain/entity/addresses_entity.dart';
import 'package:starter_application/generated/l10n.dart';

class AddNewAddressScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final userCubit = UserCubit();
  final placeCubit = PlaceCubit();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isFetching = false;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  GoogleMapController? controller;
  BitmapDescriptor? _markerIcon;
  late Marker marker;
  late LatLng kMapCenter;
  late LatLng position;
  late LatLng result;

  getSelectedLocationInfo() async {
    isFetching = true;
    notifyListeners();
    List<Geo.Placemark> placemarks = await Geo.placemarkFromCoordinates(result.latitude, result.longitude);

    print('finalll');
    cityController.text = placemarks.reversed.last.locality ?? '' ;
    streetController.text = placemarks.reversed.last.street  ?? '';
    isFetching = false;
    notifyListeners();
  }



  /// Getters and Setters

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

  /// Methods

  onCreateTapped() {
    if (canCreate()) {
      makeCreateRequest();
    }
  }

  canCreate() {
    if (cityController.text.isEmpty) {
      showErrorSnackBar(
        message: Translation.current.select_city_error,
      );
      return false;
    }
    if (streetController.text.isEmpty) {
      showErrorSnackBar(
        message: Translation.current.street_error,
      );
      return false;
    }

    return true;
  }

  makeCreateRequest() {
    CreateAddressParams createAddressParams = CreateAddressParams(
      cityName: cityController.text,
      street: streetController.text,
      description: descriptionController.text,
      longitude: result.longitude,
      latitude: result.latitude,
      isCreateRequest: true,
    );
    print(createAddressParams);
    userCubit.addAddress(createAddressParams);
  }

  onAddressAdded() async {
    //UserSessionDataModel.updateUserAddress(addressEntity);
    showSnackbar(Translation.current.added_successfully);
    // Nav.pop(context , true);
  }

  updateMarker(id, LatLng newP) {
    final marker =
        markers.values.toList().firstWhere((item) => item.markerId == id);
    print(marker.markerId);
    Marker _marker = Marker(
      markerId: marker.markerId,
      onTap: () {
        print("tapped");
      },
      position: LatLng(newP.latitude, newP.longitude),
      icon: marker.icon,
    );
    print(newP.latitude);
    print(newP.longitude);
    markers[id] = _marker;
    result = newP;
    notifyListeners();
    getSelectedLocationInfo();
  }

  Future<void> createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      final ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: const Size.square(48));
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, 'assets/red_square.png')
          .then(_updateBitmap);
    }
  }

  void _updateBitmap(BitmapDescriptor bitmap) {
    _markerIcon = bitmap;
    notifyListeners();
  }

  void onMapCreated(GoogleMapController controllerParam) {
    controller = controllerParam;
    notifyListeners();
  }

  @override
  void closeNotifier() {
    this.dispose();
  }

  Future<LatLng> currentLocation() async {
    LocationData? currentLocation;
    late LatLng result;
    var location = new Location();
    try {
      await location.getLocation().then((value) {
        result = LatLng(value.latitude!, value.longitude!);
      });
    } on Exception {
      result = kMapCenter;
    }
    return result;
  }
}
