import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/custom_file_type.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/custom_map/logic/location_wrapper.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_error_snackbar.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/friend/presentation/screen/select_friends_screen.dart';
import 'package:starter_application/features/moment/data/model/request/create_post_param.dart';
import 'package:starter_application/features/moment/presentation/screen/create_feeling_screen.dart';
import 'package:starter_application/features/moment/presentation/screen/select_place_screen.dart';
import 'package:starter_application/features/moment/presentation/state_m/cubit/moment_cubit.dart';
import 'package:starter_application/features/place/data/model/request/reverse_geocoding_params.dart';
import 'package:starter_application/features/place/domain/entity/reverse_geocoding_entity.dart';
import 'package:starter_application/features/place/presentation/state_m/cubit/place_cubit.dart';
import 'package:starter_application/features/upload/data/model/request/upload_image_param.dart';
import 'package:starter_application/features/upload/domain/usecase/upload_usecase.dart';
import 'package:starter_application/generated/l10n.dart';

import '/core/ui/custom_map/logic/location_extesions.dart';
import 'create_post_screen_notifier.dart';

class CreateFeelingScreenNotifier extends ScreenNotifier {
  /// Constructor
  CreateFeelingScreenNotifier(this.param) {
    _taggedFriends = this
            .param
            .post
            ?.tags
            ?.map((e) => CreatePostFriend(
                  id: e.clientId,
                  name: e.clientName,
                ))
            .toList() ??
        [];
    _selectedPlace =
        this.param.post?.placeName != null || this.param.post?.location != null
            ? CreatePostPlace(
                location: this.param.post!.location,
                name: this.param.post?.placeName)
            : null;
    _selectedFeelingIndex = AppConstants.feelings.indexWhere(
      (element) => element.name == this.param.post?.caption,
    );
    matchedLocationFuture =
        !isVerifyChallenge ? null : getMatchedLocationLatLng();
  }

  /// Variables
  final MomentCubit createFeelingCubit = MomentCubit();
  final PlaceCubit reverseGeocodingCubit = PlaceCubit();

  final CreateFeelingScreenParam param;
  late final Future<LatLng>? matchedLocationFuture;
  List<CreatePostFriend> _taggedFriends = [];
  CreatePostPlace? _selectedPlace;
  int? _selectedFeelingIndex = null;
  bool _isLoading = false;

  /// Getters and setters
  CreatePostPlace? get selectedPlace => this._selectedPlace;

  List<CreatePostFriend> get taggedFriends => this._taggedFriends;

  int? get selectedFeelingIndex => this._selectedFeelingIndex;
  bool get isLoading => this._isLoading;
  bool get isVerifyChallenge => challengeId != null && challengeId != 0;
  int? get challengeId => param.challengeId ?? param.post?.challengeId;

  set isLoading(bool value) {
    this._isLoading = value;
    notifyListeners();
  }

  /// Methods
  @override
  void closeNotifier() {
    createFeelingCubit.close();
    reverseGeocodingCubit.close();
    this.dispose();
  }

  void onCreateFeelingTap() {
    createEditFeelingRequest();
  }

