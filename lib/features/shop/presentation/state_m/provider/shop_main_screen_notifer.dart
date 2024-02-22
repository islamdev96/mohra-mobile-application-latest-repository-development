import 'package:flutter/cupertino.dart';
import 'package:provider/src/provider.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/common/provider/cart.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/app_main_screen_notifier.dart';

class ShopMainScreenNotifier extends ScreenNotifier {
  late BuildContext context;
  static const NAV_ICON = 0;
  static const NAV_TITLE = 1;
  late PageController controller;
  int _selectedIndex = 0;

  /// Getters and Setters
  int get selectedIndex => this._selectedIndex;

  set selectedIndex(int value) {
    this._selectedIndex = value;
    notifyListeners();
  }

  Future<bool> willPopCallback() async {
    onHomeDoubleTap();
    return true;
  }

  setPageController(PageController controller, bool isOrder) async {
    if (isOrder) {
      await Future.delayed(const Duration(milliseconds: 200)).then((value) {
        this.controller = controller;
        selectedIndex = 1;
        _selectedIndex = 1;
        onBottomNavigationTap(1);
      });
    } else {
      await Future.delayed(const Duration(milliseconds: 200)).then((value) {
        this.controller = controller;
        selectedIndex = 0;
        _selectedIndex = 0;
      });
    }

    notifyListeners();
  }

  /// Methods
  @override
  void closeNotifier() {
    controller.dispose();
  }

  void onBottomNavigationTap(int value) {
    if (value == 0 && selectedIndex == 0) {
      onHomeDoubleTap();
    }
    controller.jumpToPage(
      value,
    );
    selectedIndex = value;
    notifyListeners();
  }



  void onHomeDoubleTap() {
    context.read<AppMainScreenNotifier>().controller!.jumpToPage(0);
    Nav.pop();
  }
}
