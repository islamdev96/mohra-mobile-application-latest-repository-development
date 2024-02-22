import 'package:flutter/material.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';

class ChangeEmailSuccessScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  late int type;
  /// Getters and Setters

  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }
}
