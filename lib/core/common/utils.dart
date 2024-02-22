import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart' as intl;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/extensions/logger_extension.dart';
import 'package:starter_application/core/common/provider/cart.dart';
import 'package:starter_application/core/common/provider/session_data.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/app_theme_enum.dart';
import 'package:starter_application/core/constants/enums/custom_file_type.dart';
import 'package:starter_application/core/constants/enums/event_ticket_type.dart';
import 'package:starter_application/core/datasources/shared_preference.dart';
import 'package:starter_application/core/localization/flutter_localization.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/core/theme/theme_colors.dart';
import 'package:starter_application/core/theme/theme_config.dart';
import 'package:starter_application/core/ui/custom_map/logic/location_wrapper.dart';
import 'package:starter_application/core/ui/dialogs/custom_dialogs.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/account/presentation/screen/login_screen.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/app_main_screen_notifier.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/global_messages_notifier.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../features/splash/presentation/screen/splash_screen.dart';
import '../navigation/nav.dart';
import '/core/ui/custom_map/logic/location_extesions.dart';
import 'app_config.dart';

/// This function for move cursor from A to B
/// and will be take 3 parameter
/// [context] to know which match we are
/// [currentFocus] where are you now ? which text form field
/// [nextFocus] where will be when called this function
/// [changeTheme] to change application theme
fieldFocusChange(
  BuildContext context,
  FocusNode currentFocus,
  FocusNode nextFocus,
) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

