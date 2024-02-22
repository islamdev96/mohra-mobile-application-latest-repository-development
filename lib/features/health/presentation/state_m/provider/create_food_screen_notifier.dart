import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class CreateFoodScreenNotifier extends ScreenNotifier {
  /// Fields
  List<XFile> _imagesFiles = [];

  late BuildContext context;

  /// Getters and Setters
  List<String> get imagesPaths => _imagesFiles.map((e) => e.path).toList();

  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }

  void onImagesPicked(List<XFile> imagesFiles) {
    _imagesFiles.addAll(imagesFiles);
    notifyListeners();
  }
  onImageDeleted(int index) {
    _imagesFiles.removeAt(index);
    notifyListeners();
  }
}
