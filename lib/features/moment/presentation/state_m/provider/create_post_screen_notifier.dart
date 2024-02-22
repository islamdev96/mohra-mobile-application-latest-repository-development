import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/custom_file_type.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/custom_map/logic/location_wrapper.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_error_snackbar.dart';
import 'package:starter_application/features/friend/presentation/screen/select_friends_screen.dart';
import 'package:starter_application/features/moment/data/model/request/create_post_param.dart';
import 'package:starter_application/features/moment/presentation/screen/create_post_screen.dart';
import 'package:starter_application/features/moment/presentation/screen/select_place_screen.dart';
import 'package:starter_application/features/moment/presentation/state_m/cubit/moment_cubit.dart';

// import 'package:starter_application/features/music/presentation/screen/select_tracks_screen/select_tracks_screen.dart';
import 'package:starter_application/features/place/data/model/request/reverse_geocoding_params.dart';
import 'package:starter_application/features/place/domain/entity/reverse_geocoding_entity.dart';
import 'package:starter_application/features/place/presentation/state_m/cubit/place_cubit.dart';
import 'package:starter_application/features/upload/data/model/request/upload_image_param.dart';
import 'package:starter_application/features/upload/domain/entity/upload_file_response_entity.dart';
import 'package:starter_application/features/upload/presentation/state_m/cubit/upload_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '/core/ui/custom_map/logic/location_extesions.dart';

class CreatePostScreenNotifier extends ScreenNotifier {
  /// Constructor
  CreatePostScreenNotifier(this.param) {
    _selectedTrack = this.param.post?.songId != null
        ? CreatePostTrack(
            id: this.param.post?.songId,
            image: this.param.post?.imageUrl!.first.imageUrl,
            name: this.param.post?.songName,
            //TODO
            artist: "",
          )
        : null;
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

    /// Don't get prev selected place if it is a challenge
    _selectedPlace =
        this.param.post?.placeName != null || this.param.post?.location != null
            ? CreatePostPlace(
                location: this.param.post?.location,
                name: this.param.post?.placeName)
            : null;

    /// If the post is not video then the _uploadedFile if exist is an image
    // _uploadedFile = (this.param.post?.videos?.length ?? 0) == 0
    //     ? this.param.post?.imageUrl
    //     : (this.param.post?.videos?.length ?? 0) > 0
    //         ? this.param.post?.videos![0].videoUrl
    //         : null;
    _pickedFiles =
        _uploadedFile != null && _selectedTrack == null ? [_uploadedFile!] : [];
    captionController = TextEditingController.fromValue(
        TextEditingValue(text: this.param.post?.caption ?? ""));

    matchedLocationFuture =
        !isVerifyChallenge ? null : getMatchedLocationLatLng();
  }

  /// Variables
  final MomentCubit createPostCubit = MomentCubit();
  final UploadCubit uploadFileCubit = UploadCubit();
  final PlaceCubit reverseGeocodingCubit = PlaceCubit();
  final CreatePostScreenParam param;
  List<String> _pickedFiles = [];
  final ImagePicker picker = ImagePicker();
  List<CreatePostFriend> _taggedFriends = [];
  CreatePostTrack? _selectedTrack;
  CreatePostPlace? _selectedPlace;
  late final Future<LatLng>? matchedLocationFuture;

  /// Caption text field variables
  final FocusNode captionFocusNode = FocusNode();
  final captionKey = new GlobalKey<FormFieldState<String>>();
  late final captionController;

  /// Uploaded image
  String? _uploadedFile;
  List<VideoParam> uploadedVideos = [];
  List<ImageParam> uploadedImages = [];
  bool _isLoading = false;

  /// Getters and setters
  bool get isEditPost => param.post != null;

  CreatePostTrack? get selectedTrack => this._selectedTrack;

  CreatePostPlace? get selectedPlace => this._selectedPlace;

  List<String> get pickedFiles => _pickedFiles;

  bool get isLoading => this._isLoading;

  bool get isVerifyChallenge => challengeId != null && challengeId != 0;

  int? get challengeId => param.challengeId ?? param.post?.challengeId;

  set isLoading(bool value) {
    this._isLoading = value;
    notifyListeners();
  }

  String? get uploadedFile => this._uploadedFile;

  set uploadedFile(String? value) {
    _uploadedFile = value;
  }

  List<CreatePostFriend> get taggedFriends => this._taggedFriends;

  /// Methods
  @override
  void closeNotifier() {
    createPostCubit.close();
    uploadFileCubit.close();
    reverseGeocodingCubit.close();
    this.dispose();
  }

  // void onImagesPicked(List<XFile> imagesFiles) {
  //   _imagesFiles.addAll(imagesFiles);
  //   notifyListeners();
  //   uploadImageCubit.uploadImage(ImageParams(image: imagesFiles[0]));
  // }
  void onFilesPicked(List<String> pickedFiles) {
    if (pickedFiles.length == 0) return;
    _pickedFiles.addAll(pickedFiles);
    _selectedTrack = null;

    notifyListeners();

    uploadFileCubit.uploadFile(
      UploadFileParams(
        path: pickedFiles.first,
        type: getFileType(pickedFiles.first),
      ),
    );
  }