/// This for unFocus nodes
unFocusList({required List<FocusNode> focus}) {
  focus.forEach((element) {
    element.unfocus();
  });
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

changeTheme(BuildContext context) async {
  var brightness = Theme.of(context).brightness;
  await AppConfig().persistAppTheme(
    brightness == Brightness.light ? AppThemes.DARK : AppThemes.LIGHT,
  );
  ThemeSwitcher.of(context).changeTheme(
    theme: brightness == Brightness.light
        ? getIt<ThemeConfig>().darkTheme
        : getIt<ThemeConfig>().lightTheme,
    isReversed: brightness == Brightness.dark ? true : false,
  );
  ThemeColors().updateThemeMode();
}

logout() async {
  // if (await AccountRepository.hasToken){
  //   await GetIt.I<AccountRepository>().deleteToken();
  //   Navigator.of(NavigationService.instance.navigatorKey.currentContext!).pushNamedAndRemoveUntil(LoginScreen.routeName,(Route<dynamic> route) => false);
  // }

  // ! Just for testing
  Provider.of<GlobalMessagesNotifier>(AppConfig().appContext, listen: false)
      .logout();
  print('aaaadsd');
  final session = Provider.of<SessionData>(
      getIt<NavigationService>().appContext!,
      listen: false);
  print('aaaadsdggggggg');
  await session.clear();

  /// delete health and personality attributes

  final prefs = await SpUtil.getInstance();
  prefs.remove(AppConstants.HEALTH_PROFILE_DONE);
  prefs.remove(AppConstants.HAS_PERSONALITY_AVATAR);
  prefs.remove(AppConstants.HEALTH_QUESTION_ANSWER_DONE);
  prefs.remove('userAddress');
  await UserSessionDataModel.removeAll();

  /// Clear the cart
  AppConfig().appContext.read<Cart>().clear();
  RestartWidget.restartApp(getIt<NavigationService>().appContext!);
}

logoutWithoutRestart() async {
  // if (await AccountRepository.hasToken){
  //   await GetIt.I<AccountRepository>().deleteToken();
  //   Navigator.of(NavigationService.instance.navigatorKey.currentContext!).pushNamedAndRemoveUntil(LoginScreen.routeName,(Route<dynamic> route) => false);
  // }

  // ! Just for testing
  Provider.of<AppMainScreenNotifier>(
          getIt<NavigationService>().getNavigationKey.currentContext!,
          listen: false)
      .selectedIndex = 0;
  await Provider.of<GlobalMessagesNotifier>(AppConfig().appContext,
          listen: false)
      .logout();
  final session = Provider.of<SessionData>(
      getIt<NavigationService>().appContext!,
      listen: false);

  await session.clear();

  /// delete health and personality attributes

  final prefs = await SpUtil.getInstance();
  prefs.remove(AppConstants.HEALTH_PROFILE_DONE);
  prefs.remove(AppConstants.HAS_PERSONALITY_AVATAR);
  prefs.remove(AppConstants.HEALTH_QUESTION_ANSWER_DONE);
  prefs.remove('userAddress');
  await UserSessionDataModel.removeAll();

  /// Clear the cart
  await AppConfig().appContext.read<Cart>().clear();
  Nav.toAndRemoveAll(LoginScreen.routeName);
}

/// Temps for testing

Future<void> storeName(List<String> name) async {
  final sp = await SpUtil.instance;
  sp.putStringList("name", name);
}

Future<List<String>?> getName() async {
  final sp = await SpUtil.instance;
  return sp.getStringList("name");
}

Future<void> storeSpotifyAuth(String authToken) async {
  final sp = await SpUtil.instance;
  sp.putString(AppConstants.KEY_SPOTIFY_AUTH, authToken);
}

Future<String?> getSpotifyAuth() async {
  final sp = await SpUtil.instance;
  return sp.getString(AppConstants.KEY_SPOTIFY_AUTH);
}

Future<void> storeUserId(int id) async {
  final sp = await SpUtil.instance;
  sp.putInt(AppConstants.KEY_USERID, id);
}

Future<int?> getUserId() async {
  final sp = await SpUtil.instance;
  return sp.getInt(AppConstants.KEY_USERID);
}

Future<void> clearUserId() async {
  final sp = await SpUtil.instance;
  await sp.remove(AppConstants.KEY_USERID);
}

Future<String?> getToken() async {
  final sp = await SpUtil.instance;
  return sp.getString(AppConstants.KEY_TOKEN);
}

Future<void> clearName() async {
  final sp = await SpUtil.instance;
  await sp.remove("name");
}

Future<void> cleartoken() async {
  final sp = await SpUtil.instance;
  await sp.remove(AppConstants.KEY_TOKEN);
}

String dayTimeTitle() {
  var timeNow = DateTime.now().hour;

  // if ((timeNow == 5) || (timeNow < 12)) {
  //   return Translation.current.good_morning;
  // } else if ((timeNow >= 12) && (timeNow <= 18)) {
  //   return Translation.current.good_afternoon;
  // } else if ((timeNow > 18) || (timeNow < 5)) {
  //   return Translation.current.good_evening;
  // } else {
  //   return Translation.current.good_night;
  // }
  if (timeNow >= 5 && timeNow < 12) {
    return Translation.current.good_morning;
  } else if (timeNow >= 12 && timeNow < 18) {
    return Translation.current.good_afternoon;
  } else {
    return Translation.current.good_night;
  }
}

Size textSize(
  String text,
  TextStyle style, {
  double? maxWidth,
  int? maxLines,
  StrutStyle? strutStyle,
}) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(
      text: text,
      style: style.copyWith(
        fontFamily: style.fontFamily == null
            ? Theme.of(AppConfig().appContext).textTheme.bodyText1!.fontFamily
            : style.fontFamily,
      ),
    ),
    maxLines: maxLines,
    strutStyle: strutStyle,
    textDirection: TextDirection.ltr,
  )..layout(minWidth: 0, maxWidth: maxWidth ?? double.infinity);
  return textPainter.size;
}

String getTodayFormattedDate() {
  return "${Translation.current.today} ${intl.DateFormat("dd, MMMM yyyy").format(DateTime.now())}";
}

String getAmPm(String time) {
  final extractedTime = time.split(":");
  final hour = int.tryParse(extractedTime[0])!;
  final minute = int.tryParse(extractedTime[1])!;
  return intl.DateFormat("hh:mm aa")
      .format(DateTime(1992, 1, 1, hour, minute))
      .toString();
}

