import 'package:flutter/material.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';

import '../../../../../core/navigation/nav.dart';

class SportMainScreenNotifier extends ScreenNotifier {
  late BuildContext context;

  final controller = PageController();
  int _selectedIndex = 0;

  /// Getters and Setters
  int get selectedIndex => this._selectedIndex;

  set selectedIndex(int value) {
    print(value);
    this._selectedIndex = value;
    notifyListeners();
  }

  /// Methods
  @override
  void closeNotifier() {
    controller.dispose();
  }

  void onBottomNavigationTap(int value) {
    if(selectedIndex  == 0 && value == 0){
      Nav.pop();
    }else {
      controller.jumpToPage(
        value,
      );
      selectedIndex = value;
    }
  }
}
