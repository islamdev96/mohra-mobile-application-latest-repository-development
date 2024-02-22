import 'package:flutter/material.dart';
import 'package:booking_system_flutter/screens/splash_screen.dart'; // Replace with the actual import
import 'package:booking_system_flutter/app_theme.dart';
import 'package:booking_system_flutter/locale/app_localizations.dart';
import 'package:booking_system_flutter/locale/language_en.dart';
import 'package:booking_system_flutter/locale/languages.dart';
import 'package:booking_system_flutter/model/booking_detail_model.dart';
import 'package:booking_system_flutter/model/get_my_post_job_list_response.dart';
import 'package:booking_system_flutter/model/material_you_model.dart';
import 'package:booking_system_flutter/model/notification_model.dart';
import 'package:booking_system_flutter/model/provider_info_response.dart';
import 'package:booking_system_flutter/model/remote_config_data_model.dart';
import 'package:booking_system_flutter/model/service_data_model.dart';
import 'package:booking_system_flutter/model/service_detail_response.dart';
import 'package:booking_system_flutter/model/user_data_model.dart';
import 'package:booking_system_flutter/model/user_wallet_history.dart';
import 'package:booking_system_flutter/screens/blog/model/blog_detail_response.dart';
import 'package:booking_system_flutter/screens/blog/model/blog_response_model.dart';
import 'package:booking_system_flutter/screens/splash_screen.dart';
import 'package:booking_system_flutter/services/auth_services.dart';
import 'package:booking_system_flutter/services/chat_services.dart';
import 'package:booking_system_flutter/services/user_services.dart';
import 'package:booking_system_flutter/store/app_store.dart';
import 'package:booking_system_flutter/store/filter_store.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:booking_system_flutter/utils/configs.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import 'model/booking_data_model.dart';
import 'model/booking_status_model.dart';
import 'model/category_model.dart';
import 'model/dashboard_model.dart';
import 'network/rest_apis.dart';

AppStore appStore = AppStore();
FilterStore filterStore = FilterStore();
//endregion

//region Global Variables
BaseLanguage language = LanguageEn();
//endregion

//region Services
UserService userService = UserService();
AuthService authService = AuthService();
ChatServices chatServices = ChatServices();
RemoteConfigDataModel remoteConfigDataModel = RemoteConfigDataModel();
//endregion

//region Cached Response Variables for Dashboard Tabs
DashboardResponse? cachedDashboardResponse;
List<BookingData>? cachedBookingList;
List<CategoryData>? cachedCategoryList;
List<BookingStatusResponse>? cachedBookingStatusDropdown;
List<PostJobData>? cachedPostJobList;
List<WalletDataElement>? cachedWalletHistoryList;

List<ServiceData>? cachedServiceFavList;
List<UserData>? cachedProviderFavList;
List<BlogData>? cachedBlogList;
List<RatingData>? cachedRatingList;
List<NotificationData>? cachedNotificationList;
List<(int blogId, BlogDetailResponse list)?> cachedBlogDetail = [];
List<(int serviceId, ServiceDetailResponse list)?> listOfCachedData = [];
List<(int providerId, ProviderInfoResponse list)?> cachedProviderList = [];
List<(int categoryId, List<CategoryData> list)?> cachedSubcategoryList = [];
List<(int bookingId, BookingDetailResponse list)?> cachedBookingDetailList = [];

class MyPackageApp extends StatefulWidget {
  static const routeName = "/MyPackageApp";

  final UserData userData;
  final String languageCode;

  const MyPackageApp({
    Key? key,
    required this.userData,
    required this.languageCode,
  }) : super(key: key);

  @override
  State<MyPackageApp> createState() => _MyPackageAppState();
}

