import 'dart:async';
import 'package:geocoding/geocoding.dart' as Geo;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_error_snackbar.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/features/account/domain/entity/city_entity.dart';
import 'package:starter_application/features/user/data/model/request/create_address_params.dart';
import 'package:starter_application/features/user/data/model/request/get_city_params.dart';
import 'package:starter_application/features/user/domain/entity/addresses_entity.dart';
import 'package:starter_application/features/user/presentation/screen/view_profile_screen.dart';
import 'package:starter_application/features/user/presentation/state_m/cubit/user_cubit.dart';
import 'package:starter_application/generated/l10n.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';

class EditAddressScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final userCubit = UserCubit();
  late AddressEntity addressBeforEditing;
  TextEditingController streetController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  GoogleMapController? controller;
  BitmapDescriptor? _markerIcon;
  late Marker marker;

  late LatLng kMapCenter;

  late LatLng position;
  late LatLng result;

  /// Getters and Setters

  initData() {
    cityController.text = '';
    streetController.text = addressBeforEditing.street ?? '';
    cityController.text = addressBeforEditing.cityName ?? '';
    descriptionController.text = addressBeforEditing.description ?? '';
    position = LatLng(
        addressBeforEditing.latitude ?? 0, addressBeforEditing.longitude ?? 0);
    kMapCenter = LatLng(position.latitude, position.longitude);
    marker = Marker(
      markerId: MarkerId('1'),
      position: LatLng(position.latitude, position.longitude),
    );
    markers[marker.markerId] = marker;
    result = LatLng(position.latitude, position.longitude);
  }

  /// Methods

  onUpdateTapped() {
    if (canUpdate()) {
      makeUpdateRequest();
    }
  }

  canUpdate() {
    if (streetController.text.isEmpty || cityController.text.isEmpty)
      return false;
    return true;
  }


  makeUpdateRequest() {
    print('aaaaaaaaaaaaaaaaa');
    print(addressBeforEditing.id);
    CreateAddressParams createAddressParams = CreateAddressParams(
      id: addressBeforEditing.id,
      cityName: cityController.text,
      street: streetController.text,
      description: descriptionController.text,
      longitude: result.longitude,
      latitude: result.latitude,
      isCreateRequest: false,
    );
    userCubit.updateAddress(createAddressParams);
    print(createAddressParams);
  }

  getSelectedLocationInfo() async {
    List<Geo.Placemark> placemarks = await Geo.placemarkFromCoordinates(result.latitude, result.longitude);
    print('finalll');
    cityController.text = placemarks.reversed.last.locality ?? '' ;
    streetController.text = placemarks.reversed.last.street  ?? '';
    print(placemarks.reversed.last.name);
  }


  onAddressUpdated(AddressEntity addressEntity) async {
    //UserSessionDataModel.updateUserAddress(addressEntity);
    showSnackbar(Translation.current.updated_successfully);
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

    markers[id] = _marker;
    notifyListeners();
    result = newP;
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
      print('asdas');
      result = kMapCenter;
    }
    return result;
  }
}
