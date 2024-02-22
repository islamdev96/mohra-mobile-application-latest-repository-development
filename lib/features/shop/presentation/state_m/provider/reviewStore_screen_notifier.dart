import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_error_snackbar.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class ReviewStoreScreenNotifier extends ScreenNotifier {
  /// Fields
  List<XFile> _imagesFiles = [];
  bool _isTrackWalletOn = false;
  TextEditingController writeReviewController = TextEditingController();
  final writeReviewKey = GlobalKey<FormFieldState<String>>();
  final writeReviewFocusNode = FocusNode();

  final healthCubit = HealthCubit();
  final storCubit = ShopCubit();
  late BuildContext context;
  String _imageServerUrl = '';
  String postMessage = '';
  final int foodType;
  int? idStore;
  int experienceRate = 3;
  int profesionalismRate = 3;
  int valueRate = 3;
  int waitTimeRate = 3;

  ReviewStoreScreenNotifier(this.foodType);

  /// Getters and Setters
  List<String> get imagesPaths => _imagesFiles.map((e) => e.path).toList();

  bool get isTrackWalletOn => this._isTrackWalletOn;

  String get imageServerUrl => _imageServerUrl;

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

  void onTrackWalletSwitchChange(bool value) {
    _isTrackWalletOn = value;
    notifyListeners();
  }

  onCreateReviewPressed() {
    if (writeReviewKey.currentState!.validate() && canSave()) {
      storCubit.uploadImagesandReview(
          refType: 0,
          images: this._imagesFiles,
          coment: writeReviewController.value.text,
          id: idStore!,
          rate: 1,
          experienceRate: experienceRate,
          profesionalismRate: profesionalismRate,
          valueRate: valueRate,
          waitTimeRate: waitTimeRate);
      notifyListeners();
    } else if (_imagesFiles.isEmpty && writeReviewKey.currentState!.isValid) {
      showErrorSnackBar(
        message: Translation.current.image_required,
      );
    }
  }

  bool canSave() {
    if (writeReviewController.text.isNotEmpty && _imagesFiles.isNotEmpty)
      return true;
    return false;
  }
}
