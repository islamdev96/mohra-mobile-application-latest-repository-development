import 'dart:io';

import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/datasources/shared_preference.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/challenge_details_screen_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/ui/toast.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';
import 'package:starter_application/features/challenge/data/model/request/claim_rewards_request.dart';
import 'package:starter_application/features/challenge/data/model/request/get_all_challenge_request.dart';
import 'package:starter_application/features/challenge/data/model/request/invite_friends_request.dart';
import 'package:starter_application/features/challenge/domain/entity/challange_entity.dart';
import 'package:starter_application/features/challenge/presentation/screen/challenge_screen.dart';
import 'package:starter_application/features/challenge/presentation/state_m/cubit/challenge_cubit.dart';
import 'package:starter_application/features/friend/presentation/screen/select_friends_screen.dart';
import 'package:starter_application/features/messages/domain/entity/friend_entity.dart';
import 'package:starter_application/features/moment/data/model/request/delete_post_param.dart';
import 'package:starter_application/features/moment/data/model/request/get_all_moments_request.dart';
import 'package:starter_application/features/moment/data/model/request/get_client_points_request.dart';
import 'package:starter_application/features/moment/data/model/request/report_post_param.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';
import 'package:starter_application/features/moment/domain/entity/points_entity.dart';
import 'package:starter_application/features/moment/domain/usecase/get_all_moments_usecase.dart';
import 'package:starter_application/features/moment/presentation/screen/check_in/check_in_screen.dart';
import 'package:starter_application/features/moment/presentation/screen/create_feeling_screen.dart';
import 'package:starter_application/features/moment/presentation/screen/create_post_screen.dart';
import 'package:starter_application/features/moment/presentation/state_m/cubit/moment_cubit.dart';
import 'package:starter_application/features/moment/presentation/widget/create_post_picker.dart';
import 'package:starter_application/features/moment/presentation/widget/post_option_widget.dart';
import 'package:starter_application/features/user/data/model/request/get_address_params.dart';
import 'package:starter_application/features/user/domain/entity/addresses_entity.dart';
import 'package:starter_application/features/user/presentation/state_m/cubit/user_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../../core/common/permissions_utils.dart';
import '../../../../../core/constants/enums/system_type.dart';
import '../../../../../core/ui/snackbars/show_snackbar.dart';
import '../../../../health/data/model/request/image_params.dart';
import '../../../../health/domain/entity/image_urls_entity.dart';
import '../../../../mylife/presentation/logic/date_time_helper.dart';
import '../../../../user/data/model/request/update_profile_params.dart';
import '../../../../user/domain/entity/update_profile_entity.dart';
import '../../../../user/presentation/widget/delete_image_dialog.dart';
import '../../../../user/presentation/widget/update_profile_image_dialog.dart';
import 'package:image_cropper/image_cropper.dart';

class MomentScreenNotifier extends ScreenNotifier {
  MomentCubit momentCubit = MomentCubit();
  MomentCubit pointsCubit = MomentCubit();
  MomentCubit reportDeleteCubit = MomentCubit();
  ChallengeCubit challengeCubit = ChallengeCubit();
  ChallengeCubit challengeStepsCubit = ChallengeCubit();
  List<MomentItemEntity> _moments = [];
  late BuildContext context;

  // Key
  final reasonKey = new GlobalKey<FormFieldState<String>>();

  // Controller
  final reasonController = TextEditingController();
  final FocusNode reasonFocusNode = FocusNode();
  String? reason = "";

  UserCubit userCubit = UserCubit();
  List<ChallangeItemEntity> challenges = [];
  List<FriendEntity> _friends = [];
  String userAddress = '';
  int points = 0;
  bool isLoading = true;
  List<String> stepsTitles = [
    Translation.current.join,
    Translation.current.invite_friends,
    Translation.current.Verify,
    Translation.current.claim_rewards,
  ];
  int _currentStep = 1;

  var challengeId;
  final RefreshController momentsRefreshController = RefreshController();

