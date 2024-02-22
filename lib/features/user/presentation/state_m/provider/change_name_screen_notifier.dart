import 'package:flutter/material.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/features/mylife/presentation/logic/date_time_helper.dart';
import 'package:starter_application/features/user/data/model/request/update_profile_params.dart';
import 'package:starter_application/features/user/domain/entity/update_profile_entity.dart';
import 'package:starter_application/features/user/presentation/state_m/cubit/user_cubit.dart';
import 'package:starter_application/generated/l10n.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';

class ChangeNameScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  bool canSave = false;
  String oldFirstName = '';
  String oldLastName = '';
  final userCubit = UserCubit();

  /// Getters and Setters

  /// Methods

  initData() {
    oldFirstName = UserSessionDataModel.name;
    oldLastName = UserSessionDataModel.surname;
    firstNameController.text = oldFirstName;
    lastNameController.text = oldLastName;
  }

  @override
  void closeNotifier() {
    this.dispose();
  }

  canSave2() {
    if (oldFirstName != firstNameController.text ||
        oldLastName != lastNameController.text) {
      canSave = true;
    } else {
      canSave = false;
    }
    notifyListeners();
  }

  onSaveTap() {

    if (canSave) {
      if(firstNameController.text.length > 20){
          showSnackbar(Translation.current.first_name_validator , isError: true);
      }
      else if (lastNameController.text.length > 20){
        showSnackbar(Translation.current.last_name_validator , isError: true);
      }
      else{
        update();
      }
    }

  }

  update() {
    userCubit.updateProfile(
      UpdateProfileParams(
        name: firstNameController.text,
        imageUrl: UserSessionDataModel.imageUrl,
        gender: UserSessionDataModel.gender,
        date:  DateTimeHelper.getStringDateInEnglish(UserSessionDataModel.birthday) ,
        coverImage: UserSessionDataModel.coverPhoto,
        email: UserSessionDataModel.emailAddress,
        surName: lastNameController.text,
        phoneNumber: UserSessionDataModel.phoneNumber,
      ),
    );
  }

  onUpdated(UpdateProfileEntity updateProfileEntity) async {
    showSnackbar(Translation.current.updated_successfully);

   await  UserSessionDataModel.updateName(
      updateProfileEntity.name!,
      updateProfileEntity.surname!,
      updateProfileEntity.fullName!,
    );
    initData();
    notifyListeners();
  }
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
}
