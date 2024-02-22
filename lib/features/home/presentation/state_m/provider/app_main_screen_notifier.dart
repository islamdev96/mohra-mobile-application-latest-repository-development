import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/dashboard_model.dart';
import 'package:booking_system_flutter/network/network_utils.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/bloc/global/glogal_cubit.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/common/extensions/extensions.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/datasources/shared_preference.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/core/ui/dialogs/language_dialog.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_snackbar_based_error_type.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/account/data/model/request/login_request.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';
import 'package:starter_application/features/friend/domain/entity/get_frined_status_response.dart';
import 'package:starter_application/features/home/presentation/screen/home_screen/qrCode_screen.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/global_messages_notifier.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/messages_screen_notifie.dart';
import 'package:starter_application/features/mylife/presentation/logic/date_time_helper.dart';
import 'package:starter_application/features/mylife/presentation/screen/mylife_home_screen.dart';
import 'package:starter_application/features/personality/data/model/request/get_avatar_params.dart';
import 'package:starter_application/features/personality/presentation/state_m/cubit/personality_cubit.dart';
import 'package:starter_application/features/salary_count/domain/entity/time_table_list_entity.dart';
import 'package:starter_application/features/shop/presentation/screen/shop_main_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../core/common/style/dimens.dart';
import '../../../../../core/common/utils.dart';
import '../../../../../core/localization/restart_widget.dart';
import '../../../../../core/params/screen_params/video_audio_chat_screen_params.dart';
import '../../../../../core/ui/dialogs/show_dialog.dart';
import '../../../../../generated/l10n.dart';
import '../../../../messages/domain/entity/token_entity.dart';
import '../../../../messages/presentation/screen/video_audio_chat_screen.dart';
import '../../../../personality/data/model/request/open_app_request.dart';
import '../../../../shop/presentation/screen/shop_screen/shoe_home_screen.dart';
import '../../screen/app_main_screen.dart';
import '../../widget/animated_container_dialog.dart';

class AppMainScreenNotifier extends ScreenNotifier {
  late BuildContext context;
  static const NAV_ICON = 0;
  static const NAV_TITLE = 1;
  List<TimeTableItemEntity> timeTableListEntity = [];
  PageController controller = PageController();
  late final TabController tabController;
  int _selectedIndex = 0;
  int? messageOpen;
  bool? isBloc = null;
  bool? isFriendBlocked = null;
  bool isMute = false;
  bool isVisitUserInChat = false;
  int availableSeats = 0;
  int myTotalSeats = 0;
  PersonalityCubit personalityCubit = PersonalityCubit();
  String dateTime = DateFormat('yyyy-MM-dd').format(DateTime.now());

  bool isRestart = false;
  bool isInCall = false;
  bool isInitShop = false;
  late WebViewController shopViewController;

  int callerId = -1;
  double? lat;
  double? lon;
  late VideoAudioChatScreenParams? callParams = null;

  changeInCall(bool value, VideoAudioChatScreenParams? params,
      {int? selectedIndex, int? callerID}) {
    print("isInCall : : $isInCall");
    isInCall = value;
    callParams = params;
    callerId = callerID!;
    _selectedIndex = selectedIndex ?? 0;
    notifyListeners();
    print("isInCall : : $isInCall");
    // setController(PageController());
  }

  clearAllCall() {
    callParams = null;
    callerId = -1;
    selectedIndex = 0;
    controller.jumpTo(0);
    notifyListeners();
  }

  /// Getters and Setters
  int get selectedIndex => this._selectedIndex;

  set selectedIndex(int value) {
    this._selectedIndex = value;
    notifyListeners();
  }

  updateSelectedIndex() {
    this._selectedIndex = 1;
    notifyListeners();
  }

  Future<void> setController(PageController value) async {
    this.controller = value;
    notifyListeners();
    print("First Try Basel : $selectedIndex");
    print("First Try Basel _selectedIndex : $_selectedIndex");
  }

