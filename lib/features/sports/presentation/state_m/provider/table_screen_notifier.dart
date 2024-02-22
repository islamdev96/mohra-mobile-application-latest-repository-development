import 'package:flutter/material.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';

class TableScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;

  /// Getters and Setters

  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }
}
