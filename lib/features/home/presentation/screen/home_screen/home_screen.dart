// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/dynamic_links.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/constants/enums/system_type.dart';
import 'package:starter_application/core/errors/error_global_handler/platform_type.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/widgets/system/double_tap_back_exit_app.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/account/data/model/request/update_location_request.dart';
import 'package:starter_application/features/account/domain/usecase/update_location_usecase.dart';
import 'package:starter_application/features/challenge/presentation/state_m/cubit/challenge_cubit.dart';
import 'package:starter_application/features/home/presentation/screen/home_screen/home_screen_content.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/app_main_screen_notifier.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/home_screen_notifier.dart';
import 'package:starter_application/features/news/presentation/state_m/cubit/news_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../../core/bloc/global/glogal_cubit.dart';
import '../../../../../main.dart';
import '../../../../news/domain/entity/news_category_entity.dart';
import '../../../../news/domain/entity/news_of_category_entity.dart';

final provider = HomeScreenNotifier();

class HomeScreen extends StatefulWidget {
  static const routeName = "/HomeScreen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    if(BlocProvider.of<GlogalCubit>(AppConfig().appContext, listen: false)
        .isAuth){
      DynamicLinkService dynamicLinkService = DynamicLinkService();
      dynamicLinkService.fetchLinkData(onHandle: (id) {});
      provider.getCategories();
      provider.getAllBanners();
      provider.getAllChallenges();
      releaseMutex();
      getLocation();
      provider.getAllTimeTable();
      provider.getCallData();
      provider.userDashboard();
    }
    else{
      provider.getCategories();
      provider.getAllBanners();
      provider.getAllChallenges();
    }
    // DynamicLinkService dynamicLinkService = DynamicLinkService();
    // dynamicLinkService.fetchLinkData(onHandle: (id) {});
    // provider.getCategories();
    // provider.getAllBanners();
    // provider.getAllChallenges();
    // releaseMutex();
    // getLocation();
    // provider.getAllTimeTable();
    // provider.getCallData();
    // provider.userDashboard();
  }

  // @override
  // void dispose() {
  //   provider.closeNotifier();
  //   super.dispose();
  // }

  void releaseMutex() async {
    try {
      notificationLock.release();
    } catch (e) {}
  }

  getLocation() async {
    final location = await getUserLocationLogic(
        onBackTap: () {
          Nav.pop();
        },
        onRetryTap: () {
          getLocation();
          Nav.pop();
        },
        withoutDialogue: true);
    if (location != null)
      getIt<UpdateLocationUseCase>()(UpdateLocationParams(
          clientId: UserSessionDataModel.userId,
          longitude: location.longitude,
          latitude: location.latitude));
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, _) {
        return ChangeNotifierProvider<HomeScreenNotifier>.value(
          value: provider,
          builder: (context, child) {
            context.watch<HomeScreenNotifier>();
            return DoubleTapBackExitApp(
              child: MultiBlocListener(
                listeners: [
                  // BlocListener<HomeCubit, HomeState>(
                  //   bloc: provider.homeCubit,
                  //   listener: (context, state) {
                  //     state.when(
                  //       homeInitState: () {},
                  //       homeLoadingState: () {},
                  //       homeLoadedState: (s) {},
                  //       challengesSuccess: (s) {},
                  //       homeErrorState: (error, callback) {},
                  //     );
                  //   },
                  // ),
                  BlocListener<ChallengeCubit, ChallengeState>(
                    bloc: provider.challengeCubit,
                    listener: (context, state) {
                      state.mapOrNull(
                        challengeLoadingState: (value) {
                          provider.isAllChallengesLoading = true;
                        },
                        challengeErrorState: (value) {
                          provider.isAllChallengesLoading = false;
                          provider.isAllChallengePagination = false;
                          provider.allChallengeAppErrors = value.error;
                        },
                        challengesSuccess: (value) {
                          provider.isAllChallengesLoading = false;
                          provider.isAllChallengePagination = false;

                          provider.addToChallenge(value.momentEntity.items!);
                        },
                      );
                    },
                    listenWhen: (previous, current) {
                      return true;
                    },
                  ),
                  BlocListener<NewsCubit, NewsState>(
                    listener: (context, state) {
                      state.mapOrNull(
                        newsCategoryLoaded: (value) {
                          provider.isLoading = false;
                          provider.newsCategories!.clear();
                          provider.newsCategories!.add(NewsCategoryItemEntity(
                              name: Translation.current.all, id: ""));
                          provider.newsCategories!
                              .addAll(value.newsCategoryEntity.result.items!);
                          if (provider.newsCategories!.isNotEmpty)
                            provider.getNewsOfCategory("");
                        },
                        newsOfSingleCategoryLoaded: (value) {
                          List<NewsItemOfCategoryEntity> categories = [];
                          categories.clear();
                          provider.newsLoading = false;
                          //Remove artist category
                          value.newsOfCategoryEntity.result.items!
                              .forEach((element) {
                            categories.add(element);
                            // if (element.categoryId != 16) {
                            //   categories.add(element);
                            // }
                          });
                          provider.categoryNews = categories;
                        },
                      );
                    },
                    bloc: provider.newsCubit,
                  ),
                ],
                child: Scaffold(
                  body: HomeScreenContent(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// Widget

  /// Logic
  // Future<void> initNotifications() async {
  //   if (AppConfig().os == SystemType.Android) {
  //     ().isNotificationAllowed().then(
  //           (isAllowed) {
  //         if (!isAllowed) {
  //           showDialog(
  //             context: context,
  //             builder: (context) => AlertDialog(
  //               title: Text(Translation.current.allow_notifications),
  //               content: Text(Translation.current.app_to_send_notifications),
  //               actions: [
  //                 TextButton(
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                   },
  //                   child: Text(
  //                     Translation.current.do_not_allow,
  //                     style: const TextStyle(color: Colors.grey, fontSize: 18),
  //                   ),
  //                 ),
  //                 TextButton(
  //                   onPressed: ()async{
  //                     await AwesomeNotifications().requestPermissionToSendNotifications();
  //                     showPermissionDialog();
  //                   }  ,
  //                   child: Text(
  //                     Translation.current.allow,
  //                     style: const TextStyle(
  //                       color: AppColors.primaryColorLight,
  //                       fontSize: 18,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           );
  //         }
  //       },
  //     );
  //   }
  //   else {
  //     NotificationPermissions.getNotificationPermissionStatus().then((value) {
  //       if(value != PermissionStatus.granted){
  //         AwesomeNotifications().isNotificationAllowed().then(
  //               (isAllowed) {
  //             if (!isAllowed) {
  //               showDialog(
  //                 context: context,
  //                 builder: (context) => AlertDialog(
  //                   title: Text(Translation.current.allow_notifications),
  //                   content: Text(Translation.current.app_to_send_notifications),
  //                   actions: [
  //                     TextButton(
  //                       onPressed: () {
  //                         Navigator.pop(context);
  //                       },
  //                       child: Text(
  //                         Translation.current.do_not_allow,
  //                         style: const TextStyle(color: Colors.grey, fontSize: 18),
  //                       ),
  //                     ),
  //                     TextButton(
  //                       onPressed:()async{
  //                         showPermissionDialog();
  //                       },
  //                       child: Text(
  //                         Translation.current.allow,
  //                         style: const TextStyle(
  //                           color: AppColors.primaryColorLight,
  //                           fontSize: 18,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               );
  //             }
  //           },
  //         );
  //       }
  //     });
  //
  //   }
  // }

  showPermissionDialog() {
    NotificationPermissions.requestNotificationPermissions(
            iosSettings: const NotificationSettingsIos(
                sound: true, badge: true, alert: true),
            openSettings: false)
        .then((value) => print(value));
  }
}
