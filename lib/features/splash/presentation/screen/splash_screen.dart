import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/bloc/global/glogal_cubit.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/provider/cart.dart';
import 'package:starter_application/core/common/provider/session_data.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/http_client_type.dart';
import 'package:starter_application/core/constants/enums/http_method.dart';
import 'package:starter_application/core/constants/enums/user_type.dart';
import 'package:starter_application/core/datasources/shared_preference.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/net/api_url.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_error_snackbar.dart';
import 'package:starter_application/core/ui/mansour/onboarding_screen.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/features/account/data/model/request/check_device_id_params.dart';
import 'package:starter_application/features/account/presentation/screen/login_screen.dart';
import 'package:starter_application/features/account/presentation/screen/start_personality_test.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';
import 'package:starter_application/features/event/presentation/screen/my_running_events_screen.dart';
import 'package:starter_application/features/friend/data/model/request/get_friends_requests_params.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/features/home/presentation/screen/app_main_screen.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/global_messages_notifier.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/messages_screen_notifie.dart';
import 'package:starter_application/features/notification/presentation/state_m/cubit/notification_cubit.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/product_favorite.dart';
import 'package:starter_application/features/splash/presentation/screen/splash_screen_content.dart';
import 'package:starter_application/features/splash/presentation/state_m/cubit/splash_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../Event Organizer/pages/home/home.dart';
import '../../../event_orginizer/presentation/screen/event_organizer_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/SplashScreen";

  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SessionData session =
      Provider.of<SessionData>(AppConfig().appContext, listen: false);
  final SplashCubit splashCubit = SplashCubit();
  FriendCubit friendReceivedOnlyCubit = FriendCubit();

  // NotificationCubit notificationCubit = NotificationCubit();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  bool canGo = false;
  final accountCubit = AccountCubit();

  changeLang() async {
    bool isToken = await AppConfig().hasToken;
    if (isToken) {
      mapTypeToHttpClient(HttpClientType.MAIN).sendWithOutLayers(
          method: HttpMethod.POST,
          url: APIUrls.ChangeLang,
          body: {
            "lang": Intl.getCurrentLocale(),
          });
    }
  }

  @override
  void initState() {
    Provider.of<Cart>(context, listen: false).shippingAddress = null;
    changeLang();
    AppConfig().getHandyManService();
    BlocProvider.of<GlogalCubit>(AppConfig().appContext, listen: false)
        .getAuth();
    super.initState();
  }

  bool isNavigate = false;

  goNavigateLate() async {
    await Future.delayed(const Duration(seconds: 10));
    bool isPageSplash = await Nav.isCurrent(AppMainScreen.routeName);
    if (isPageSplash) {
      return Future.value();
    } else {
      if (isNavigate == false) navigate();
    }
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      checkValid();
      goNavigateLate();
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    accountCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColorLight,
      body: MultiBlocListener(
        listeners: [
          BlocListener<SplashCubit, SplashState>(
            bloc: splashCubit,
            listener: (context, state) {
              state.mapOrNull(splashLoaded: (s) {
                session.cities = s.splashEntity.cityListEntity.items;
                context.read<ProductFavorite>().products =
                    s.splashEntity.favoritesProductsEntity == null
                        ? []
                        : s.splashEntity.favoritesProductsEntity!.items ?? [];

                if (canGo) {
                  navigate();
                }
                canGo = true;
              }, splashErrorState: (s) {
                splashCubit.splashInit();
              });
            },
          ),
          BlocListener<FriendCubit, FriendState>(
            bloc: friendReceivedOnlyCubit,
            listener: (context, state) => state.mapOrNull(
                getCountFriendsAndNotificationStatusDone: (value) {
              MessagesNotifier.friendReceivedOnly.value = value
                  .getCountFrinedsAndNotificationsEntity.friendRequestsCount!;
              BlocProvider.of<GlogalCubit>(AppConfig().appContext,
                      listen: false)
                  .setNotificationsNumber(value
                      .getCountFrinedsAndNotificationsEntity
                      .notificationCount!);
            }),
          ),
          BlocListener<AccountCubit, AccountState>(
            bloc: accountCubit,
            listener: (context, state) {
              if (state is CheckDeviceIdDone) {
                print('asdasdasdsa');
                if (state.emptyResponse.succeed == false) if (canGo)
                  navigate();
                else
                  onDeviceIdCheckedTrue();
              }
              if (state is AccountError) {
                state.error.maybeMap(
                  orElse: () async {
                    showErrorSnackBar(
                      message: Translation.current.session_expired,
                    );
                    UserSessionDataModel.removeAll();
                    await session.clear();
                    await Future.delayed(const Duration(milliseconds: 100));
                    Nav.toAndRemoveAll(LoginScreen.routeName);
                    isNavigate = true;
                  },
                  forbiddenError: (s) async {
                    showErrorSnackBar(
                      message: Translation.current.session_expired,
                    );
                    UserSessionDataModel.removeAll();
                    await session.clear();
                    await Future.delayed(const Duration(milliseconds: 100));
                    Nav.toAndRemoveAll(LoginScreen.routeName);
                    isNavigate = true;
                  },
                );
              }
            },
          ),
        ],
        child: SplashScreenContent(),
      ),
    );
  }

  init() async {
    splashCubit.splashInit();
    print('asdddd');
    await session.getSessionDataFromSP();
    await UserSessionDataModel.getFromSP();
    print('asdddd');

    await context.read<Cart>().init();
    if (canGo) {
      navigate();
    }
    canGo = true;
  }

  navigate() {
    if (!session.hasToken) {
      Future.delayed(const Duration(milliseconds: 100))
          // .then((value) => Nav.off(AppMainScreen.routeName));
          .then((value) {
        Nav.off(OnBoardingScreen.routeName);
        isNavigate = true;
      });
    }
    if (session.hasToken)
      Future.delayed(const Duration(milliseconds: 100)).then((value) async {
        if (UserSessionDataModel.userType == UserType.CLIENT) {
          final prefs = await SpUtil.getInstance();
          bool? hasAvatar = prefs.getBool(AppConstants.HAS_PERSONALITY_AVATAR);
          if (hasAvatar != null) {
            if (UserSessionDataModel.gender == 0) {
              Nav.toAndRemoveAll(StartPersonalityTest.routeName);
              isNavigate = true;
            } else {
              Nav.off(AppMainScreen.routeName);
              isNavigate = true;
            }
          } else {
            Nav.toAndRemoveAll(StartPersonalityTest.routeName);
            isNavigate = true;
          }
        } else {
          Nav.off(EventOrganizerScreen.routeName);
          isNavigate = true;
        }
      });

    if (session.hasToken &&
        UserSessionDataModel.userType != UserType.EventOrganizer) {
      Provider.of<GlobalMessagesNotifier>(context, listen: false).init();
    }
  }

  checkValid() async {
    await session.getSessionDataFromSP();
    await UserSessionDataModel.getFromSP();
    if (!session.hasToken) {
      Future.delayed(const Duration(milliseconds: 100))
          // .then((value) => Nav.off(AppMainScreen.routeName));
          .then((value) {
        Nav.off(OnBoardingScreen.routeName);
        isNavigate = true;
      });
    } else {
      checkValidateDevice();
    }
  }

  checkValidateDevice() async {
    int deviceType = 0;
    String deviceId = '';
    if (Platform.isAndroid) {
      deviceType = 1;
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
    } else if (Platform.isIOS) {
      deviceType = 2;
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor;
    }
    print('aaaaasddddddddffff');
    print(deviceType);
    print(deviceId);

    await accountCubit.checkDeviceId(CheckDeviceIdParams(DeviceId: deviceId));
    await friendReceivedOnlyCubit.getCountFriendAndNotifications(NoParams());
  }

  onDeviceIdCheckedTrue() {
    init();
  }
}
