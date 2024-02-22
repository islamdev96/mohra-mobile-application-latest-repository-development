import 'package:flutter/material.dart';
import 'package:starter_application/features/favorite/presentation/state_m/cubit/favorite_cubit.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class FavoriteNewsScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  FavoriteCubit favoriteCubit = FavoriteCubit();

  /// Getters and Setters

  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }
}
