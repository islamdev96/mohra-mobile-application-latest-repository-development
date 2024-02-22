import 'package:flutter/material.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/messages/presentation/screen/create_event_screen.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';
import 'messages_screen_notifie.dart';

class EventIntroScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;

  /// Getters and Setters

  /// Methods
  void navTOCreateSplitScreen() {
    Nav.to(EventScreen.routeName);
  }

  @override
  void closeNotifier() {
    this.dispose();
  }
}