  ValueNotifier<bool> isAddOpenedNotifier = ValueNotifier(false);
  ValueNotifier<double> opacityNotifier = ValueNotifier(0);
  ValueNotifier<double> positionNotifier0 = ValueNotifier(0);
  ValueNotifier<double> positionNotifier1 = ValueNotifier(0);
  ValueNotifier<double> positionNotifier2 = ValueNotifier(0);
  ValueNotifier<double> positionNotifier3 = ValueNotifier(0);
  ValueNotifier<double> positionNotifier4 = ValueNotifier(0);

  AnimateIconController animateIconController = AnimateIconController();
  bool isAddOpened = false;
  double opacity = 0;
  int uploadType = 0;
  String avatarImage = '';

  changeProfileImage(int index) async {
    uploadType = 0;
    if (Platform.isIOS) {
      if (index == 0) {
        final ImagePicker _picker = ImagePicker();
        // Pick an image
        final XFile? result =
            await _picker.pickImage(source: ImageSource.camera);
        if (result != null) {
          showChangeProfileDialog(
              imageUrl: result.path,
              context: context,
              isCircle: true,
              onConfirm: () {
                uploadImage(result);
                Nav.pop();
                Fluttertoast.showToast(
                    msg: Translation.current.processing_in_background);
              });
        } else {
          print('asddadasd');
        }
      }
      if (index == 1) {
        print("opening gallery");

        final ImagePicker _picker = ImagePicker();
        // Pick an image
        final XFile? result =
            await _picker.pickImage(source: ImageSource.gallery);
        if (result != null) {
          print(result.path);
          showChangeProfileDialog(
              imageUrl: result.path,
              isCircle: true,
              context: context,
              onConfirm: () async {
                await uploadImage(result);
                Nav.pop();
                Fluttertoast.showToast(
                    msg: Translation.current.processing_in_background);
              });
        }
      }
      if (index == 2) {
        if (avatarImage == '') {
          Fluttertoast.showToast(msg: Translation.current.set_avatar_error);
        } else {
          showDeleteImageDialog(
            context: context,
            title: Translation.current.set_avatar_title,
            message: Translation.current.set_avatar_message,
            onCancel: () {
              Nav.pop();
            },
            onConfirm: () {
              UpdateProfileParams updateProfileParams = UpdateProfileParams(
                  name: UserSessionDataModel.name,
                  imageUrl: avatarImage,
                  phoneNumber: UserSessionDataModel.phoneNumber,
                  coverImage: UserSessionDataModel.coverPhoto,
                  gender: UserSessionDataModel.gender,
                  date: UserSessionDataModel.birthday,
                  email: UserSessionDataModel.emailAddress,
                  surName: UserSessionDataModel.surname);
              userCubit.updateProfile(updateProfileParams);
              Nav.pop();
              Fluttertoast.showToast(
                  msg: Translation.current.processing_in_background);
            },
          );
        }
      }
      if (index == 3) {
        showDeleteImageDialog(
          context: context,
          title: Translation.current.delete_image_title,
          message: Translation.current.delete_image_message,
          onCancel: () {
            Nav.pop();
          },
          onConfirm: () {
            UpdateProfileParams updateProfileParams = UpdateProfileParams(
                name: UserSessionDataModel.name,
                imageUrl: null,
                phoneNumber: UserSessionDataModel.phoneNumber,
                coverImage: UserSessionDataModel.coverPhoto,
                gender: UserSessionDataModel.gender,
                date: UserSessionDataModel.birthday,
                email: UserSessionDataModel.emailAddress,
                surName: UserSessionDataModel.surname);
            userCubit.updateProfile(updateProfileParams);
            Nav.pop();
            Fluttertoast.showToast(
                msg: Translation.current.processing_in_background);
          },
        );
      }
    } else {
      if (index == 0) {
        XFile? result = await _pickImage(ImageSource.camera);
        if (result != null) {
          CroppedFile? croppedFile = await ImageCropper().cropImage(
              sourcePath: result.path,
              aspectRatioPresets: Platform.isAndroid
                  ? [
                      CropAspectRatioPreset.square,
                      CropAspectRatioPreset.ratio3x2,
                      CropAspectRatioPreset.original,
                      CropAspectRatioPreset.ratio4x3,
                      CropAspectRatioPreset.ratio16x9
                    ]
                  : [
                      CropAspectRatioPreset.original,
                      CropAspectRatioPreset.square,
                      CropAspectRatioPreset.ratio3x2,
                      CropAspectRatioPreset.ratio4x3,
                      CropAspectRatioPreset.ratio5x3,
                      CropAspectRatioPreset.ratio5x4,
                      CropAspectRatioPreset.ratio7x5,
                      CropAspectRatioPreset.ratio16x9
                    ],
              cropStyle: CropStyle.rectangle,
              uiSettings: [
                IOSUiSettings(
                  title: Translation.current.edit,
                ),
                AndroidUiSettings(
                    toolbarTitle: Translation.current.edit,
                    toolbarColor: Colors.deepOrange,
                    toolbarWidgetColor: Colors.white,
                    initAspectRatio: CropAspectRatioPreset.original,
                    lockAspectRatio: false),
              ]);
          if (croppedFile != null) {
            result = XFile(croppedFile.path);
          }
          showChangeProfileDialog(
              imageUrl: result.path,
              context: context,
              isCircle: true,
              onConfirm: () {
                uploadImage(result!);
                Nav.pop();
                Fluttertoast.showToast(
                    msg: Translation.current.processing_in_background);
              });
        } else {
          print('asddadasd');
        }
      }
      if (index == 1) {
        print("opening gallery");

        XFile? result = await _pickImage(ImageSource.gallery);
        if (result != null) {
          CroppedFile? croppedFile = await ImageCropper().cropImage(
              sourcePath: result.path,
              aspectRatioPresets: Platform.isAndroid
                  ? [
                      CropAspectRatioPreset.square,
                      CropAspectRatioPreset.ratio3x2,
                      CropAspectRatioPreset.original,
                      CropAspectRatioPreset.ratio4x3,
                      CropAspectRatioPreset.ratio16x9
                    ]
                  : [
                      CropAspectRatioPreset.original,
                      CropAspectRatioPreset.square,
                      CropAspectRatioPreset.ratio3x2,
                      CropAspectRatioPreset.ratio4x3,
                      CropAspectRatioPreset.ratio5x3,
                      CropAspectRatioPreset.ratio5x4,
                      CropAspectRatioPreset.ratio7x5,
                      CropAspectRatioPreset.ratio16x9
                    ],
              cropStyle: CropStyle.rectangle,
              uiSettings: [
                IOSUiSettings(
                  title: Translation.current.edit,
                ),
                AndroidUiSettings(
                    toolbarTitle: Translation.current.edit,
                    toolbarColor: Colors.deepOrange,
                    toolbarWidgetColor: Colors.white,
                    initAspectRatio: CropAspectRatioPreset.original,
                    lockAspectRatio: false),
              ]);
          if (croppedFile != null) {
            result = XFile(croppedFile.path);
          }
          print(result.path);
          showChangeProfileDialog(
              imageUrl: result.path,
              context: context,
              isCircle: true,
              onConfirm: () async {
                await uploadImage(result!);
                Nav.pop();
                Fluttertoast.showToast(
                    msg: Translation.current.processing_in_background);
              });
        }
      }
      if (index == 2) {
        if (avatarImage == '') {
          Fluttertoast.showToast(msg: Translation.current.set_avatar_error);
        } else {
          showDeleteImageDialog(
            context: context,
            title: Translation.current.set_avatar_title,
            message: Translation.current.set_avatar_message,
            onCancel: () {
              Nav.pop();
            },
            onConfirm: () {
              UpdateProfileParams updateProfileParams = UpdateProfileParams(
                  name: UserSessionDataModel.name,
                  imageUrl: avatarImage,
                  phoneNumber: UserSessionDataModel.phoneNumber,
                  coverImage: UserSessionDataModel.coverPhoto,
                  gender: UserSessionDataModel.gender,
                  date: UserSessionDataModel.birthday,
                  email: UserSessionDataModel.emailAddress,
                  surName: UserSessionDataModel.surname);
              userCubit.updateProfile(updateProfileParams);
              Nav.pop();
              Fluttertoast.showToast(
                  msg: Translation.current.processing_in_background);
            },
          );
        }
      }
      if (index == 3) {
        showDeleteImageDialog(
          context: context,
          title: Translation.current.delete_image_title,
          message: Translation.current.delete_image_message,
          onCancel: () {
            Nav.pop();
          },
          onConfirm: () {
            UpdateProfileParams updateProfileParams = UpdateProfileParams(
                name: UserSessionDataModel.name,
                imageUrl: null,
                phoneNumber: UserSessionDataModel.phoneNumber,
                coverImage: UserSessionDataModel.coverPhoto,
                gender: UserSessionDataModel.gender,
                date: UserSessionDataModel.birthday,
                email: UserSessionDataModel.emailAddress,
                surName: UserSessionDataModel.surname);
            userCubit.updateProfile(updateProfileParams);
            Nav.pop();
            Fluttertoast.showToast(
                msg: Translation.current.processing_in_background);
          },
        );
      }
    }
  }

