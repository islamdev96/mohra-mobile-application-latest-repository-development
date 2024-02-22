import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/entities/nearby_places_entity.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/nearby_places_param.dart';
import 'package:starter_application/features/religion/presentation/state_m/cubit/religion_cubit.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class FindMosqueScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final findMosquesCubit = ReligionCubit();
  late LatLng userLocation;
  bool _isLocationReady = false;
  List<PlaceEntity> _mosques = [];

  final searchKey = GlobalKey<FormFieldState<String>>();

  final searchController = TextEditingController();

  final searchFocusNode = FocusNode();

  /// Getters and Setters
  bool get isLocationReady => this._isLocationReady;
  List<PlaceEntity> get mosques => this._mosques;

  /// Methods

  void getNearbyMosques() {
    findMosquesCubit.getNearbyMosques(nearbyPlacesParam(
      location: userLocation,
      keyword: searchController.text,
    ));
  }

  void onNearbyMosquesLoaded(List<PlaceEntity> mosques) {
    _mosques = mosques;
    notifyListeners();
  }

  @override
  void closeNotifier() {
    findMosquesCubit.close();
    searchFocusNode.dispose();
    searchController.dispose();
    this.dispose();
  }

  Future<void> getLocationAndNearbyMosques() async {
    final location = await getUserLocationLogic(onBackTap: () {
      Nav.pop();
      Nav.pop();
    }, onRetryTap: () {
      getLocationAndNearbyMosques();
      Nav.pop();
    });
    _isLocationReady = location != null;
    notifyListeners();
    if (_isLocationReady) {
      userLocation = location!;
      getNearbyMosques();
    }
  }

  onSearchFieldSubmitted(String p1) {
    getNearbyMosques();
  }
}
