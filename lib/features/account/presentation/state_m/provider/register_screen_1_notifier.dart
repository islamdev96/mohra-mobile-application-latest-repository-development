import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/dialogs/show_custom_date_picker.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/features/account/data/model/request/register_request.dart';
import 'package:starter_application/features/account/presentation/screen/register_screen2.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../../main.dart';

class RegisterScreen1Notifier extends ScreenNotifier {
  late BuildContext context;

  /// Variables
  bool inAsyncCall = false;
  DateTime? _date;
  bool _checkBox = false;
  bool _isDateValidate = false;
  RegisterRequest registerRequest = RegisterRequest();

  final FocusNode myFocusNodeName = FocusNode();
  final FocusNode myFocusNodeLastName = FocusNode();

  // Key
  final nameKey = new GlobalKey<FormFieldState<String>>();
  final lastNameKey = new GlobalKey<FormFieldState<String>>();

  // Controller
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();

  /// Methods

  moveToNextPage(int cake) {
    // setFakeDate();
    if (nameKey.currentState!.validate() &&
        lastNameKey.currentState!.validate()) {
      if(nameController.text.length > 20){
        showSnackbar(Translation.current.first_name_validator , isError: true);
      }
      else if (lastNameController.text.length > 20){
        showSnackbar(Translation.current.last_name_validator , isError: true);
      }
      else{
        // if (date != null) {
          registerRequest.firstName = nameController.text;
          registerRequest.lastName = lastNameController.text;
          registerRequest.cake = cake;
          registerRequest.birthDate = date != null ? date!.toLocal().toString() : null;
          Nav.to(RegisterScreen2.routeName, arguments: registerRequest);
        // }
      }
    }
    isDateValidate = true;
  }

  /// Getters and Setters

  bool get checkBox => _checkBox;

  set checkBox(bool value) {
    _checkBox = value;
    notifyListeners();
  }

  unFocus() {
    unFocusList(focus: [
      myFocusNodeName,
      myFocusNodeLastName,
    ]);
  }

  /// Getters and Setters

  DateTime? get date => this._date/* ?? DateTime(1980)*/;

  set date(DateTime? date) {
    this._date = date;
    notifyListeners();
  }

  bool get isDateValidate => this._isDateValidate;

  set isDateValidate(bool value) {
    this._isDateValidate = value;
    notifyListeners();
  }


  // setFakeDate(){
  //   date = DateTime(1980);
  // }

  Future<void> onDatePickerTap() async {
    isDateValidate = true;

    if (FocusScope.of(context).hasFocus) FocusScope.of(context).unfocus();

    if (Platform.isAndroid) {
      final selectedDate = await showCustomDatePicker(
        context: context,
        locale:  isArabic ? Locale("ar") : Locale("en"),
        initialDate: date ?? DateTime.now(),
        firstDate: DateTime(1980),
        lastDate: DateTime.now(),
      );
      if (selectedDate != null) {
        date = selectedDate;
      }
    }
    else if (Platform.isIOS) {
      _showDialog();
    }
  }

  @override
  void closeNotifier() {
    myFocusNodeName.dispose();
    myFocusNodeLastName.dispose();
    nameController.dispose();
    lastNameController.dispose();
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
                        initialDateTime: DateTime.now(),
                        maximumDate: DateTime.now(),
                        onDateTimeChanged: (DateTime value) {
                          print(value);
                          date = value;
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
                          date = null;
                          Nav.pop();
                        },
                      ),
                      CustomMansourButton(
                        width: 150,
                        titleText: Translation.current.confirm,
                        textColor: AppColors.lightFontColor,
                        onPressed: () {
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