  changeCoverImage(int index) async {
    uploadType = 1;
    if (Platform.isIOS) {
      if (index == 0) {
        final ImagePicker _picker = ImagePicker();
        // Pick an image
        final XFile? result =
            await _picker.pickImage(source: ImageSource.camera);
        if (result != null) {
          print(result.path);
          showChangeProfileDialog(
              imageUrl: result.path,
              context: context,
              onConfirm: () async {
                uploadImage(result);
                Nav.pop();
                Fluttertoast.showToast(
                    msg: Translation.current.processing_in_background);
              });
        }
      }
      if (index == 1) {
        final ImagePicker _picker = ImagePicker();
        // Pick an image
        final XFile? result =
            await _picker.pickImage(source: ImageSource.gallery);
        if (result != null) {
          print(result.path);
          showChangeProfileDialog(
              imageUrl: result.path,
              context: context,
              onConfirm: () async {
                await uploadImage(result);
                Nav.pop();
                Fluttertoast.showToast(
                    msg: Translation.current.processing_in_background);
              });
        }
      }
      if (index == 2) {
        showDeleteImageDialog(
          context: context,
          title: Translation.current.delete_cover_title,
          message: Translation.current.delete_cover_message,
          onCancel: () {
            Nav.pop();
          },
          onConfirm: () {
            UpdateProfileParams updateProfileParams = UpdateProfileParams(
                name: UserSessionDataModel.name,
                imageUrl: UserSessionDataModel.imageUrl,
                phoneNumber: UserSessionDataModel.phoneNumber,
                coverImage: null,
                gender: UserSessionDataModel.gender,
                date: UserSessionDataModel.birthday,
                email: UserSessionDataModel.emailAddress,
                surName: UserSessionDataModel.surname);
            userCubit.updateProfile(updateProfileParams);
            Nav.pop();
            Fluttertoast.showToast(
                msg: Translation.current.processing_in_background);
          },
        );
      }
    } else {
      if (index == 0) {
        XFile? result = await _pickImage(ImageSource.camera);
        if (result != null) {
          print(result.path);
          showChangeProfileDialog(
              imageUrl: result.path,
              context: context,
              onConfirm: () async {
                uploadImage(result);
                Nav.pop();
                Fluttertoast.showToast(
                    msg: Translation.current.processing_in_background);
              });
        }
      }
      if (index == 1) {
        XFile? result = await _pickImage(ImageSource.gallery);
        if (result != null) {
          print(result.path);
          showChangeProfileDialog(
              imageUrl: result.path,
              context: context,
              onConfirm: () async {
                await uploadImage(result);
                Nav.pop();
                Fluttertoast.showToast(
                    msg: Translation.current.processing_in_background);
              });
        }
      }
      if (index == 2) {
        showDeleteImageDialog(
          context: context,
          title: Translation.current.delete_cover_title,
          message: Translation.current.delete_cover_message,
          onCancel: () {
            Nav.pop();
          },
          onConfirm: () {
            UpdateProfileParams updateProfileParams = UpdateProfileParams(
                name: UserSessionDataModel.name,
                imageUrl: UserSessionDataModel.imageUrl,
                phoneNumber: UserSessionDataModel.phoneNumber,
                coverImage: null,
                gender: UserSessionDataModel.gender,
                date: UserSessionDataModel.birthday,
                email: UserSessionDataModel.emailAddress,
                surName: UserSessionDataModel.surname);
            userCubit.updateProfile(updateProfileParams);
            Nav.pop();
            Fluttertoast.showToast(
                msg: Translation.current.processing_in_background);
          },
        );
      }
    }
  }

