import 'package:flutter/material.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/personality/presentation/screen/check_personality_screen.dart';

class StartPersonalityTestNotifier extends ScreenNotifier {
  late BuildContext context;

  /// Variables

  // Key

  // Controller

  @override
  void closeNotifier() {}

  void onStartPersonalityTestTap() {
     Nav.to(CheckPersonalityScreen.routeName);

  }
}
