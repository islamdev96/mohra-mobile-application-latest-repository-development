import 'package:flutter/material.dart';
import 'package:starter_application/features/religion/presentation/logic/quran_classes.dart';
import 'package:starter_application/features/religion/presentation/logic/quran_utils.dart';
import 'package:starter_application/features/religion/presentation/state_m/provider/surah_details_screen_notifier.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class JuzDetailsScreenNotifier extends ScreenNotifier {
  JuzDetailsScreenNotifier(this.juzInfo) {
    juz = QUtils.getJuz(juzInfo.num);
  }

  /// Fields
  late BuildContext context;
  final JuzInfo juzInfo;
  late final String juz;
  int? _selectedAyahIndex;
  QuranStyle _style = QuranStyle.ArabicClassic;

  /// Getters and Setters
  int? get selectedAyahIndex => this._selectedAyahIndex;
  QuranStyle get style => this._style;

  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }

  onAyahTap(int index) {
    _selectedAyahIndex = index;
    notifyListeners();
  }

  void onStyleChanged(QuranStyle? value) {
    _style = value!;
    notifyListeners();
  }
}
