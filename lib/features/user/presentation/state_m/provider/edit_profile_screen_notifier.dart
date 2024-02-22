import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/dialogs/pick_image_dialog.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/features/health/data/model/request/image_params.dart';
import 'package:starter_application/features/health/domain/entity/image_urls_entity.dart';
import 'package:starter_application/features/user/data/model/request/update_profile_params.dart';
import 'package:starter_application/features/user/domain/entity/update_profile_entity.dart';
import 'package:starter_application/features/user/presentation/state_m/cubit/user_cubit.dart';
import 'package:starter_application/features/user/presentation/widget/update_profile_image_dialog.dart';
import 'package:starter_application/generated/l10n.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';
import 'package:intl/intl.dart' as intl;

class EditProfileScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final userCubit = UserCubit();
  DateTime _birthDay = DateTime.parse(UserSessionDataModel.birthday);
  String _dateOfBirth = UserSessionDataModel.birthday;
  bool dateSelected = false;
  int gender = UserSessionDataModel.gender!;
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late XFile? image;
  late String? imageUrl;

  /// Getters and Setters
  DateTime get birthDay => _birthDay;

  String get dateOfBirth => _dateOfBirth;

  /// Methods

  initData() {
    nameController.text = UserSessionDataModel.name;
    lastNameController.text = UserSessionDataModel.surname;
    emailController.text = UserSessionDataModel.emailAddress;

    oldName = UserSessionDataModel.name;
    oldLastName = UserSessionDataModel.name;
    oldEmail = UserSessionDataModel.name;

    print('gender');
    print(UserSessionDataModel.gender);
  }

  void changeBirthDay(DateTime dateTime) {
    this._birthDay = dateTime;
    this._dateOfBirth = UserSessionDataModel.birthday;
    notifyListeners();
  }

  onUpdateTapped() {
    print(gender);

    print(_birthDay);
    print(nameController.text);
    print(lastNameController.text);
    print(emailController.text);

    UpdateProfileParams updateProfileParams = UpdateProfileParams(
        name: nameController.text.isEmpty
            ? UserSessionDataModel.name
            : nameController.text,
        coverImage: '',
        imageUrl: UserSessionDataModel.imageUrl ?? null,
        phoneNumber: UserSessionDataModel.phoneNumber,
        gender: gender,
        date: intl.DateFormat("yyyy-MM-dd").format(_birthDay),
        email: emailController.text.isEmpty
            ? UserSessionDataModel.emailAddress
            : emailController.text,
        surName: lastNameController.text.isEmpty
            ? UserSessionDataModel.surname
            : lastNameController.text);
    userCubit.updateProfile(updateProfileParams);
  }

  onUpdateImageDone(ImageUrlsEntity entity) {
    UpdateProfileParams updateProfileParams = UpdateProfileParams(
        name: UserSessionDataModel.name,
        imageUrl: entity.urls.first,
        phoneNumber: UserSessionDataModel.phoneNumber,
        gender: gender,
        date: UserSessionDataModel.birthday,
        email: UserSessionDataModel.emailAddress,
        coverImage: '',
        surName: UserSessionDataModel.surname);
    userCubit.updateProfile(updateProfileParams);
    notifyListeners();
  }

  onUpdateProfleDone(UpdateProfileEntity profileEntity) {
    UserSessionDataModel.updateProfileSP(
      profileEntity.name!,
      profileEntity.surname!,
      profileEntity.fullName!,
      intl.DateFormat("yyyy-MM-dd").format(_birthDay),
      profileEntity.gender!,
      profileEntity.imageUrl ?? null,
      profileEntity.emailAddress!,
      profileEntity.avatarMonth

    );
    showSnackbar(Translation.current.updated_successfully);

    notifyListeners();
  }

  onUpdateImage() async {
    showPickImageDialog(
        onImagesPicked: (list) {
          print(list.first.path);
          image = list.first;
          Navigator.pop(context);
          showChangeProfileDialog(
              imageUrl: image!.path,
              context: context,
              onConfirm: () async {
                uploadImage();
                Nav.pop();
              });
        },
        context: context);
  }

  uploadImage() {
    userCubit.uploadImage(ImageParams(image: image!));
  }

  @override
  void closeNotifier() {
    this.dispose();
  }

  // old values
  late String oldName;
  late String oldLastName;
  late String oldEmail;
  late String oldGender;
}
