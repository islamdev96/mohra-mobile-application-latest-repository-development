import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/moment/data/model/request/find_place_param.dart';
import 'package:starter_application/features/moment/domain/entity/find_place_result_list_entity.dart';
import 'package:starter_application/features/moment/presentation/screen/select_place_screen.dart';
import 'package:starter_application/features/moment/presentation/state_m/cubit/moment_cubit.dart';

import '../../../../../../core/common/costum_modules/screen_notifier.dart';
import '../../../../../core/common/utils.dart';
import '../../../../../core/entities/nearby_places_entity.dart';
import '../../../../../core/params/nearby_places_param.dart';
import '../../../../religion/presentation/state_m/cubit/religion_cubit.dart';

class SelectPlaceScreenNotifier extends ScreenNotifier {
  SelectPlaceScreenNotifier(this.param);

  /// Fields
  late BuildContext context;
  late String authToken;
  final SelectPlaceScreenParam param;
  final MomentCubit findPlaceCubit = MomentCubit();
  final searchController = TextEditingController(text: null);
  final searchFocusNode = FocusNode();
  final searchKey = GlobalKey<FormFieldState>();
  List<FindPlaceResultEntity> _places = [];
  List<FindPlaceResultEntity> _nearPlaces = [];
  final findMosquesCubit = ReligionCubit();
  LatLng? myLocation;
  NearbyPlacesEntity? nearbyPlacesEntity;
  bool getNearbyplacesLoading = false;
  bool isNear = true;

  /// Getters and Setters
  List<FindPlaceResultEntity> get places => this._places;

  List<FindPlaceResultEntity> get nearPlaces => this._nearPlaces;

  set places(List<FindPlaceResultEntity> places) {
    this._places = places;
    notifyListeners();
  }

  set nearPlaces(List<FindPlaceResultEntity> places) {
    this._nearPlaces = places;
    notifyListeners();
  }

  /// Methods
  void onSearchSubmitted() {
    sendSearchRequest();
  }

  void getNearbyplaces() async {
    if (myLocation != null) {
      nearbyPlacesEntity = await findMosquesCubit.getNearbyPlaces(
          nearbyPlacesParam(
              location: myLocation!,
              keyword: searchController.text,
              type: "places"));
    }
    createPlacesList();
    notifyListeners();
  }

  createPlacesList() {
    List<FindPlaceResultEntity> list = [];
    nearbyPlacesEntity!.results.forEach((element) {
      list.add(FindPlaceResultEntity(
          formattedAddress: "",
          geometry: element.geometry,
          name: element.name));
    });
    nearPlaces = list;
    notifyListeners();
  }

  void sendSearchRequest() {
    if (searchController.text.isEmpty) {
      isNear = true;
      notifyListeners();
    } else {
      isNear = false;
      notifyListeners();
      findPlaceCubit.findPlace(
        FindPlaceParam(
          input: searchController.text,
        ),
      );
    }
  }

  void onSelectPlaceTap(int index) {
    param.onPlaceSelected?.call([places[index]]);
    Nav.pop();
  }

  void onSelectNeaPlaceTap(int index) {
    param.onPlaceSelected?.call([nearPlaces[index]]);
    Nav.pop();
  }

  getLocation() async {
    getNearbyplacesLoading = true;
    notifyListeners();
    final location = await getUserLocationLogic(
        onBackTap: () {
          Nav.pop();
        },
        onRetryTap: () {
          getLocation();
          Nav.pop();
        },
        withoutDialogue: true);
    if (location != null) {
      myLocation = LatLng(location.latitude, location.longitude);
      getNearbyplaces();
      notifyListeners();
    }
    getNearbyplacesLoading = false;
    notifyListeners();
  }

  void makeNearTrue() {
    isNear = true;
    notifyListeners();
  }

  @override
  void closeNotifier() {
    findMosquesCubit.close();
    findPlaceCubit.close();
    searchFocusNode.dispose();
    searchController.dispose();
    this.dispose();
  }
}