Future<LatLng?> getUserLocationLogic({
  VoidCallback? onRetryTap,
  VoidCallback? onBackTap,
  VoidCallback? onData,
  bool withoutDialogue = false,
}) async {
  LocationPermission locationPermission = await Geolocator.checkPermission();
  bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
  if (locationPermission.index == LocationPermission.denied.index ||
      !isLocationServiceEnabled) {
    await Geolocator.requestPermission();
    // await Geolocator.openLocationSettings();
  }
  Position? position;
  try {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  } catch (e) {}
  print("latlang is is is ${position.toString()}");
  if (position == null) {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (locationPermission.index == LocationPermission.denied.index ||
        !isLocationServiceEnabled) {
      await Geolocator.requestPermission();
      // await Geolocator.openLocationSettings();
    }
    if (!withoutDialogue)
      showCustomConfirmCancelDialog(
          mainContext: AppConfig().appContext,
          isDismissible: true,
          cancelText: Translation.current.back,
          title: Translation.of(AppConfig().appContext).errorOccurred,
          content: Translation.current.Could_not_get_your_location,
          confirmText: Translation.current.Open_settings,
          onConfirm: (_) async {
            if (withoutDialogue)
              onRetryTap?.call();
            else {
              await Geolocator.openLocationSettings().then((value) {
                getUserLocationLogic(
                  withoutDialogue: withoutDialogue,
                  onBackTap: onBackTap,
                  onRetryTap: onRetryTap,
                );
                onData?.call();
              });
              onData?.call();
              Nav.pop();
            }
            // getUserLocationLogic(onRetryTap: onRetryTap,onBackTap: onBackTap,withoutDialogue: withoutDialogue);
            // Nav.pop();
          },
          onCancel: (_) {
            // onBackTap?.call();
            Nav.pop();
            Nav.pop();
          });
    return null;
  }
  return LatLng(position.latitude, position.longitude);
}

String getPlacePhotoUrl(String photoReference) {
  return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${photoReference}&key=${AppConstants.API_KEY_GOOGLE_MAPS}";
}

String getArtists(List<String> artists) {
  return artists.map((e) => e).fold<String>(
        "",
        (previousValue, element) =>
            "${previousValue}${(element.isNotEmpty && previousValue.isNotEmpty) ? "," : ""} ${element}",
      );
}

String formattedDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  if (duration.inHours == 0) return "$twoDigitMinutes:$twoDigitSeconds";
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

String? imageToBase64(Uint8List bytes) {
  try {
    return base64Encode(
      bytes,
    );
  } catch (e) {
    "$e".logE;
    return null;
  }
}

String getTicketTypeName(int type) {
  print('asdasfdsdasasd $type');
  if (type == EventTicketType.SILVER.index) return Translation.current.silver;
  if (type == EventTicketType.GOLDEN.index) return Translation.current.golden;
  if (type == EventTicketType.PLATINUM.index)
    return Translation.current.platinum;
  if (type == EventTicketType.VIP.index) return Translation.current.vip;
  if (type == EventTicketType.FREE.index)
    return Translation.current.free;
  else
    return '';
}

/// Get path extension Ex:Input: /xxx/xxx/name.mp4 , Output: mp4

String getFileExtension(String path) {
  return path.split("/").last.split('.').last;
}

CustomFileType getFileType(String path) {
  final extension = getFileExtension(path);
  if (extension == 'jpg' || extension == 'png' || extension == 'svg')
    return CustomFileType.IMAGE;
  if (extension == 'mp4' || extension == 'MOV' || extension == 'mov')
    return CustomFileType.VIDEO;
  return CustomFileType.DOC;
}

/// Create temp asset file and return it
Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load(path);
  final buffer = byteData.buffer;
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  var filePath = tempPath +
      '/file_01.${getFileExtension(path)}'; // file_01.tmp is dump file, can be anything
  return File(filePath).writeAsBytes(
      buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
}

String getPlaceMarkInfo(Placemark placeMark) {
  return '${placeMark.street},${placeMark.country}';
}

Future<String> createFolder({String? type}) async {
  if (!await Permission.storage.request().isGranted) return '';
  String root = '';
  var iosRoot;
  if (Platform.isIOS) {
    iosRoot = await getApplicationSupportDirectory();
  } else {
    root = await ExternalPath.getExternalStoragePublicDirectory(
        type ?? ExternalPath.DIRECTORY_DOCUMENTS);
  }
  var dir;
  if (Platform.isIOS) {
    dir = iosRoot;
  } else {
    dir = Directory(root);
  }

  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
  if ((await dir.exists())) {
    return dir.path;
  } else {
    try {
      await dir.create(recursive: true);
    } catch (e) {
      print(e.toString());
    }
    return dir.path;
  }
}
