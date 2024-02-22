import 'dart:convert';
import 'dart:io';

import 'package:booking_system_flutter/model/user_data_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:package_info/package_info.dart';
import 'package:starter_application/core/common/app_options/app_options.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/app_theme_enum.dart';
import 'package:starter_application/core/constants/enums/system_type.dart';
import 'package:starter_application/core/datasources/shared_preference.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/core/theme/theme_config.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/di/service_locator.dart';

import '../../features/account/data/model/response/handman_login_model.dart';
import '../../main.dart';

/// This class it contain multiple core functions
/// for get device info
/// for get and set language
/// for current app theme
/// for options in application
class AppConfig {
  static final AppConfig _instance = AppConfig._internal();

  factory AppConfig() {
    return _instance;
  }

  AppConfig._internal();

  BuildContext get appContext => getIt<NavigationService>().appContext!;
  String? _appLanguage;
  final String apiKey = "";
  SystemType? _os;
  String? _currentVersion;
  String? _buildNumber;
  String? _appName;
  String? _appVersion;
  Map? _LastCard;
  AppThemes _appTheme = AppThemes.LIGHT;
  AppOptions _appOptions = AppOptions();
  bool connectEnternet = true;
  late LoginResponse handyManLoginResponse;
  late UserData? handyManUserData;

  SystemType? get os => _os;
  String bassel = "";

  setBasselValue(String value) {
    bassel = value;
  }

  String? get currentVersion => _currentVersion;

  String? get buildNumber => _buildNumber;

  String? get appVersion => _appVersion;

  Map? get LastCard => _LastCard;

  String? get appName => _appName;

  AppOptions get appOptions => _appOptions;

  bool get isLTR =>
      (appLanguage?.startsWith(AppConstants.LANG_EN) ?? false) ? true : false;

  ThemeData get themeData => _appTheme == AppThemes.LIGHT
      ? getIt<ThemeConfig>().lightTheme
      : getIt<ThemeConfig>().darkTheme;

  ThemeMode get themeMode =>
      _appTheme == AppThemes.LIGHT ? ThemeMode.light : ThemeMode.dark;

  initApp() async {
    /// get OS
    if (Platform.isIOS) {
      _os = SystemType.IOS;
    }
    if (Platform.isAndroid) {
      _os = SystemType.Android;
    }

    /// get version
    final packageInfo = await PackageInfo.fromPlatform();
    _currentVersion = packageInfo.version;
    _buildNumber = packageInfo.buildNumber;
    _appName = packageInfo.appName;

    /// Get Initital App Theme
    _appTheme = await _getAppTheme;
  }

  ///listen Change network status
  void initConnectivity() async {
    bool startUp = true;
    var connectivityResult = await (Connectivity().checkConnectivity());

    connectivityResult == ConnectivityResult.none
        ? connectEnternet = false
        : connectEnternet = true;

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // if (result == ConnectivityResult.none) {
      //   connectEnternet = false;
      //   showSnackbar(
      //       AppConfig().isLTR
      //           ? "You lost internet connection"
      //           : "فقدت الاتصال بالإنترنت",
      //       isError: true);
      //   startUp = false;
      // } else {
      //   connectEnternet = true;
      //   if (!startUp) {
      //     showSnackbar(
      //         AppConfig().isLTR
      //             ? "Your internet connection restored"
      //             : "تمت استعادة اتصالك بالإنترنت",
      //         isError: false);
      //   }
      // }
    });
  }

  /// deleteToken
  Future<void> deleteToken() async {
    final prefs = await SpUtil.getInstance();
    await prefs.remove(AppConstants.KEY_TOKEN);
  }

  /// deleteFcmToken
  Future<void> deleteFcmToken() async {
    final prefs = await SpUtil.getInstance();
    await prefs.remove(AppConstants.KEY_FIREBASE_TOKEN);
  }

  /// persistToken
  Future<void> persistToken(String token) async {
    final prefs = await SpUtil.getInstance();
    await prefs.putString(AppConstants.KEY_TOKEN, token);
  }

  /// persistCard
  Future<void> persistCard(Map<String, dynamic> card) async {
    final prefs = await SpUtil.getInstance();
    await prefs.putString(AppConstants.KEY_CARD, jsonEncode(card));
  }

  Future<Map<String, dynamic>?> get card async {
    final prefs = await SpUtil.getInstance();
    print(
        "prefs.getString(AppConstants.KEY_CARD)${prefs.getString(AppConstants.KEY_CARD)}");
    return json.decode((prefs.getString(AppConstants.KEY_CARD) ?? "{}"));
  }

  /// persistFcmToken
  Future<void> persistFcmToken(String token) async {
    final prefs = await SpUtil.getInstance();
    await prefs.putString(AppConstants.KEY_FIREBASE_TOKEN, token);
  }

  /// read authToken
  /// if returns null thats means there no SP instance
  Future<String?> get authToken async {
    final prefs = await SpUtil.getInstance();
    return prefs.getString(AppConstants.KEY_TOKEN);
  }

  /// read fcmToken
  /// if returns null thats means there no SP instance
  Future<String?> get fcmToken async {
    final prefs = await SpUtil.getInstance();
    return prefs.getString(AppConstants.KEY_FIREBASE_TOKEN);
  }

  /// check if hasToken or not
  Future<bool> get hasToken async {
    final prefs = await SpUtil.getInstance();
    String? token = prefs.getString(AppConstants.KEY_TOKEN);
    if (token != null) return true;
    return false;
  }

  /// check if hasFcmToken or not
  Future<bool> get hasFcmToken async {
    final prefs = await SpUtil.getInstance();
    String? token = prefs.getString(AppConstants.KEY_FIREBASE_TOKEN);
    if (token != null && token.isNotEmpty) return true;
    return false;
  }

  /// Persist App Theme
  Future<void> persistAppTheme(AppThemes theme) async {
    final prefs = await SpUtil.getInstance();
    await prefs.putInt(AppConstants.KEY_APP_THEME, theme.index);
    _appTheme = theme;
  }

  /// Get APP Theme
  Future<AppThemes> get _getAppTheme async {
    final prefs = await SpUtil.getInstance();
    int? token = prefs.getInt(AppConstants.KEY_APP_THEME);
    if (token == null) return AppThemes.LIGHT;
    return AppThemes.values[token];
  }

  static Size screenUtilDesignSize() {
    if (Device.get().isTablet) return Size(1536, 2048);

    if (Device.get().isPhone) return Size(1080, 1920);

    return Size(1080, 1920);
  }

  String? get appLanguage => _appLanguage;

  set setAppLanguage(String value) {
    _appLanguage = value;
    isArabic = value == "ar" ? true : false;
  }

  Future<UserData?> getHandyManService() async {
    try {
      final sp = await SpUtil.instance;
      final userDataJson = sp.getString(AppConstants.KEY_HANDYMAN_SERVICE);
      final loginResponse = json.decode(userDataJson!);
      handyManLoginResponse = LoginResponse.fromJson(loginResponse);
      handyManUserData = handyManLoginResponse.userData!;
      return handyManUserData;

    } catch (e) {
      return null;
    }
  }
}
