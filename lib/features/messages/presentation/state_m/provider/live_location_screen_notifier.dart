import 'package:flutter/material.dart';
import 'package:starter_application/core/params/screen_params/live_location_screen_params.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';


class LiveLocationScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  late final LiveLocationScreenParams params;

  /// Getters and Setters
  setParams(LiveLocationScreenParams params){
    this.params = params;
  }

  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }


}
