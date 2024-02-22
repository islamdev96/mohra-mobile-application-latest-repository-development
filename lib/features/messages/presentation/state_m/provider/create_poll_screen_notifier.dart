import 'package:flutter/material.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/messages/presentation/screen/poll_screen.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';

class CreatePollScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;

  /// Getters and Setters

  /// Methods
  void navTOCreatePollScreen() {
    Nav.to(PollScreen.routeName);
  }

  @override
  void closeNotifier() {
    this.dispose();
  }
}
