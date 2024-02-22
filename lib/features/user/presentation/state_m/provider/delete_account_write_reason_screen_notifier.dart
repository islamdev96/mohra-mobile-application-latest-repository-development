import 'package:flutter/material.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';

class DeleteAccountWriteReasonScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  String selectedReason = '';
  String writtenReason = '';
  List<String> selectedReasons = [

  ];
  /// Getters and Setters

  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }

  TextEditingController  textEditingController = TextEditingController();
}