class _MyPackageAppState extends State<MyPackageApp> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      init();
    });
    super.initState();
  }

  init() async {
    WidgetsFlutterBinding.ensureInitialized();
    passwordLengthGlobal = 6;
    appButtonBackgroundColorGlobal = primaryColor;
    defaultAppButtonTextColorGlobal = Colors.white;
    defaultRadius = 12;
    defaultBlurRadius = 0;
    defaultSpreadRadius = 0;
    textSecondaryColorGlobal = appTextPrimaryColor;
    textPrimaryColorGlobal = appTextSecondaryColor;
    defaultAppButtonElevation = 0;
    pageRouteTransitionDurationGlobal = 400.milliseconds;
    textBoldSizeGlobal = 14;
    textPrimarySizeGlobal = 14;
    textSecondarySizeGlobal = 12;

    await initialize();
    localeLanguageList = languageList();
    // Future<void> saveUserData(UserData data) async {
    //   if (data.apiToken.validate().isNotEmpty)
    //     await appStore.setToken(data.apiToken!);
    //   appStore.setLoggedIn(true);
    //
    //   await appStore.setUserId(data.id.validate());
    //   await appStore.setFirstName(data.firstName.validate());
    //   await appStore.setLastName(data.lastName.validate());
    //   await appStore.setUserEmail(data.email.validate());
    //   await appStore.setUserName(data.username.validate());
    //   await appStore.setCountryId(data.countryId.validate());
    //   await appStore.setStateId(data.stateId.validate());
    //   await appStore.setCityId(data.cityId.validate());
    //   await appStore.setContactNumber(data.contactNumber.validate());
    //   if (data.loginType.validate().isNotEmpty)
    //     await appStore.setLoginType(data.loginType.validate());
    //   await appStore.setAddress(data.address.validate());
    //
    //   if (data.playerId.validate().isNotEmpty) {
    //     appStore.setPlayerId(data.playerId.validate());
    //   }
    //
    //   if (data.loginType != LOGIN_TYPE_GOOGLE) {
    //     await appStore.setUserProfile(data.profileImage.validate());
    //   }
    //   appStore.setUId(data.uid.validate());
    //
    //   ///Set app configurations
    //   if (appStore.isLoggedIn) {
    //     getAppConfigurations();
    //   }
    // }
    // Firebase.initializeApp();
    // Firebase.initializeApp().then((value) {
    //   FlutterError.onError =
    //       FirebaseCrashlytics.instance.recordFlutterFatalError;
    //
    //   setupFirebaseRemoteConfig();
    // });
    if (widget.userData != null) {
      await saveUserData(widget.userData);
      appStore.setLanguage(widget.languageCode);
    }

    await appStore.setLoggedIn(getBoolAsync(IS_LOGGED_IN),
        isInitializing: true);

    // int themeModeIndex =
    //     getIntAsync(THEME_MODE_INDEX, defaultValue: THEME_MODE_SYSTEM);
    // appStore.setDarkMode(true);
    // if (themeModeIndex == THEME_MODE_LIGHT) {
    //   appStore.setDarkMode(false);
    // } else if (themeModeIndex == THEME_MODE_DARK) {
    //   appStore.setDarkMode(true);
    // }
    appStore.setDarkMode(false);

    await appStore.setUseMaterialYouTheme(getBoolAsync(USE_MATERIAL_YOU_THEME),
        isInitializing: true);

    if (appStore.isLoggedIn) {
      await appStore.setUserId(getIntAsync(USER_ID), isInitializing: true);
      await appStore.setFirstName(getStringAsync(FIRST_NAME),
          isInitializing: true);
      await appStore.setLastName(getStringAsync(LAST_NAME),
          isInitializing: true);
      await appStore.setUserEmail(getStringAsync(USER_EMAIL),
          isInitializing: true);
      await appStore.setUserName(getStringAsync(USERNAME),
          isInitializing: true);
      await appStore.setContactNumber(getStringAsync(CONTACT_NUMBER),
          isInitializing: true);
      await appStore.setUserProfile(getStringAsync(PROFILE_IMAGE),
          isInitializing: true);
      await appStore.setCountryId(getIntAsync(COUNTRY_ID),
          isInitializing: true);
      await appStore.setStateId(getIntAsync(STATE_ID), isInitializing: true);
      await appStore.setCityId(getIntAsync(COUNTRY_ID), isInitializing: true);
      await appStore.setUId(getStringAsync(UID), isInitializing: true);
      await appStore.setToken(getStringAsync(TOKEN), isInitializing: true);
      await appStore.setAddress(getStringAsync(ADDRESS), isInitializing: true);
      await appStore.setCurrencyCode(getStringAsync(CURRENCY_COUNTRY_CODE),
          isInitializing: true);
      await appStore.setCurrencyCountryId(getStringAsync(CURRENCY_COUNTRY_ID),
          isInitializing: true);
      await appStore.setCurrencySymbol(getStringAsync(CURRENCY_COUNTRY_SYMBOL),
          isInitializing: true);
      await appStore.setPrivacyPolicy(getStringAsync(PRIVACY_POLICY),
          isInitializing: true);
      await appStore.setLoginType(getStringAsync(LOGIN_TYPE),
          isInitializing: true);
      await appStore.setPlayerId(getStringAsync(PLAYERID),
          isInitializing: true);
      await appStore.setTermConditions(getStringAsync(TERM_CONDITIONS),
          isInitializing: true);
      await appStore.setInquiryEmail(getStringAsync(INQUIRY_EMAIL),
          isInitializing: true);
      await appStore.setHelplineNumber(getStringAsync(HELPLINE_NUMBER),
          isInitializing: true);
      await appStore.setEnableUserWallet(getBoolAsync(ENABLE_USER_WALLET),
          isInitializing: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: RestartAppWidget(
        child: Observer(
          builder: (_) =>
              FutureBuilder<Color>(
                future: getMaterialYouData(),
                builder: (_, snap) {
                  return Observer(
                    builder: (_) =>
                        MaterialApp(
                          debugShowCheckedModeBanner: false,
                          navigatorKey: navigatorKey,
                          home: SplashScreen(),
                          theme: AppTheme.lightTheme(color: snap.data),
                          // darkTheme: AppTheme.darkTheme(color: snap.data),
                          // themeMode:
                          //     appStore.isDarkMode ? ThemeMode.dark : ThemeMode.light,
                          themeMode: ThemeMode.light,
                          title: APP_NAME,
                          supportedLocales: LanguageDataModel.languageLocales(),
                          localizationsDelegates: [
                            AppLocalizations(),
                            GlobalMaterialLocalizations.delegate,
                            GlobalWidgetsLocalizations.delegate,
                            GlobalCupertinoLocalizations.delegate,
                          ],
                          localeResolutionCallback: (locale,
                              supportedLocales) =>
                          locale,
                          locale: Locale(appStore.selectedLanguageCode),
                        ),
                  );
                },
              ),
        ),
      ),
    );
  }
}
