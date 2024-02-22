import 'package:flutter/material.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';
import '../../../../../core/params/no_params.dart';
import '../../../domain/entity/about_us_entity.dart';
import '../cubit/help_cubit.dart';

class HelpScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  late AboutUsEntity aboutUsEntity;
  final helpCubit = HelpCubit();

  getAboutUs() {
    print("AboutUs");
    helpCubit.getAboutUs(NoParams());
  }

  getAboutUsLoaded(AboutUsEntity entity) {
    aboutUsEntity = entity;
    notifyListeners();
  }

  /// Getters and Setters

  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }
}
