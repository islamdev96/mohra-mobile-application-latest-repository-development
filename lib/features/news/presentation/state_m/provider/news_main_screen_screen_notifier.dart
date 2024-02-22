import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/home/presentation/screen/app_main_screen.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/app_main_screen_notifier.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class NewsMainScreenScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  static const NAV_ICON = 0;
  static const NAV_TITLE = 1;
  final controller = PageController(initialPage: 0);
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

  }

  // void onBottomNavigationTap(int value) {
  //   print(value);
  //   controller.jumpToPage(
  //     value,
  //   );
  //   selectedIndex = value;
  // }

  void onBottomNavigationTap(int value) {
    if (value == 0 && selectedIndex == 0) {
      onHomeDoubleTap();
    }
    else {
      controller.jumpToPage(
        value,
      );
      selectedIndex = value;
      notifyListeners();
    }

  }

  void onHomeDoubleTap() {
    Nav.toAndRemoveAll(AppMainScreen.routeName);
  }
}
