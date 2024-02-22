
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/core/ui/dialogs/show_custom_date_picker.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_error_snackbar.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/health/data/model/request/daily_dish_params.dart';
import 'package:starter_application/features/health/data/model/request/image_params.dart';
import 'package:starter_application/features/health/domain/entity/daily_dish_entity.dart';
import 'package:starter_application/features/health/domain/entity/image_urls_entity.dart';
import 'package:starter_application/features/health/presentation/screen/health_main_screen.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/home/presentation/screen/app_main_screen.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/app_main_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';
import 'health_main_screen_notifier.dart';

class CreateCaloriesScreenNotifier extends ScreenNotifier {
  /// Fields
  List<XFile> _imagesFiles = [];
  bool _isTrackWalletOn = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();
  TextEditingController fatController = TextEditingController();
  TextEditingController carbsController = TextEditingController();
  TextEditingController protenController = TextEditingController();
  final healthCubit = HealthCubit();
  DateTime _birthDay = DateTime.now();
  late BuildContext context;
  String _imageServerUrl = '';
  String postMessage = '';
  String _createDateTime = Provider.of<AppMainScreenNotifier>(getIt<NavigationService>().getNavigationKey.currentContext!, listen: false).dateTime;
  bool dateSelected = false;
  final int foodType;

  CreateCaloriesScreenNotifier(this.foodType);

  /// Getters and Setters
 DateTime get birthDay => _birthDay;
  String get createDateTime => _createDateTime;
  List<String> get imagesPaths => _imagesFiles.map((e) => e.path).toList();

  bool get isTrackWalletOn => this._isTrackWalletOn;

  String get imageServerUrl => _imageServerUrl;

  /// Methods
  void changeBirthDay(DateTime dateTime) {
    this._birthDay = dateTime;
    this._createDateTime = DateFormat('yyyy-MM-dd', 'en').format(dateTime);
    Provider.of<AppMainScreenNotifier>(getIt<NavigationService>().getNavigationKey.currentContext!, listen: false).dateTime  = _createDateTime;
    notifyListeners();
  }
  @override
  void closeNotifier() {
    this.dispose();
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
  void onImagesPicked(List<XFile> imagesFiles) {
    _imagesFiles.addAll(imagesFiles);
    notifyListeners();
  }
  onImageDeleted(int index) {
    _imagesFiles.removeAt(index);
    notifyListeners();
  }

  void onTrackWalletSwitchChange(bool value) {
    _isTrackWalletOn = value;
    notifyListeners();
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

  void onImageUploaded(ImageUrlsEntity imageUrlsEntity) {
    this._imageServerUrl = imageUrlsEntity.urls.first;
    healthCubit.createDailyDish(
      DailyDishParams(
        type: this.foodType,
        amountOfCalories: caloriesController.text.isEmpty ? null : replaceFarsiNumber(caloriesController.value.text),
        dishImage: this._imageServerUrl,
        dishName: nameController.value.text,
        carbs: carbsController.text.isEmpty ? null : replaceFarsiNumber(carbsController.text),
        fats: fatController.text.isEmpty ? null : replaceFarsiNumber(fatController.text),
        protein: protenController.text.isEmpty ? null : replaceFarsiNumber(protenController.text),
        creationTime: Provider.of<AppMainScreenNotifier>(getIt<NavigationService>().getNavigationKey.currentContext!, listen: false).dateTime.toString()//TODO complete this
      ),
    );
    notifyListeners();
  }
  String replaceFarsiNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(farsi[i], english[i]);
    }

    return input;
  }
  onSavePressed() {
    if (canSave()) {
      if(_imagesFiles.isNotEmpty){
        healthCubit.uploadImage(ImageParams(image: this._imagesFiles.first));
      }
      else{
        healthCubit.createDailyDish(
          DailyDishParams(
            type: this.foodType,
            amountOfCalories: caloriesController.text.isEmpty ? null : replaceFarsiNumber(caloriesController.value.text),
            dishImage: null,
            dishName: nameController.value.text,
            carbs: carbsController.text.isEmpty ? null : replaceFarsiNumber(carbsController.text),
            fats: fatController.text.isEmpty ? null : replaceFarsiNumber(fatController.text),
            protein: protenController.text.isEmpty ? null : replaceFarsiNumber(protenController.text),
            creationTime: Provider.of<AppMainScreenNotifier>(getIt<NavigationService>().getNavigationKey.currentContext!, listen: false).dateTime.toString()//TODO complete this
          ),
        );
      }
      notifyListeners();
    } else {
      showErrorSnackBar(message: Translation.current.name_is_required);
    }
  }

  notify() {
    notifyListeners();
  }

  onDailyDishCreated() {
    notifyListeners();
    Nav.toAndPopUntil(HealthMainScreen.routeName, AppMainScreen.routeName,
        arguments: BottomNavBarInitIndex(index: 2));
  }

  bool canSave() {
    if (nameController.text.isNotEmpty) return true;
    return false;
  }
}