  ImagePicker picker = ImagePicker();

  Future<XFile?> _pickImage(ImageSource source) async {
    if (source == ImageSource.gallery) {
      if (AppConfig().os == SystemType.IOS) {
        final status = await requestPhotosPermission();
        if (status != PermissionStatus.granted) {
          await requestPhotosPermission();
        } else {
          await _pickImageFromGallery();
        }
      } else {
        final status = await requestPhotosPermission();
        if (status == PermissionStatus.granted)
          return await _pickImageFromGallery();
      }
    }
    if (source == ImageSource.camera) {
      if (AppConfig().os == SystemType.IOS) {
        final status = await requestCameraPermission();
        if (status != PermissionStatus.granted) {
          await requestCameraPermission();
        } else {
          await _pickImageFromCamera();
        }
      } else {
        final status = await requestCameraPermission();
        if (status == PermissionStatus.granted)
          return await _pickImageFromCamera();
      }
    }
  }

  Future<XFile?> _pickImageFromGallery() async {
    try {
      XFile? pickedImage;

      final image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      return image;
    } catch (e) {}
  }

  Future<XFile?> _pickImageFromCamera() async {
    try {
      XFile? pickedImage;

      final image = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );
      return image;
    } catch (e) {}
  }

  uploadImage(XFile image) {
    userCubit.uploadImage(ImageParams(image: image));
  }

  onUpdateProfileImageDone(ImageUrlsEntity entity) {
    if (uploadType == 0) {
      UpdateProfileParams updateProfileParams = UpdateProfileParams(
          name: UserSessionDataModel.name,
          imageUrl: entity.urls.first,
          phoneNumber: UserSessionDataModel.phoneNumber,
          coverImage: UserSessionDataModel.coverPhoto,
          gender: UserSessionDataModel.gender,
          date: UserSessionDataModel.birthday,
          email: UserSessionDataModel.emailAddress,
          surName: UserSessionDataModel.surname);
      userCubit.updateProfile(updateProfileParams);
    } else {
      UpdateProfileParams updateProfileParams = UpdateProfileParams(
          name: UserSessionDataModel.name,
          imageUrl: UserSessionDataModel.imageUrl,
          phoneNumber: UserSessionDataModel.phoneNumber,
          coverImage: entity.urls.first,
          gender: UserSessionDataModel.gender,
          date: UserSessionDataModel.birthday,
          email: UserSessionDataModel.emailAddress,
          surName: UserSessionDataModel.surname);
      userCubit.updateProfile(updateProfileParams);
    }
    notifyListeners();
  }

  onUpdateProfleDone(UpdateProfileEntity profileEntity) async {
    print('profile entiiiiiiiiity');
    print(profileEntity.toString());
    print('newwwwwww ');
    if (uploadType == 0) {
      UserSessionDataModel.updateProfileSP(
        profileEntity.name!,
        profileEntity.surname!,
        profileEntity.fullName!,
        UserSessionDataModel.birthday,
        profileEntity.gender!,
        profileEntity.imageUrl ?? null,
        profileEntity.emailAddress!,
        profileEntity.avatarMonth!,
      );
    } else if (uploadType == 1) {
      UserSessionDataModel.updateCoverPhoto(profileEntity.cover ?? '');
    } else {
      await UserSessionDataModel.updateProfileSP(
          profileEntity.name!,
          profileEntity.surname!,
          profileEntity.fullName!,
          DateTimeHelper.getFormatedDate(profileEntity.birthDate!),
          profileEntity.gender!,
          profileEntity.imageUrl ?? null,
          profileEntity.emailAddress!,
          profileEntity.avatarMonth!);
      Nav.pop();
      print('newwwwwww ');
      print(UserSessionDataModel.birthday);
      // print(changedDate);
      // print(DateTimeHelper.getFormatedDate(changedDate));
    }
    showSnackbar(Translation.current.updated_successfully);
    notifyListeners();
  }

  bool openAdd() {
    isAddOpened = true;
    isAddOpenedNotifier.value = true;
    positionNotifier0.value = 20 + 120.h;
    positionNotifier1.value = 30 + (2 * 120.h);
    positionNotifier2.value = 40 + (3 * 120.h);
    positionNotifier3.value = 50 + (4 * 120.h);
    positionNotifier4.value = 60 + (5 * 120.h);
    if (animateIconController.isStart()) {
      animateIconController.animateToEnd();
    }
    opacityNotifier.value = 1;
    notifyListeners();
    return true;
  }

  bool closeAdd() {
    isAddOpened = false;
    isAddOpenedNotifier.value = false;
    positionNotifier0.value = 20;
    positionNotifier1.value = 20;
    positionNotifier2.value = 20;
    positionNotifier3.value = 20;
    positionNotifier4.value = 20;
    if (animateIconController.isEnd()) {
      animateIconController.animateToStart();
    }
    opacityNotifier.value = 0;
    notifyListeners();
    return true;
  }

  /// Getters and setters
  int get currentStep => this._currentStep;

  List<MomentItemEntity> get moments => this._moments;

  List<FriendEntity> get friends => this._friends;

  set currentStep(int value) {
    this._currentStep = value;
    notifyListeners();
  }

  void loading(value) {
    isLoading = value;
    notifyListeners();
  }

  onFriendsTap(id) {
    if (currentStep == 1) {
      Nav.to(SelectFriendsScreen.routeName,
          arguments: SelectFriendsScreenParam(
              challengeId: id,
              isChallenge: true,
              onSelectFriends: (friends) {
                _friends = friends;
                if (_friends.isNotEmpty) {
                  challengeStepsCubit.inviteFriends(InviteFriendsRequest(
                      challengeId: id,
                      friends: friends
                          .map((e) => e.friendId)
                          .whereType<int>()
                          .toList()));
                }
                notifyListeners();
              }));
    }
  }

  void claimRewards(id) {
    challengeStepsCubit.claimRewards(ClaimRewardsRequest(id: id));
  }

  //Methods
  void getMoments() {
    momentCubit.getMoments(GetMomentsRequest());
  }

  void addToChallenge(List<ChallangeItemEntity> items) {
    challenges.clear();
    challenges.addAll(items);
    notifyListeners();
  }

  void getMyChallenges() {
    challengeCubit.getChallenges(GetChallengeRequest(
      isMyChalhengs: true,
    ));
  }

  void MomentsLoaded(MomentEntity momentEntity) {
    _moments = momentEntity.items!;
    notifyListeners();
    getUserAddresses();
  }

  void getPoints() async {
    final prefs = await SpUtil.getInstance();
    int userId = await prefs.getInt(AppConstants.KEY_USERID) ?? 0;
    pointsCubit.getPoints(GetClientPointsRequest(id: userId));
  }

  pointLoaded(PointsEntity pointsEntity) {
    points = pointsEntity.result!.points!;
    notifyListeners();
  }

  @override
  void closeNotifier() {}

  void onCreatePostTap(
    int? challengeId,
  ) {
    final height = (1.sw - 30.w * 2 - 45.w * 5) / 6;
    final width = (1.sw - 30.w * 2 - 45.w * 5) / 6;
    showCreatePostPickerDialog(
      AppConfig().appContext,
      items: [
        PostOptionWidget(
          height: height,
          width: width,
          iconData: Icons.tag_faces_rounded,
          onTap: () => onAddFeelingTap(challengeId),
          title: Translation.current.feeling_noun,
        ),
        PostOptionWidget(
          height: height,
          width: width,
          iconData: Icons.location_on,
          onTap: () => onCheckInTap(challengeId),
          title: Translation.current.place,
          iconColor: AppColors.mansourLightBlueColor,
        ),
        PostOptionWidget(
          height: height,
          width: width,
          iconData: Icons.music_note,
          onTap: () => onAddPostTap(challengeId),
          title: Translation.current.music_2,
          iconColor: Colors.black,
        ),
        PostOptionWidget(
          height: height,
          width: width,
          iconData: Icons.play_arrow,
          onTap: () => onAddPostTap(challengeId),
          title: Translation.current.video,
        ),
        PostOptionWidget(
            height: height,
            width: width,
            iconData: Icons.edit,
            onTap: () => onAddPostTap(challengeId),
            title: Translation.current.post_noun),
        PostOptionWidget(
            height: height,
            width: width,
            backgroundColor: AppColors.primaryColorLight,
            iconColor: Colors.white,
            iconPath: AppConstants.SVG_CLOSE,
            onTap: () => Nav.pop(),
            title: ""),
      ],
    );
  }

  void onAddPostTap(int? challengeId) {
    Nav.pop();
    Nav.to(
      CreatePostScreen.routeName,
      arguments: CreatePostScreenParam(
          onPostCreated: onPostCreated, challengeId: challengeId),
    );
  }

  void onCheckInTap(int? challengeId) {
    Nav.pop();
    Nav.to(
      CheckInScreen.routeName,
      arguments: CheckInScreenParam(
          onCheckInCreated: onPostCreated, challengeId: challengeId),
    );
  }

  void onAddFeelingTap(int? challengeId) {
    Nav.pop();

    Nav.to(
      CreateFeelingScreen.routeName,
      arguments: CreateFeelingScreenParam(
        onFeelingCreated: onPostCreated,
        challengeId: challengeId,
      ),
    );
  }

  void onPostCreated() {
    refreshMomentsScreen();
  }

  void refreshMomentsScreen() {
    getMoments();
    getPoints();
    getMyChallenges();
  }

  void onChallengeCardTap(ChallangeItemEntity challangeItemEntity) {
    Nav.to(ChallengeScreen.routeName,
        arguments: ChallengeDetailsScreenParams(
          challangeItemEntity: challangeItemEntity,
          onStepChange: (_) => refreshMomentsScreen(),
        ));
  }

  Future<Result<AppErrors, List<MomentItemEntity>>> getMomentsItems(
      int unit) async {
    final result = await getIt<GetMomentsUseCase>()(GetMomentsRequest(
      skipCount: unit * 10,
      maxResultCount: 10,
    ));

    return Result<AppErrors, List<MomentItemEntity>>(
        data: result.data?.items, error: result.error);
  }

  void onMomentsItemsFetched(List<MomentItemEntity> items, int nextUnit) {
    _moments = items;
    notifyListeners();
  }

  getUserAddresses() {
    print('getting address');
    userCubit
        .getAllAddresses(GetAddressParams(id: UserSessionDataModel.userId));
  }

  onAddressLoaded(AddressListEntity addressListEntity) {
    if (addressListEntity.addresses.isEmpty) {
      return;
    } else {
      /// getting selected one
      for (int i = 0; i < addressListEntity.addresses.length; i++) {
        if (addressListEntity.addresses[i].isDefault ?? false) {
          userAddress = addressListEntity.addresses[i].cityName ?? '';
          userAddress += ', ' + addressListEntity.addresses[i].street!;
          break;
        }
      }
      notifyListeners();
    }
  }

  final writeReviewKey = GlobalKey<FormFieldState<String>>();

  onReportTapped(id) {
    if (reasonController.text != "" ||
        writeReviewKey.currentState!.validate()) {
      reportDeleteCubit.reportPost(
          ReportPostParam(description: reason, refId: id, refType: 2));
      reasonController.clear();
    } else {
      Fluttertoast.showToast(msg: Translation.current.errorTxt);
      // Toast.show(Translation.current.errorTxt,duration: 600);
    }
  }

  onReportSuccess() {
    Nav.pop();
    notifyListeners();
  }

  onDeleteTapped(id) {
    reportDeleteCubit.deletePost(DeletePostParam(id: id));
  }

  onDeleteSuccess() {
    refreshMomentsScreen();
    notifyListeners();
  }
}
