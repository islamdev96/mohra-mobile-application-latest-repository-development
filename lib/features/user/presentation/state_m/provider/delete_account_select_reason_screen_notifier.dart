import 'package:flutter/material.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';
import '../../../../../generated/l10n.dart';

class DeleteAccountSelectReasonScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
   int valueSelected = -1;
    List<String> reasons  = [
     Translation.current.something_broken,
      Translation.current.privacy_concern,
      Translation.current.no_friends,
      Translation.current.dont_like_it,
      Translation.current.prefer_not_to_answer,
  ];

  /// Getters and Setters

  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }
}
