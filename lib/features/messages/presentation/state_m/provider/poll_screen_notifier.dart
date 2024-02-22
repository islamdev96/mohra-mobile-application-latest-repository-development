import 'package:flutter/material.dart';
import 'package:starter_application/core/ui/dialogs/show_custom_date_picker.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';

class PollScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;

  /// Variables
  final FocusNode groupDetailsFocusNode = FocusNode();
  final FocusNode groupTitleFocusNode = FocusNode();
  DateTime? _date;
  bool _isDateValidate = false;
  bool isText = true;
  bool isDate = false;
  bool selectDate = true;
  bool multivotes = false;
  bool votes = false;
  bool option = false;

  /// Getters and Setters

  bool get isDateValidate => this._isDateValidate;

  set isDateValidate(bool value) {
    this._isDateValidate = value;
    notifyListeners();
  }

  bool get isSelectDateSwitch => this.selectDate;

  bool get isMultivotesSwitch => this.multivotes;

  bool get isVotesSwitch => this.votes;

  bool get isOptionSwitch => this.option;

  set isSelectDateSwitch(bool value) {
    this.selectDate = value;
    notifyListeners();
  }

  set isMultivotesSwitch(bool value) {
    this.multivotes = value;
    notifyListeners();
  }

  set isVotesSwitch(bool value) {
    this.votes = value;
    notifyListeners();
  }

  set isOptionSwitch(bool value) {
    this.option = value;
    notifyListeners();
  }

  DateTime? get date => this._date;

  set date(DateTime? date) {
    this._date = date;
    notifyListeners();
  }

  // Key
  final groupTitleKey = new GlobalKey<FormFieldState<String>>();
  final groupDetailsKey = new GlobalKey<FormFieldState<String>>();

  // Controller
  final groupTitleController = TextEditingController();
  final groupDetailsController = TextEditingController();

  /// Methods
  void onPollType() {
    isText = !isText;
    isDate = !isDate;
    notifyListeners();
  }

  Future<void> onDatePickerTap() async {
    isDateValidate = true;

    if (FocusScope.of(context).hasFocus) FocusScope.of(context).unfocus();

    final selectedDate = await showCustomDatePicker(
      context: context,
      initialDate: date ?? DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2400),
    );
    if (selectedDate != null) {
      date = selectedDate;
    }
  }

  void SelectSwitchDate(bool value) {
    selectDate = value;
    notifyListeners();
  }

  void SelectSwitchMultivotes(bool value) {
    multivotes = value;
    notifyListeners();
  }

  void SelectSwitchVotes(bool value) {
    votes = value;
    notifyListeners();
  }

  void SelectSwitchOption(bool value) {
    option = value;
    notifyListeners();
  }

  @override
  void closeNotifier() {
    this.dispose();
  }
}