  onFileDeleted(List<String> paths) {
    _pickedFiles = [];
    _uploadedFile = null;
    notifyListeners();
  }

  void onUploadImageFailed() {
    _pickedFiles.clear();
    _uploadedFile = null;
    notifyListeners();
  }

  void onCreatePostTap() {
    setup();
    createEditPostRequest();
  }

  void createEditPostRequest() {
    /// If the post is verify challenge and the matched location is not received yet show error message
    if (isVerifyChallenge && _selectedPlace == null) {
      showErrorSnackBar(
        message: Translation.current.match_location_not_complete_yet,
      );
      return;
    }
    if (captionKey.currentState!.validate()) {
      CustomFileType? fileType;
      if (_uploadedFile != null) {
        fileType = getFileType(_uploadedFile!);
      }

      final requestParam = CreateEditPostParam(
        id: param.post?.id,
        songId: selectedTrack?.id,
        songName: selectedTrack?.name,
        caption: captionController.text,
        imageUrl: uploadedImages,
        videos: uploadedVideos,
        tags: taggedFriends.length > 0
            ? taggedFriends.map((e) => e.id).whereType<int>().toList()
            : null,
        placeName: selectedPlace?.name,
        /* lat: 0,
        long: 0, */
        lat: selectedPlace?.location?.latitude,
        long: selectedPlace?.location?.longitude,
        challengeId: isVerifyChallenge ? challengeId : null,
      );

      /// If create post
      if (param.post == null)
        createPostCubit.createPost(requestParam);

      /// If edit post
      else
        createPostCubit.editPost(requestParam);
    }
  }

  void onUploadImageLoaded(UploadFileResponseEntity imageUrlsEntity) {
    _uploadedFile = imageUrlsEntity.url;
    CustomFileType? fileType;
    fileType = getFileType(_uploadedFile!);

    if (fileType == CustomFileType.VIDEO) {
      uploadedVideos.add(
          VideoParam(videoUrl: _uploadedFile!, videoPath: _pickedFiles.last));
    } else if (fileType == CustomFileType.IMAGE) {
      uploadedImages.add(
          ImageParam(imageUrl: _uploadedFile!, imagePath: _pickedFiles.last));
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

  // void onPickSongTap() {
  //   Nav.to(
  //     SelectTracksScreen.routeName,
  //     arguments: SelectTracksScreenParam(
  //       onTracksSelected: (tracks) {
  //         if (tracks.length > 0)
  //           _selectedTrack = CreatePostTrack(
  //             id: tracks[0].id,
  //             image: (tracks[0].album?.images?.length ?? 0) > 0
  //                 ? tracks[0].album?.images![0].url
  //                 : null,
  //             name: tracks[0].name,
  //             artist: (tracks[0].artists?.length ?? 0) > 0
  //                 ? tracks[0].artists![0].name ?? ""
  //                 : "",
  //           );
  //         _pickedFiles = [];
  //         _uploadedFile = null;
  //         notifyListeners();
  //       },
  //     ),
  //   );
  // }

  void onRemoveSongTap() {
    _selectedTrack = null;
    notifyListeners();
  }

  setup() {
    List<VideoParam> temp = [];
    List<ImageParam> temp2 = [];
    temp.clear();
    temp2.clear();

    notifyListeners();
    if (_pickedFiles.isEmpty) {
      uploadedImages.clear();
      uploadedVideos.clear();
      notifyListeners();
    } else {

      _pickedFiles.forEach((path) {
        uploadedVideos.forEach((element) {
          if (element.videoPath == path && !temp.contains(element)) {
            temp.add(element);
          }
        });
        uploadedImages.forEach((element) {
          if (element.imagePath == path && !temp2.contains(element)) {
            temp2.add(element);
          }
        });
      });
      uploadedVideos = temp;
      uploadedImages = temp2;
      notifyListeners();
    }
    print("PickedFiles$_pickedFiles");
    print("VideoList::${uploadedVideos}");
    print("ImageList::${uploadedImages}");
  }

  void onSelectPlaceTap() {
    Nav.to(
      SelectPlaceScreen.routeName,
      arguments: SelectPlaceScreenParam(
        onPlaceSelected: (places) {
          if (places.length > 0) {
            final placeLocation = places[0].geometry?.location?.latLng;
            _selectedPlace = CreatePostPlace(
              location: placeLocation,
              name: places[0].name,
            );
            notifyListeners();
          }
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
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
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
}

class CreatePostTrack {
  final String? id;
  final String? image;
  final String? name;
  final String? artist;

  CreatePostTrack({
    required this.id,
    required this.image,
    required this.name,
    required this.artist,
  });
}

class CreatePostFriend {
  final int? id;
  final String? name;

  CreatePostFriend({
    required this.id,
    required this.name,
  });
}

class CreatePostPlace {
  final LatLng? location;
  final String? name;

  CreatePostPlace({
    required this.location,
    required this.name,
  });
}
