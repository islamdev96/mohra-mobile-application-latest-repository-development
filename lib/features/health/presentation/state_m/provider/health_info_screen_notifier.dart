import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/dialogs/show_custom_date_picker.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_error_snackbar.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/features/health/presentation/logic/profile_info/info_temp_model.dart';
import 'package:starter_application/features/health/presentation/screen/weight_summary_screen.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class HealthInfoScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  DateTime _birthDay = DateTime.now();
  String _dateOfBirth = UserSessionDataModel.birthday != '' ? DateFormat('yyyy-MM-dd', 'en').format( DateTime.tryParse(UserSessionDataModel.birthday) ?? DateTime.parse(UserSessionDataModel.birthday))  : DateFormat('yyyy-MM-dd', 'en').format( DateTime.now());
  bool dateSelected = false;
  var formkey = GlobalKey<FormState>();
  int gender = -1;
  double weight = 0.0;
  double height = 0.0;
  int healthSituation = -1;

  /// Getters and Setters
  DateTime get birthDay => _birthDay;

  String get dateOfBirth => _dateOfBirth;

  /// Methods
  void changeBirthDay(DateTime dateTime) {
    this._birthDay = dateTime;
    this._dateOfBirth = DateFormat('yyyy-MM-dd', 'en').format(dateTime);
    notifyListeners();
  }

  @override
  void closeNotifier() {
    this.dispose();
  }

  void onContinueTap() {
    if(formkey.currentState!.validate()){
      if (allDataDone()) {
        HealthProfileInfoTempModel tempModel = HealthProfileInfoTempModel(
          gender: this.gender,
          height: this.height,
          weight: this.weight,
          birthDate: this._dateOfBirth,
          healthSituation: this.healthSituation,
        );
        Nav.to(WeightSummaryScreen.routeName, arguments: tempModel);
      } else {
        showErrorSnackBar(
            context: context, message: Translation.current.all_fields_required);
      }
    }
    // if(!heightValidator()){
    //   showErrorSnackBar(
    //       context: context, message: Translation.current.The_height_must_be_real_not_imaginary);
    // }
    // if(!weightValidator()){
    //   showErrorSnackBar(
    //       context: context, message: Translation.current.The_weight_must_be_real_not_imaginary);
    // }
    // if(weightValidator() && heightValidator()){
    //
    // }
  }

  bool weightValidator(){
    if(this.weight  >= 30 && this.weight  <= 300){
      return true;
    }else{
      return false;
    }
  }

  bool heightValidator(){
    if(this.height  >= 70 && this.height  <= 220){
      return true;
    }else{
      return false;
    }
  }


  bool allDataDone() {
    print('date is');
    print(dateSelected);
    if (this.weight != 0.0 &&
        this.height != 0.0 &&
        this.healthSituation != -1 &&
        this.gender != -1 ){
      return true;
    }
    return false;
  }

  onDatePick()async{
    if (Platform.isAndroid){
       print('aaa');
    final DateTime? se = await showCustomDatePicker(
      context: context,
      initialDate: birthDay,
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
      cancelText: Translation.current.cancel,
      confirmText: Translation.current.select,
      // locale: Locale('en'),
      helpText: Translation.current.select_birth_date,
    );
    print(se);
    if (se != null) {
      // todo: assign selected date to sn _birthDay
      changeBirthDay(se);
      dateSelected = true;
    }
    }else{
      _showDialog();
    }


  }

  void _showDialog() {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 350,
          padding: const EdgeInsets.only(top: 6.0),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: Column(
            children: [
              SafeArea(
                top: false,
                child: Container(
                  height: 216,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: birthDay,
                    maximumDate: DateTime.now(),
                    onDateTimeChanged: (DateTime value) {
                      print(value);
                      changeBirthDay(value);
                      dateSelected = true;
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomMansourButton(
                    width: 150,
                    titleText: Translation.current.cancel,
                    backgroundColor: Colors.white,
                    borderColor: AppColors.primaryColorLight,
                    textColor: AppColors.primaryColorLight,
                    onPressed: () {
                      changeBirthDay(DateTime.now());
                      dateSelected = false;
                      Nav.pop();
                    },
                  ),
                  CustomMansourButton(
                    width: 150,
                    titleText: Translation.current.confirm,
                    textColor: AppColors.lightFontColor,
                    onPressed: () {
                      dateSelected = true;
                      Nav.pop();
                      notifyListeners();
                    },
                  )
                ],
              )
            ],
          ),
        ));
  }
}
