import 'dart:io';

// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:mutex/mutex.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/app_options_enum.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/build_error_screen.dart';
import 'package:starter_application/di/service_locator.dart';

import 'app.dart';
import 'core/common/app_config.dart';
import 'core/errors/error_global_handler/catcher_handler.dart';
import 'core/errors/error_global_handler/email_manual_handler.dart';
import 'core/errors/error_global_handler/report.dart';
import 'core/firebase/notification_service.dart';
import 'core/localization/localization_provider.dart';
import 'core/net/http_overrides.dart';
import 'generated/l10n.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/services.dart';

Mutex notificationLock = Mutex();
bool isArabic = true;

bool isVisitUserMoment = true;

/*
* 	<dict>
			<key>CFBundleURLName</key>
			<string>app.mohraapp.com.ios</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string></string>
			</array>
			<key>Item 0</key>
			<string>mohraios://</string>
		</dict>
		<dict>
			<key>CFBundleURLName</key>
			<string>app.mohraapp.com.ios</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>app.mohraapp.com.ios</string>
			</array>
		</dict>*/


void main() async {
  await notificationLock.acquire();
  await _initAppConfigs();
  runApp(App());
}

late AppsflyerSdk appsflyerSdk;
late Map deepLinkData;
late Map gcd;

Future<bool?> logEvent(String eventName, Map? eventValues) async {
  bool? result;
  try {
    result = await appsflyerSdk.logEvent(eventName, eventValues);
  } on Exception catch (e) {}
  print("Result logEvent: $result");
}

_initAppConfigs() async {
  WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize();

  /// In case of network handshake error
  HttpOverrides.global = new BadCertHttpOverrides();

  /// Init firebase
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(Messaging.onNotificationReceived);
  try {
    AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
        afDevKey: "JVZnGqFrzMnjkmYunb5t6X",
        appId: "1660459382",
        showDebug: true,
        timeToWaitForATTUserAuthorization: 50,
        // for iOS 14.5
        appInviteOneLink: "https://mohra.onelink.me/QNcd/bbqz0hvq",
        // Optional field
        disableAdvertisingIdentifier: false,
        // Optional field
        disableCollectASA: false); // Optional field

    appsflyerSdk = AppsflyerSdk(appsFlyerOptions);

    appsflyerSdk.initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: true,
        registerOnDeepLinkingCallback: true);
  } catch (e) {}

  // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

  /// Injectable initialization
  await configureInjection();

  /// Init Language.
  await getIt<LocalizationProvider>().fetchLocale();

  /// Init firebase messaging
  // await Messaging.initFCM();

  /// Init app config
  AppConfig().initApp();
  AppConfig().initConnectivity();

  /// Init rotation of app (Should be called after [AppConfig.initApp()])
  await _initAppRotation();

  /// Init error catcher to catch any red match error and add ability to send
  /// a report to developer e-mail
  _initErrorCatcher();
}

Future<void> _initAppRotation() async {
  final appOption = AppConfig().appOptions;

  switch (appOption.orientation) {
    case OrientationOptions.PORTRAIT:
      await SystemChrome.setPreferredOrientations(
        [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
      );
      break;
    case OrientationOptions.LANDSCAPE:
      await SystemChrome.setPreferredOrientations(
        [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ],
      );
      break;
    case OrientationOptions.BOTH:
      await SystemChrome.setPreferredOrientations(
        [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ],
      );
      break;
  }
}

void _initErrorCatcher() {
  final appOption = AppConfig().appOptions;
  if (appOption.enableErrorCatcher) {
    /// Initialize the error match with our custom error catcher
    ErrorWidget.builder = (flutterErrorDetails) {
      final _catcherHandler = CatcherHandler();

      /// We must init the catcher handler parameters
      _catcherHandler.init();

      final context = getIt<NavigationService>().appContext;

      return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(140)),
          child: Center(
            child: FittedBox(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildErrorScreen(
                    disableRetryButton: true,
                    title: Translation.of(context!).errorOccurred,
                    content: Translation.of(context).reportError,
                    imageUrl: AppConstants.ERROR_UNKNOWING,
                    callback: null,
                    context: context,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      Translation.of(context).send,
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Report? report = _catcherHandler.createReport(
                          flutterErrorDetails.exception,
                          flutterErrorDetails.stack,
                          errorDetails: flutterErrorDetails);
                      if (report != null) {
                        EmailManualHandler(
//                          ["mostafa.mohammad.kurdi@gmail.com"],
                          ["developers109@gmail.com"],
                          emailHeader: 'MohraApp',
                          emailTitle:
                              'Error report ${DateFormat("","en").format(DateTime.now())}',
                        ).handle(report);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      );
    };
  }
}