  bool changeTickets(int number) {
    if (number == -1) {
      if (myTotalSeats > 0) {
        myTotalSeats = myTotalSeats - 1;
        notifyListeners();
        return false;
      } else {
        return false;
      }
    } else if (number == 1) {
      if (availableSeats > myTotalSeats) {
        myTotalSeats = myTotalSeats + 1;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  setFriendStatus(GetFrinedStatusEntity getFrinedStatusEntity) {
    isBloc = getFrinedStatusEntity.isBlock!;
    isFriendBlocked = getFrinedStatusEntity.friendBlocked ?? false;
    isMute = getFrinedStatusEntity.isMuted!;
    notifyListeners();
  }

  /// Methods
  @override
  void closeNotifier() {
    controller!.dispose();
    this.dispose();
  }

  setMessageOpen(int chatID) async {
    final sp = await SpUtil.getInstance();
    sp.putInt(AppConstants.KEY_CHAT_ID, chatID);
    messageOpen = chatID;
    notifyListeners();
  }

  getMessageOpen() {
    return messageOpen;
  }

  resetMessageOpen() async {
    final sp = await SpUtil.getInstance();
    sp.remove(AppConstants.KEY_CHAT_ID);
    messageOpen = null;
    notifyListeners();
  }

  void _showLoginPrompt(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AnimatedContainerDialog(); // Custom animated dialog
      },
    );
  }

  void onBottomNavigationTap(int value) {
    final isAuth =
        BlocProvider.of<GlogalCubit>(AppConfig().appContext, listen: false)
            .isAuth;
    if (!isAuth) {
      _showLoginPrompt(AppConfig().appContext);
    } else {
      int number = 0;
      selectedIndex = value;
      notifyListeners();
      if (value == 3) {
        Nav.to(ShopMainScreen.routeName);
        controller.jumpToPage(0);
        _selectedIndex = 0;
        notifyListeners();
      }
      if (value != 3) {
        selectedIndex = value;
        notifyListeners();
        controller.jumpToPage(
          value,
        );
      }
      Provider.of<GlobalMessagesNotifier>(AppConfig().appContext, listen: false)
          .conversations
          .forEach((element) async {
        number += element.conversationEntity?.countMessegesUnreaded ?? 0;
        BlocProvider.of<GlogalCubit>(AppConfig().appContext, listen: false)
            .changeNumber(number);
      });
    }
  }

  getMyAvatar() {
    int? gender = UserSessionDataModel.gender!;
    // DateTime? date =
    //     DateTimeHelper.getDateInEnglish(UserSessionDataModel.birthday);
    if (gender != null /*&& date != null*/)
      personalityCubit.getMyAvatar(GetAvatarParams(
          gender: gender, month: UserSessionDataModel.avatarMonth));
  }

  restartAppForOneTime() {
    if (!isRestart) {
      RestartWidget.restartApp(getIt<NavigationService>().appContext!);
    }
    isRestart = true;
    notifyListeners();
  }

  void openDrawer() {
    Scaffold.of(context ??
            getIt<NavigationService>().getNavigationKey.currentContext!)
        .openDrawer();
    if (BlocProvider.of<GlogalCubit>(AppConfig().appContext, listen: false)
        .isAuth) {
      getMyAvatar();
    }
  }

  void onScanTap() {
    Nav.to(
      QrCodeScreen.routeName,
      arguments: QrCodeScreenParam(navToScan: true),
    );
  }

  void changeLang({BuildContext? contextEvent}) {
    showLanguageDialog(context: contextEvent ?? context);
  }

  void onPageChanged(int page) {
    if (BlocProvider.of<GlogalCubit>(AppConfig().appContext, listen: false)
        .isAuth) {
      _selectedIndex = page;
      notifyListeners();
      Provider.of<AppMainScreenNotifier>(
              getIt<NavigationService>().getNavigationKey.currentContext!,
              listen: false)
          .resetMessageOpen();

      if (page == 3) {
        Nav.to(ShopMainScreen.routeName);

        _selectedIndex = 0;
        controller.jumpToPage(0);
        notifyListeners();
      }
    }
  }

  final accountCubit = AccountCubit();

  void showLogoutDialog({BuildContext? contextEvent}) {
    ShowDialog().showElasticDialog(
      context: contextEvent ?? context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Dimens.dp15),
            ),
          ),
          title: Text(
            Translation.current.logout_confirm,
            style: Colors.black.bodyText1,
          ),
          content: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      child: Text(
                        Translation.of(context).cancel,
                      ),
                      onPressed: () {
                        // Navigator.of(context).pop();
                        Nav.pop();
                      },
                    ),
                    BlocConsumer<AccountCubit, AccountState>(
                        listener: (context, state) async {
                          if (state is AccLogoutLoaded) {
                            if (Platform.isIOS) {
                              await logoutWithoutRestart();
                            } else {
                              await logoutWithoutRestart();
                            }
                          }
                          if (state is AccountError) {
                            showSnakBarBasedErrorType(
                                context, state.error, () {},
                                retryWhenNotAuthorized: false);
                          }
                        },
                        bloc: accountCubit,
                        builder: (context, state) {
                          return state.maybeMap(
                            accountError: (s) => MaterialButton(
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  ScreenUtil().setWidth(35),
                                ),
                              ),
                              child: Text(
                                Translation.of(context).confirm,
                                style: const TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                accountCubit.logout(LogoutRequest(
                                  id: UserSessionDataModel.userId,
                                  long: lon,
                                  lat: lat,
                                ));
                              },
                              textColor: Theme.of(context).primaryColor,
                            ),
                            accountInit: (s) => MaterialButton(
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  ScreenUtil().setWidth(35),
                                ),
                              ),
                              child: Text(
                                Translation.of(context).confirm,
                                style: const TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                accountCubit.logout(LogoutRequest(
                                  id: UserSessionDataModel.userId,
                                  long: lon,
                                  lat: lat,
                                ));
                              },
                              textColor: Theme.of(context).primaryColor,
                            ),
                            accountLoading: (s) =>
                                CircularProgressIndicator.adaptive(),
                            logoutLoaded: (s) => MaterialButton(
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  ScreenUtil().setWidth(35),
                                ),
                              ),
                              child: Text(
                                Translation.of(context).confirm,
                                style: const TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                accountCubit.logout(LogoutRequest(
                                  id: UserSessionDataModel.userId,
                                  long: lon,
                                  lat: lat,
                                ));
                              },
                              textColor: Theme.of(context).primaryColor,
                            ),
                            orElse: () => MaterialButton(
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  ScreenUtil().setWidth(35),
                                ),
                              ),
                              child: Text(
                                Translation.of(context).confirm,
                                style: const TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                accountCubit.logout(LogoutRequest(
                                  id: UserSessionDataModel.userId,
                                  long: lon,
                                  lat: lat,
                                ));
                              },
                              textColor: Theme.of(context).primaryColor,
                            ),
                          );
                        }),
                    // MaterialButton(
                    //   color: Theme.of(context).primaryColor,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(
                    //       ScreenUtil().setWidth(35),
                    //     ),
                    //   ),
                    //   child: Text(
                    //     Translation.of(context).confirm,
                    //     style: const TextStyle(color: Colors.white),
                    //   ),
                    //   onPressed: ()async{
                    //     if(Platform.isIOS){
                    //       await logoutWithoutRestart();
                    //     }else{
                    //       await logoutWithoutRestart();
                    //     }
                    //   },
                    //   textColor: Theme.of(context).primaryColor,
                    // ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> getLocation() async {
    final location = await getUserLocationLogic(
        onBackTap: () {
          Nav.pop();
        },
        onRetryTap: () {
          getLocation();
          Nav.pop();
        },
        withoutDialogue: true);
    if (location != null) {
      lon = location.longitude;
      lat = location.latitude;
      Provider.of<AppMainScreenNotifier>(
              getIt<NavigationService>().getNavigationKey.currentContext!,
              listen: false)
          .personalityCubit
          .openApp(OpenAppRequest(lat: lat, long: lon));

      notifyListeners();
    }
  }

  initShopModel() {
    shopViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse("https://salla.sa/mohraapp"))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print("dasd");
          },
          onPageStarted: (String url) {
            print("dasd");
          },
          onPageFinished: (String url) {
            print("dasd");
          },
          onWebResourceError: (WebResourceError error) {
            Nav.pop();
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      );

    isInitShop = true;
    notifyListeners();
  }
}
