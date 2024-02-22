import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:provider/provider.dart';
import 'package:starter_application/core/bloc/global/glogal_cubit.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/provider/session_data.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/http_client_type.dart';
import 'package:starter_application/core/constants/enums/http_method.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/firebase/notification_service.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/core/net/api_url.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/params/screen_params/personality_result_screen_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/core/ui/widgets/system/double_tap_back_exit_app.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/account/domain/entity/city_entity.dart';
import 'package:starter_application/features/health/presentation/widget/profile/circled_profile_pic.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/help/presentation/screen/help_screen.dart';
import 'package:starter_application/features/home/presentation/screen/home_screen/home_screen.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/app_main_screen_notifier.dart';
import 'package:starter_application/features/messages/presentation/messages_screen.dart';
import 'package:starter_application/features/messages/presentation/state_m/cubit/messages_cubit.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/global_messages_notifier.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/messages_screen_notifie.dart';
import 'package:starter_application/features/moment/presentation/screen/moment_screen.dart';
import 'package:starter_application/features/mylife/presentation/screen/mylife_home_screen.dart';
import 'package:starter_application/features/notification/presentation/screen/notification_list_screen.dart';
import 'package:starter_application/features/personality/presentation/screen/personality_details_screen.dart';
import 'package:starter_application/features/personality/presentation/screen/presonality_result_screen.dart';
import 'package:starter_application/features/personality/presentation/state_m/cubit/personality_cubit.dart';
import 'package:starter_application/features/settings/presentation/screen/setting_main_screen.dart';
import 'package:starter_application/features/shop/data/model/response/get_taxfee_model.dart';
import 'package:starter_application/features/shop/domain/usecase/get_taxfee_usecse.dart';
import 'package:starter_application/features/user/data/model/request/get_city_params.dart';
import 'package:starter_application/features/user/domain/usecase/get_all_city_usecase.dart';
import 'package:starter_application/features/user/presentation/screen/view_profile_screen.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:starter_application/main.dart';

import '../../../../core/firebase/notification_middleware.dart';
import '../../../../core/localization/localization_provider.dart';
import '../../../../core/ui/screens/payment_screen.dart';
import '../../../../core/utils/lifecycle_service.dart';
import '../../../account/presentation/screen/login_screen.dart';
import '../../../personality/data/model/request/open_app_request.dart';
import 'home_screen/qrCode_screen.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';

class AppMainScreen extends StatefulWidget {
  static const routeName = "/AppMainScreen";

  AppMainScreen({Key? key, this.withController = false}) : super(key: key);
  bool? withController;

