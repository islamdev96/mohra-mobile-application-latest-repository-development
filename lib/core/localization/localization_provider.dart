import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/datasources/shared_preference.dart';
import 'package:starter_application/main.dart';

import '../constants/app/app_constants.dart';

@singleton
class LocalizationProvider extends ChangeNotifier {
  Locale _appLocale = Locale(AppConstants.LANG_EN);

  /// To know if this first time run the application or not
  bool _firstStart = false;
  bool isRestart = false;

  /// Get current Locale supported
  Locale get appLocal => _appLocale;

  String get currentLanguage => appLocal.languageCode;

  /// Get and set first start
  bool get firstStart => _firstStart;

  void firstStartOff() {
    /// firstStart = true not touchable from outside
    this._firstStart = false;
  }

  /// Fetch app locale, called in [main]
  fetchLocale() async {
    var prefs = await SpUtil.getInstance();

    /// Check if the application is first start or not
    if (prefs.getBool(AppConstants.KEY_FIRST_START) == null) {
      /// Set first start is true
      await prefs.putBool(AppConstants.KEY_FIRST_START, true);
      this._firstStart = true;
    }
    if (prefs.getString(AppConstants.KEY_LANGUAGE) == null) {
      _appLocale = Locale(AppConstants.LANG_EN);
      AppConfig().setAppLanguage = _appLocale.languageCode;

      await prefs.putString(
        AppConstants.KEY_LANGUAGE,
        AppConstants.LANG_EN,
      );
      return Null;
    }
    String? local = prefs.getString(AppConstants.KEY_LANGUAGE);
    _appLocale = Locale(local ?? AppConstants.LANG_EN);
    AppConfig().setAppLanguage = _appLocale.languageCode;

    return Null;
  }

  Future<void> changeLanguage(Locale type, BuildContext context) async {
    isRestart = true;
    notifyListeners();
    var prefs = await SpUtil.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == Locale(AppConstants.LANG_AR)) {
      _appLocale = Locale(AppConstants.LANG_AR);
      await prefs.putString(AppConstants.KEY_LANGUAGE, AppConstants.LANG_AR);
    } else {
      _appLocale = Locale(AppConstants.LANG_EN);
      await prefs.putString(AppConstants.KEY_LANGUAGE, AppConstants.LANG_EN);
    }
    isRestart = false;
    notifyListeners();
  }
}
