import 'package:flutter/material.dart';
import 'package:starter_application/core/params/screen_params/shared_qrcode_screen_params.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class SharedQrcodeScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  SharedQRCodeScreenParams params;

  SharedQrcodeScreenNotifier({required this.params});

  /// Getters and Setters

  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }
}