  @override
  _AppMainScreenState createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen>
    with AutomaticKeepAliveClientMixin {
  late AppMainScreenNotifier sn;
  static const NAV_ICON = 0;
  static const NAV_TITLE = 1;
  late Timer _timer;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  initCities() async {
    final results = await Future.wait([
      getIt<GetAllCityUseCase>()(
        GetCityParams(type: 1, maxResultCount: 1000),
      ),
      getIt<GetTaxFeeUseCase>()(NoParams()),
    ]);
    final error = checkError(results);
    if (error != null) {
      Future.wait([
        getIt<GetAllCityUseCase>()(
          GetCityParams(type: 1, maxResultCount: 1000),
        ),
        getIt<GetTaxFeeUseCase>()(NoParams()),
      ]);
    } else {
      late SessionData session =
          Provider.of<SessionData>(AppConfig().appContext, listen: false);
      if (results[0].data is CityListEntity)
        session.cities = (results[0].data as CityListEntity).items;
      if (results[1].data is GetSettingModel)
        session.getSettingModel = results[1].data as GetSettingModel;
    }
  }

  AppErrors? checkError<T>(List<Result<AppErrors, T>> results) {
    for (int i = 0; i < results.length; i++) {
      if (results[i].hasErrorOnly) return results[i].error;
    }
    return null;
  }

  @override
  void initState() {
    if (checkAuth()) {
      initAppMainScreen();
    }
  }

  checkAuth() {
    return BlocProvider.of<GlogalCubit>(AppConfig().appContext, listen: false)
        .isAuth;
  }

  initAppMainScreen() {
    Provider.of<LifecycleService>(context, listen: false).startObserving();
    mapTypeToHttpClient(HttpClientType.MAIN).sendWithOutLayers(
        method: HttpMethod.POST,
        url: APIUrls.API_Create_Current_Opened_Chat,
        queryParameters: {
          "FriendId": 0,
        });
    initCities();

    Provider.of<AppMainScreenNotifier>(
            getIt<NavigationService>().getNavigationKey.currentContext!,
            listen: false)
        .resetMessageOpen();

    /// Init firebase messaging
    Messaging.initFCM();

    // NotificationController notificationController = Get.find();
    //  notificationController.init();
    try {
      appsflyerSdk.onAppOpenAttribution((res) {
        print("onAppOpenAttribution res: " + res.toString());
        setState(() {
          deepLinkData = res;
        });
      });
      appsflyerSdk.onInstallConversionData((res) {
        print("onInstallConversionData res: " + res.toString());
        setState(() {
          gcd = res;
        });
      });
      appsflyerSdk.onDeepLinking((DeepLinkResult dp) {
        switch (dp.status) {
          case Status.FOUND:
            print(dp.deepLink?.toString());
            print("deep link value: ${dp.deepLink?.deepLinkValue}");
            break;
          case Status.NOT_FOUND:
            print("deep link not found");
            break;
          case Status.ERROR:
            print("deep link error: ${dp.error}");
            break;
          case Status.PARSE_ERROR:
            print("deep link status parsing error");
            break;
        }
        print("onDeepLinking res: " + dp.toString());
        setState(() {
          deepLinkData = dp.toJson();
        });
      });
    } catch (e) {}
    _startTimer();

    super.initState();
    AppConfig().getHandyManService();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      sn = Provider.of<AppMainScreenNotifier>(context, listen: false);
      sn.getMyAvatar();
      if(!sn.isInitShop){
        sn.initShopModel();
      }
      // sn.setController(PageController());
      checkAndNavigationCallingPage();
      if (sn.lat == null) {
        sn.getLocation();
      }
    });
  }

  void _startTimer() async {
    // Delay the initial call for 1 second
    await Future.delayed(const Duration(seconds: 1));

    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (mounted) {
        BlocProvider.of<GlogalCubit>(context, listen: false).initNumber();
      }
    });
  }

  @override
  void dispose() async {
    if (checkAuth()) {
      _timer.cancel();
    }
    super.dispose();
  }

  Future<Map?> getCurrentCall() async {
    //check current call from pushkit if possible
    var calls = await FlutterCallkitIncoming.activeCalls();
    if (calls is List) {
      if (calls.isNotEmpty) {
        print('DATA: $calls');
        // _currentUuid = calls[0]['id'];
        try {
          await FlutterCallkitIncoming.endAllCalls();
          return calls.last['extra']['remoteMessage'] as Map;
        } catch (e) {
          log('cant find data inside call ::$e');
          return null;
        }
      } else {
        // _currentUuid = "";
        return null;
      }
    }
  }

  Future<void> checkAndNavigationCallingPage() async {
    final payload = await getCurrentCall();
    if (payload != null) {
      print('CallPaylod::${payload}');
      NotificationMiddleware.forwardChat(payload);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      checkAndNavigationCallingPage();
    }

    if (state == AppLifecycleState.resumed) {
      print("resumed");
    } else if (state == AppLifecycleState.paused) {
      print('App paused');
    } else if (state == AppLifecycleState.detached) {
      print('App detached');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    sn = Provider.of<AppMainScreenNotifier>(
      context,
    );
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    // });
    if (widget.withController != null && widget.withController!) {
      sn.setController(PageController());
    }
    // sn.restartAppForOneTime()();
    // sn.getCallData();
    return DoubleTapBackExitApp(
      child: MultiBlocListener(
        listeners: [
          BlocListener<MessagesCubit, MessagesState>(
            bloc: Provider.of<GlobalMessagesNotifier>(AppConfig().appContext,
                    listen: false)
                .messagesCubit,
            listener: (context, state) => state.mapOrNull(
              conversationsLoadedState: (value) {
                Provider.of<GlobalMessagesNotifier>(AppConfig().appContext,
                        listen: false)
                    .loadingConversations = true;
              },
              messagesErrorState: (value) {
                Provider.of<GlobalMessagesNotifier>(AppConfig().appContext,
                        listen: false)
                    .loadingConversations = false;
              },
            ),
          ),
          BlocListener<MessagesCubit, MessagesState>(
            bloc: Provider.of<GlobalMessagesNotifier>(AppConfig().appContext,
                    listen: false)
                .groupsCubit,
            listener: (context, state) => state.mapOrNull(
              groupsLoadedState: (value) {},
              messagesErrorState: (value) {
                Provider.of<GlobalMessagesNotifier>(AppConfig().appContext,
                        listen: false)
                    .loadingGroups = false;
              },
            ),
          ),
        ],
        child: Scaffold(
          body: PageView(
            controller: sn.controller,
            // physics: const NeverScrollableScrollPhysics(),
            children: [
              const HomeScreen(),
              const MessagesScreen(),
              const MomentScreen(),
              Container(
                child: const Center(child: Text("")),
              ),
              const MyLifeHomeScreen(),
            ],
            onPageChanged: sn.onPageChanged,
          ),
          bottomNavigationBar: Builder(builder: (context) {
            sn.context = context;
            return Container(
              height: AppConstants.bottomNavigationBarHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.r),
                  topRight: Radius.circular(40.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.mansourNotSelectedBorderColor
                        .withOpacity(0.3),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.r),
                  topRight: Radius.circular(40.r),
                ),
                child: _buildBottomNavigationbar(),
              ),
            );
          }),
          extendBody: true,
          drawer: _buildDrawer(),
        ),
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (checkAuth()) _buildDrawerHeader(),
          Gaps.vGap128,
          _buildDrawerBody(),
          const Spacer(),
          if (APIUrls.BASE_URL == "https://mohraapp.com:8081" ||
              APIUrls.BASE_URL == "https://staging-api.mohraapps.com")
            Padding(
              padding: EdgeInsets.only(
                bottom: 20,
                right: 50.w,
                left: 50.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Staging',
                    style: TextStyle(
                        color: AppColors.primaryColorLight, fontSize: 50.sp),
                  ),
                ],
              ),
            ),
          Gaps.vGap24,
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 50.w,
            ),
            child: _buildDrawerItem(
              AppConstants.SVG_LOG_OUT_1,
              checkAuth()
                  ? Translation.current.logOut
                  : Translation.current.login,
              onTap: () async {
                if (checkAuth()) {
                  sn.showLogoutDialog();
                } else {
                  Nav.to(LoginScreen.routeName);
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 20,
              right: 50.w,
              left: 50.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'App Version',
                  style: TextStyle(color: AppColors.text_gray, fontSize: 50.sp),
                ),
                Text(
                  '${AppConfig().currentVersion}',
                  style: TextStyle(color: AppColors.text_gray, fontSize: 50.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      height: 0.27.sh,
      padding: EdgeInsets.symmetric(
        horizontal: 50.w,
      ),
      color: AppColors.primaryColorLight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                // setState(() {
                //   isArabic = true;
                // });
                Scaffold.of(context).openEndDrawer();
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                minHeight: 0,
                minWidth: 0,
              ),
              icon: Icon(
                AppConstants.getIconBack(),
                color: Colors.white,
                size: 80.h,
              ),
            );
          }),
          SizedBox(
            height: 80.h,
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Nav.to(ViewProfileScreen.routeName)
                      .then((value) => sn.notifyListeners());
                },
                child: Row(
                  children: [
                    ProfilePic(
                      width: 150.h,
                      height: 150.h,
                      imageUrl: UserSessionDataModel.imageUrl,
                    ),
                    Container(
                      width: 0.3.sw,
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(start: 30.w),
                        child: Text(
                          "${UserSessionDataModel.fullName}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 50.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<PersonalityCubit, PersonalityState>(
                bloc: sn.personalityCubit,
                builder: (context, state) => state.maybeMap(
                  personalityInitState: (s) => WaitingWidget(),
                  personalityErrorState: (s) => WaitingWidget(),
                  personalityLoadingState: (s) => WaitingWidget(),
                  avatarLoaded: (value) => GestureDetector(
                    onTap: () {
                      Nav.to(PersonalityDetailsScreen.routeName,
                          arguments: PersonalityResultScreenParams(
                            birthDay: UserSessionDataModel.birthday != ''
                                ? DateTime.parse(UserSessionDataModel.birthday)
                                : null,
                            gender: UserSessionDataModel.gender ?? 0,
                          ));
                    },
                    child: CachedNetworkImage(
                      imageUrl:
                          value.avatarListEntity.myAvatar?.avatarUrl ?? '',
                      fit: BoxFit.contain,
                      width: 0.23.sw,
                      height: 0.23.sw,
                      errorWidget: (context, url, error) => Container(
                        child: const Icon(Icons.error),
                      ),
                      placeholder: (context, _) => const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    ),
                  ),
                  orElse: () => const SizedBox.shrink(),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerBody() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 50.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (checkAuth())
            _buildDrawerItem(
                AppConstants.SVG_MY_LIFE, Translation.current.profile,
                onTap: () {
              Nav.to(ViewProfileScreen.routeName)
                  .then((value) => sn.notifyListeners());
            }),
          if (checkAuth())
            _buildDrawerItem(
              AppConstants.SVG_BARCODE,
              Translation.current.my_qr_code,
              onTap: () => Nav.to(
                QrCodeScreen.routeName,
                arguments: QrCodeScreenParam(navToScan: false),
              ),
            ),
          if (checkAuth())
            _buildDrawerItem(
              AppConstants.SVG_SCAN,
              Translation.current.scan,
              onTap: sn.onScanTap,
            ),
          if (checkAuth())
            _buildDrawerItem(AppConstants.NOTIFICATION_ICON,
                Translation.current.notification, onTap: () {
              Nav.to(
                NotificationListScreen.routeName,
              );
            }, isNotification: true),
          if (checkAuth())
            _buildDrawerItem('assets/images/svg/setting_icon.svg',
                Translation.current.setting, onTap: () {
              Nav.to(SettingMainScreen.routeName);
            }),
          if (checkAuth())
            _buildDrawerItem(
                AppConstants.SVG_CONTACT_US, Translation.current.help,
                onTap: () {
              Nav.to(HelpScreen.routeName);
            }),
          CustomListTile(
            onTap: () {},
            leading: const Icon(
              Icons.language,
              color: AppColors.primaryColorLight,
              size: 25,
            ),
            title: Row(
              children: [
                FlutterSwitch(
                  height: 35,
                  width: 70,
                  activeColor: AppColors.primaryColorLight,
                  activeIcon: AppConfig().appLanguage == AppConstants.LANG_EN
                      ? const Text('En')
                      : const Text('Ar'),
                  inactiveIcon: AppConfig().appLanguage == AppConstants.LANG_EN
                      ? const Text('Ar')
                      : const Text('En'),
                  showOnOff: false,
                  value: true,
                  onToggle: (val) => sn.changeLang(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(String icon, String title,
      {VoidCallback? onTap, bool isNotification = false}) {
    return Column(
      children: [
        CustomListTile(
          onTap: onTap,
          leading: isNotification
              ? BlocBuilder<GlogalCubit, GlogalState>(
                  builder: (context, state) {
                    if (state is GlogalChanged) {
                      if (state.numberNotificaions! > 0) {
                        return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            SvgPicture.asset(
                              icon,
                              color: AppColors.primaryColorLight,
                              width: 25,
                              height: 25,
                            ),
                            Positioned(
                              top: state.numberNotificaions! >= 10 ? -18 : -13,
                              right:
                                  state.numberNotificaions! >= 10 ? -18 : -13,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.red, shape: BoxShape.circle),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    "${state.numberNotificaions! > 99 ? "+99" : state.numberNotificaions}",
                                    style: TextStyle(color: AppColors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      } else {
                        return SvgPicture.asset(
                          icon,
                          color: AppColors.primaryColorLight,
                          width: 25,
                          height: 25,
                        );
                      }
                    } else {
                      return SvgPicture.asset(
                        icon,
                        color: AppColors.primaryColorLight,
                        width: 25,
                        height: 25,
                      );
                    }
                  },
                )
              : SvgPicture.asset(
                  icon,
                  color: AppColors.primaryColorLight,
                  width: 25,
                  height: 25,
                ),
          title: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 40.sp,
            ),
          ),
        ),
        Gaps.vGap64,
      ],
    );
  }

  Widget _buildBottomNavigationbar() {
    return BlocBuilder<GlogalCubit, GlogalState>(
      builder: (context, state) {
        return BottomNavigationBar(
          backgroundColor: Colors.white,
          items: navItems.map((e) => _buildBottomNavigationBarItem(e)).toList(),
          selectedLabelStyle: TextStyle(
            color: AppColors.primaryColorLight,
            fontSize: 35.sp,
          ),
          unselectedLabelStyle: TextStyle(
            color: Colors.black,
            fontSize: 35.sp,
          ),
          currentIndex: sn.selectedIndex,
          selectedItemColor: AppColors.primaryColorLight,
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          onTap: sn.onBottomNavigationTap,
        );
      },
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      Map<int, dynamic> item) {
    int index = navItems.indexOf(item);
    return BottomNavigationBarItem(
      label: item[NAV_TITLE],
      icon: BlocBuilder<GlogalCubit, GlogalState>(
        builder: (context, state) {
          if (state is GlogalChanged) {
            if (item[NAV_TITLE] == "Messages" && state.numberMessages! > 0) {
              return badges.Badge(
                badgeContent: Text("${state.numberMessages}"),
                child: SvgPicture.asset(
                  item[NAV_ICON],
                  color: sn.selectedIndex == index
                      ? AppColors.primaryColorLight
                      : Colors.black,
                ),
              );
            } else {
              return SvgPicture.asset(
                item[NAV_ICON],
                color: sn.selectedIndex == index
                    ? AppColors.primaryColorLight
                    : Colors.black,
              );
            }
          } else {
            return SvgPicture.asset(
              item[NAV_ICON],
              color: sn.selectedIndex == index
                  ? AppColors.primaryColorLight
                  : Colors.black,
            );
          }
        },
      ),
    );
  }

  List<Map<int, dynamic>> navItems = [
    {
      NAV_ICON: AppConstants.SVG_HOME_FILL,
      NAV_TITLE: Translation.current.home,
    },
    {
      NAV_ICON: AppConstants.SVG_MESSAGE,
      NAV_TITLE: Translation.current.messages,
    },
    {
      NAV_ICON: AppConstants.SVG_MOMENT_FILL,
      NAV_TITLE: Translation.current.moments,
    },
    {
      NAV_ICON: AppConstants.SVG_MERHANT,
      NAV_TITLE: Translation.current.shop,
    },
    {
      NAV_ICON: AppConstants.SVG_MY_LIFE_3,
      NAV_TITLE: Translation.current.my_life,
    },
  ];
}
