import 'package:flutter/material.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class EventGalleryScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  late List<String> _images;
  late int _imageToDisplay;

  /// Getters and Setters

  List<String> get images => _images;

  set images(List<String> value) {
    _images = value;
  }

  int get imageToDisplay => _imageToDisplay;

  set imageToDisplay(int value) {
    _imageToDisplay = value;
    notifyListeners();
  }

  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }
}
