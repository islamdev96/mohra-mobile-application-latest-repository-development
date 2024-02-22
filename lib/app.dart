import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/features/splash/presentation/screen/splash_screen.dart';
import 'core/common/provider/provider_list.dart';
import 'core/constants/app/app_constants.dart';
import 'core/datasources/shared_preference.dart';
import 'core/firebase/notification_middleware.dart';
import 'core/localization/flutter_localization.dart';
import 'core/navigation/navigation_service.dart';
import 'core/navigation/route_generator.dart';
import 'di/service_locator.dart';
import 'features/booking/presentation/screen/all_booking_screen/all_booking_screen.dart';
import 'features/booking/presentation/screen/home_screen/booking_services_screen.dart';
import 'features/booking/presentation/screen/profile_booking_member_screen/profile_booking_screen.dart';
import 'features/booking/presentation/screen/services_detalis/services_details_screen.dart';
import 'features/home_services/presentation/screen/home_screen/home_services_screen.dart';
import 'generated/l10n.dart';
import 'home_screen.dart';

class App extends StatefulWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  AppLifecycleState _appLifecycleState = AppLifecycleState.resumed;

  @override
  void initState() {
    FlutterAppBadger.removeBadge();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }


  // restart() {
  //   RestartWidget.restartApp(getIt<NavigationService>().appContext!);
  // }

  @override
  Widget build(BuildContext context) {
    return RestartWidget(
      child: MultiProvider(
        providers: [
          ...ApplicationProvider().dependItems,
        ],
        child: Consumer<LocalizationProvider>(
          builder: (_, provider, __) {
            return ScreenUtilInit(
              designSize: AppConfig.screenUtilDesignSize(),
              builder: (context, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: AppConstants.TITLE_APP_NAME,

                  /// Routing
                  navigatorKey: getIt<NavigationService>().getNavigationKey,
                  onGenerateRoute: getIt<NavigationRoute>().generateRoute,
                  initialRoute: "/",
                  navigatorObservers: [],

                  /// Setup app localization
                  supportedLocales: Translation.delegate.supportedLocales,
                  locale: provider.appLocal,
                  localizationsDelegates: [
                    Translation.delegate,
                    // Built-in localization of basic text for Material widgets
                    GlobalMaterialLocalizations.delegate,
                    // Built-in localization for text direction LTR/RTL
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    DefaultCupertinoLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate
                  ],

                  /// Run app at first time on device language
                  localeResolutionCallback: (locale, supportedLocales) {
                    if (provider.firstStart) {
                      /// Check if the current device locale is supported
                      for (var supportedLocale in supportedLocales) {
                        if (supportedLocale.languageCode ==
                            locale!.languageCode) {
                          /// Set _firstStart false
                          provider.firstStartOff();

                          /// Change language
                          provider.changeLanguage(
                            const Locale("ar"),
                            context,
                          );
                          AppConfig().setAppLanguage = "ar";
                          return supportedLocale;
                        }
                      }

                      /// If the locale of the device is not supported, use the first one
                      /// from the list (English, in this case).
                      provider.changeLanguage(
                        supportedLocales.first,
                        context,
                      );
                      AppConfig().setAppLanguage =
                          supportedLocales.first.languageCode;
                      return supportedLocales.first;
                    } else
                      return null;
                  },

                  /// Theming
                  theme: AppConfig().themeData,
                  themeMode: AppConfig().themeMode,

                  /// Init match
                  //  home: HomeScreen(),
                  home: SplashScreen(),
                  // home: BookingServicesScreen(),
                  // home: ProfileBookingScreen(),
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    ApplicationProvider().dispose(context);
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }
}
