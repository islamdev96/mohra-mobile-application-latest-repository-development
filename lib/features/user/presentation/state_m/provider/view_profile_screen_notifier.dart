import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/permissions_utils.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/enums/system_type.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/dialogs/pick_image_dialog.dart';
import 'package:starter_application/core/ui/dialogs/show_custom_date_picker.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/features/health/data/model/request/image_params.dart';
import 'package:starter_application/features/health/domain/entity/image_urls_entity.dart';
import 'package:starter_application/features/mylife/presentation/logic/date_time_helper.dart';
import 'package:starter_application/features/personality/data/model/request/get_avatar_params.dart';
import 'package:starter_application/features/personality/domain/entity/avatar_entity.dart';
import 'package:starter_application/features/user/data/model/request/get_address_params.dart';
import 'package:starter_application/features/user/data/model/request/get_profile_params.dart';
import 'package:starter_application/features/user/data/model/request/update_profile_params.dart';
import 'package:starter_application/features/user/domain/entity/addresses_entity.dart';
import 'package:starter_application/features/user/domain/entity/get_profile_entity.dart';
import 'package:starter_application/features/user/domain/entity/update_profile_entity.dart';
import 'package:starter_application/features/user/presentation/state_m/cubit/user_cubit.dart';
import 'package:starter_application/features/user/presentation/widget/delete_image_dialog.dart';
import 'package:starter_application/features/user/presentation/widget/update_profile_image_dialog.dart';
import 'package:starter_application/generated/l10n.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../../../../core/navigation/navigation_service.dart';
import '../../../../../di/service_locator.dart';
import '../../../../home/presentation/state_m/provider/app_main_screen_notifier.dart';

class ViewProfileScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final userCubit = UserCubit();
  ImagePicker picker = ImagePicker();
  TextEditingController textEditingController = TextEditingController();

  /// 0 for profile image , 1 for cover image
  int uploadType = 0;
  String avatarImage = '';
  DateTime? changedDate;

  DateTime selectedDate =
      DateTimeHelper.getDateInEnglish(UserSessionDataModel.birthday);

  late ValueNotifier<String> selectedDateListen =
      ValueNotifier(DateTimeHelper.getFormatedDate(selectedDate));

  String selectedAddress = '';

  /// Getters and Setters

  /// Methods

  getProfile() {
    userCubit.getProfile(GetProfileParams(id: UserSessionDataModel.userId));
  }

  onProfileGettingDone(GetProfileEntity getProfileEntity) async {
    await UserSessionDataModel.updateProfileData(getProfileEntity);
    getAvatar();
    getAddresses();
    notifyListeners();
  }

  changeProfileImage(int index) async {
    uploadType = 0;
    if (Platform.isIOS) {
      if (index == 0) {
        final ImagePicker _picker = ImagePicker();
        XFile? result = await _picker.pickImage(source: ImageSource.camera);
        CroppedFile? croppedFile = await ImageCropper().cropImage(
            sourcePath: result!.path,
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
        if (result != null) {
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

        final ImagePicker _picker = ImagePicker();
        // Pick an image
        XFile? result = await _picker.pickImage(source: ImageSource.gallery);
        CroppedFile? croppedFile = await ImageCropper().cropImage(
            sourcePath: result!.path,
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
        if (result != null) {
          print(result.path);
          showChangeProfileDialog(
              imageUrl: result.path,
              isCircle: true,
              context: context,
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
                  lockAspectRatio: false,
                ),
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
    print(DateTimeHelper.getFormatedDate(changedDate));
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
        DateTimeHelper.getFormatedDate(changedDate),
        profileEntity.gender!,
        profileEntity.imageUrl ?? null,
        profileEntity.emailAddress!,
        profileEntity.avatarMonth,
      );
      Nav.pop();
      print('newwwwwww ');
      print(UserSessionDataModel.birthday);
      print(changedDate);
      print(DateTimeHelper.getFormatedDate(changedDate));
    }
    showSnackbar(Translation.current.updated_successfully);
    notifyListeners();
  }

  getAvatar() {
    userCubit.getMyAvatar(GetAvatarParams(
        gender: UserSessionDataModel.gender!,
        month: UserSessionDataModel.avatarMonth));
  }

  onLoadedAvatar(AvatarListEntity a) {
    if (a.myAvatar != null) {
      avatarImage = a.myAvatar!.image ?? '';
      notifyListeners();
    } else {
      avatarImage = '';
      notifyListeners();
    }
  }

  @override
  void closeNotifier() {
    this.dispose();
  }

  /// Methods
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

  ///screen Data
  getName() {
    return UserSessionDataModel.fullName;
  }

  getUserName() {
    return UserSessionDataModel.userName;
  }

  getPhoneNumber() {
    return '+${UserSessionDataModel.countryCode} ' +
        UserSessionDataModel.phoneNumber;
  }

  getEmail() {
    return UserSessionDataModel.emailAddress;
  }

  getPoints() {
    return '${UserSessionDataModel.points}';
  }

  getProfileImage() {
    return UserSessionDataModel.imageUrl;
  }

  getBirthDate() {
    return DateTimeHelper.getStringDateInEnglish(UserSessionDataModel.birthday);
  }

  getCoverImage() {
    return UserSessionDataModel.coverPhoto;
  }

  Future<DateTime?> saveDateTapper() async {
    print('aaa');
    final DateTime? se = await showCustomDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
      cancelText: Translation.current.cancel,
      confirmText: Translation.current.select,
      helpText: Translation.current.select_birth_date,
    );
    print(se);
    if (se != null) {
      changedDate = se;
      selectedDateListen.value = DateTimeHelper.getFormatedDate(se);
      return changedDate;
    } else {
      return null;
    }
  }

  changeBirthDate() {
    if (changedDate != null) {
      UpdateProfileParams updateProfileParams = UpdateProfileParams(
        name: UserSessionDataModel.name,
        imageUrl: UserSessionDataModel.imageUrl,
        phoneNumber: UserSessionDataModel.phoneNumber,
        coverImage: UserSessionDataModel.coverPhoto,
        gender: UserSessionDataModel.gender,
        date: DateTimeHelper.getFormatedDate(changedDate),
        email: UserSessionDataModel.emailAddress,
        surName: UserSessionDataModel.surname,
      );
      uploadType = 2;
      userCubit.updateProfile(updateProfileParams);
    } else {
      showSnackbar(Translation.current.select_date_first, isError: true);
    }
  }

  getAddresses() {
    userCubit
        .getAllAddresses(GetAddressParams(id: UserSessionDataModel.userId));
  }

  onAddressesLoaded(AddressListEntity allAddressesEntity) {
    if (allAddressesEntity.addresses.isEmpty) {
      return;
    } else {
      getSelectedOne(allAddressesEntity);
    }
  }

  getSelectedOne(AddressListEntity allAddressesEntity) {
    selectedAddress = '';
    AddressEntity? selected;
    allAddressesEntity.addresses.forEach((element) {
      if (element.isDefault ?? false) {
        selected = element;
      }
    });
    if (selected != null) {
      selectedAddress += selected!.cityName ?? '';
    }
    notifyListeners();
  }
}