  void createEditFeelingRequest() async {
    /// If the post is verify challenge and the matched location is not received yet show error message
    if (isVerifyChallenge && _selectedPlace == null) {
      showErrorSnackBar(
        message: Translation.current.match_location_not_complete_yet,
      );
      return;
    }
    if (_selectedFeelingIndex != null) {
      isLoading = true;

      /// Get the feeling
      final feeling = AppConstants.feelings[_selectedFeelingIndex!];

      /// Get the feeling icon real path
      final feelingIconPath = (await getImageFileFromAssets(feeling.path)).path;

      /// Upload feeling icon
      final uploadResult = await getIt<UploadFileUseCase>()(
        UploadFileParams(
          path: feelingIconPath,
          type: CustomFileType.IMAGE,
        ),
      );

      /// If Icon uploaded successfully Get Uploaded icon url and create feeling  else show error
      if (uploadResult.hasDataOnly) {
        /// Get Uploaded icon url
        final uploadedIconUrl = uploadResult.data?.url;

        /// Create/Update feeling param
        final createEditFeelingParam = CreateEditPostParam(
          id: param.post?.id,
          caption: feeling.translationKey,
          feelingIconUrl: uploadedIconUrl,
          tags: taggedFriends.length > 0
              ? taggedFriends.map((e) => e.id).whereType<int>().toList()
              : null,
          placeName: selectedPlace?.name,
          lat: selectedPlace?.location?.latitude,
          long: selectedPlace?.location?.longitude,
          // lat: 0,
          // long: 0,
          challengeId: isVerifyChallenge ? challengeId : null,
        );

        /// Send Create feeling request
        if (param.post == null) {
          createFeelingCubit.createPost(
            createEditFeelingParam,
          );
        } else {
          createFeelingCubit.editPost(
            createEditFeelingParam,
          );
        }
      } else {
        /// Show Error when upload icon failed
        isLoading = false;
        ErrorViewer.showError(
          context: AppConfig().appContext,
          error: uploadResult.error!,
          callback: () => createEditFeelingRequest(),
        );
      }
    } else {
      showErrorSnackBar(
        message: Translation.current.select_feeling,
      );
    }
  }

  onTagFriendsTap() {
    Nav.to(
      SelectFriendsScreen.routeName,
      arguments: SelectFriendsScreenParam(onSelectFriends: (friends) {
        _taggedFriends = friends
            .map(
              (e) => CreatePostFriend(
                id: e.friendId,
                name: e.friendInfo?.fullName,
              ),
            )
            .toList();
        notifyListeners();
      }),
    );
  }

  void onSelectPlaceTap() {
    Nav.to(
      SelectPlaceScreen.routeName,
      arguments: SelectPlaceScreenParam(
        onPlaceSelected: (places) {
          final placeLocation = places[0].geometry?.location?.latLng;
          if (places.length > 0)
            _selectedPlace = CreatePostPlace(
              location: placeLocation,
              name: places[0].name,
            );
          notifyListeners();
        },
      ),
    );
  }

  void onReverseGeocodingLoaded(ReverseGeocodingEntity reverseGeocodingEntity) {
    if (reverseGeocodingEntity.results.length > 0) {
      final place = reverseGeocodingEntity.results.first;
      final placeLocation = place.geometry?.location?.latLng;
      _selectedPlace = CreatePostPlace(
        location: placeLocation,
        // location: "24.307115378857237,47.34487268371582",
        name: place.formattedAddress,
      );
      notifyListeners();
    }
  }

  Future<LatLng> getMatchedLocationLatLng() async {
    LatLng? latlng;
    await Future.doWhile(() async {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      latlng = LatLng(position.latitude, position.longitude);
      return latlng == null;
    });
    debugPrint(
        "${Translation.current.matched_location}: ${latlng!.latitude},${latlng!.longitude}}");
    reverseGeocodingCubit.getReverseGeocoding(ReverseGeocodingParam(
      latlng: latlng!,
      apiKey: AppConstants.API_KEY_GOOGLE_MAPS,
      language: AppConfig().appLanguage ?? AppConstants.LANG_EN_CODE,
    ));
    return latlng!;
    // reverseGeocodingCubit.getReverseGeocoding(ReverseGeocodingParam(
    //   latlng: const LatLng(24.307115378857237, 47.34487268371582),
    //   apiKey: AppConstants.API_KEY_GOOGLE_MAPS,
    //   language: AppConfig().appLanguage ?? AppConstants.LANG_EN_CODE,
    // ));
    // return const LatLng(24.307115378857237, 47.34487268371582);
  }

  void onSelectFeelingTap(int index) {
    _selectedFeelingIndex = index;
    notifyListeners();
  }
}
