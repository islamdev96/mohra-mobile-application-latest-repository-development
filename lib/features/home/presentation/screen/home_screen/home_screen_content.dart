import 'package:booking_system_flutter/package_entry.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/images.dart';
import 'package:booking_system_flutter/utils/string_extensions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart' hide Toast;
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:starter_application/core/bloc/global/glogal_cubit.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/app_main_screen_notifier.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/home_screen_notifier.dart';
import 'package:starter_application/features/home/presentation/widget/all_challenge_widget.dart';
import 'package:starter_application/features/home/presentation/widget/news_card.dart';
import 'package:starter_application/features/news/domain/entity/news_of_category_entity.dart';
import 'package:starter_application/features/notification/presentation/screen/notification_list_screen.dart';
import 'package:starter_application/features/salary_count/domain/entity/time_table_list_entity.dart';
import 'package:starter_application/features/salary_count/presentation/screen/all_count_down_screen.dart';
import 'package:starter_application/features/salary_count/presentation/state_m/cubit/salary_count_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../../core/navigation/navigation_service.dart';
import '../../../../../core/ui/toast.dart';
import '../../../../../di/service_locator.dart';
import '../../../../../main.dart';
import '../../state_m/bloc/home_cubit.dart';

import 'home_screen.dart';

class HomeScreenContent extends StatefulWidget {
  HomeScreenContent({Key? key}) : super(key: key);

  @override
  _HomeScreenContentState createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  late HomeScreenNotifier sn;
  final padding = EdgeInsets.symmetric(
    horizontal: 50.w,
  );

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<HomeScreenNotifier>(context);
    sn.context = context;
    // sn.getCallData();
    return DraggableHome(
      title: Text(
        Translation.current.home,
        style: TextStyle(
          color: AppColors.mansourDarkBlueColor,
          fontWeight: FontWeight.bold,
          fontSize: 55.sp,
        ),
      ),
      alwaysShowLeadingAndAction: true,
      leading: !BlocProvider.of<GlogalCubit>(AppConfig().appContext,
                  listen: false)
              .isAuth
          ? const SizedBox()
          : Center(
              child: Builder(builder: (context) {
                return IconButton(
                  onPressed: () {
                    Provider.of<AppMainScreenNotifier>(context, listen: false)
                        .openDrawer();
                  },
                  icon: SvgPicture.asset(
                    AppConstants.SVG_GRID_FILL,
                    height: 80.sp,
                    color: sn.iconsColor(),
                  ),
                );
              }),
            ),
      actions: [
        if (BlocProvider.of<GlogalCubit>(AppConfig().appContext, listen: false)
            .isAuth)
          BlocBuilder<GlogalCubit, GlogalState>(
            builder: (context, state) {
              if (state is GlogalChanged) {
                if (state.numberNotificaions! > 0) {
                  return InkWell(
                    onTap: () {
                      Nav.to(
                        NotificationListScreen.routeName,
                      );
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Icon(
                              Icons.notifications,
                              color: sn.iconsColor(),
                              size: 30,
                            ),
                            Positioned(
                              top: state.numberNotificaions! >= 10 ? -15 : -11,
                              right:
                                  state.numberNotificaions! >= 10 ? -15 : -11,
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
                        )
                        //
                        //
                        // badges.Badge(
                        //   padding: EdgeInsets.all(8),
                        //   badgeContent: Text("${ state.numberNotificaions!  > 99 ? "+99" :state.numberNotificaions}"),
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       Nav.to(
                        //         NotificationListScreen.routeName,
                        //       );
                        //     },
                        //     child: Icon(
                        //       Icons.notifications,
                        //       color: sn.iconsColor(),
                        //       size: 30,
                        //     ),
                        //   ),
                        // ),
                        ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () {
                      Nav.to(
                        NotificationListScreen.routeName,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.notifications,
                        color: sn.iconsColor(),
                        size: 30,
                      ),
                    ),
                  );
                }
              } else {
                return GestureDetector(
                  onTap: () {
                    Nav.to(
                      NotificationListScreen.routeName,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.notifications,
                      color: sn.iconsColor(),
                      size: 30,
                    ),
                  ),
                );
              }
            },
          )
      ],
      headerWidget: _buildHomeHeader(),
      // drawer: _buildDrawer(),
      body: [
        Column(
          children: [
            if (BlocProvider.of<GlogalCubit>(AppConfig().appContext,
                    listen: false)
                .isAuth)
              Padding(
                padding: padding,
                child: _buildMoneyRow(),
              ),
            Gaps.vGap32,
            Padding(
              padding: padding,
              child: _buildCategoriesGridView(),
            ),
            // Gaps.vGap32,
            // Padding(
            //   padding: padding,
            //   child: _buildServiceApp(),
            // ),
            if (sn.isAllChallengesLoading || sn.allChallenges.length > 0)
              Gaps.vGap64,
            sn.isAllChallengesLoading && !sn.isAllChallengePagination
                ? Shimmer.fromColors(
                    child: Container(
                      width: 0.7.sw,
                      height: 0.2.sh,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.r),
                        color: AppColors.shimmerBaseColor,
                      ),
                    ),
                    baseColor: AppColors.shimmerBaseColor,
                    highlightColor: AppColors.shimmerHighlightColor)
                : AllChallengeWidget(
                    isLoading: sn.isAllChallengesLoading,
                    scrollController: sn.allChallengeScrollController,
                    height: 0.32.sh,
                    items: sn.allChallenges,
                    onChallengeTap: sn.onChallengeTap,
                  ),
            Gaps.vGap64,

            BlocConsumer<HomeCubit, HomeState>(
              bloc: sn.homeCubit,
              builder: (context, state) {
                return state.maybeMap(
                    bannersLoadingError: (s) => WaitingWidget(),
                    bannersLoadedState: (s) => Column(
                          children: [
                            Container(
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  autoPlay: true,
                                  aspectRatio: 2.0,
                                  enlargeCenterPage: true,
                                ),
                                items: sn.bannersWidgets,
                              ),
                            ),
                            Gaps.vGap40,
                          ],
                        ),
                    orElse: () => WaitingWidget());
              },
              listener: (context, state) {
                if (state is BannersLoadedState) {
                  sn.onAllBannersLoaded(state.bannersEntity);
                } else {
                  print(state.runtimeType);
                }
              },
            ),
            // Gaps.vGap64,
            // _buildChallengeCard(),
            // Gaps.vGap64,
            // _buildNewsCard(1),
            Gaps.vGap64,
            _buildTopPicksColumn(),
            Gaps.vGap64,
            SizedBox(
              height: 0.40.sh * (provider.categoryNews ?? []).length,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return NewsCard(
                    entity: provider.categoryNews![index],
                    hPadding: padding.left,
                    onLikeTap: (liked) => () {},
                  );
                },
                itemCount: (provider.categoryNews ?? []).length,
                separatorBuilder: (context, index) {
                  return Gaps.vGap64;
                },
              ),
            ),
            // _buildNewsCard(0),
            SizedBox(
              height: AppConstants.bottomNavigationBarHeight,
            ),
          ],
        ),
      ],
      headerExpandedHeight: 0.2,
    );
  }

  /// Widgets

  Widget _buildHomeHeader() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            sn.sliverAppbarBackgrounImage(),
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          PositionedDirectional(
            bottom: 100.h,
            start: 50.w,
            child: CustomListTile(
              width: 1.sw,
              title: Container(
                width: 0.9.sw,
                child: Text(
                  "${dayTimeTitle()} ${UserSessionDataModel.name}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 60.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  sn.sliverAppBarSubTitle(),
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 40.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoneyRow() {
    final height = 210.h;
    return BlocConsumer<SalaryCountCubit, SalaryCountState>(
      bloc: sn.salaryCountCubit,
      builder: (context, state) {
        return state.maybeMap(
          salaryCountLoadingState: (s) => _buildMoneyWaitingWidget(),
          salaryCountInitState: (s) => _buildMoneyWaitingWidget(),
          getAllTimeTableLoaded: (s) => GestureDetector(
            onTap: () {
              Nav.to(AllCountDownScreen.routeName)
                  .then((value) => sn.getAllTimeTable(updateNow: true));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                30.r,
              ),
              child: Stack(
                children: [
                  Container(
                    height: height,
                    // padding: EdgeInsets.symmetric(
                    //   horizontal: 50.w,
                    // ),
                    decoration: BoxDecoration(
                      color: AppColors.mansourDarkOrange4,
                      borderRadius: BorderRadius.circular(
                        30.r,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildMoneyItem(height, "", '', sn.getMoenyItem(0)),
                        SizedBox(
                          height: height * 0.9,
                          child: const VerticalDivider(
                            color: Colors.white,
                            width: 1,
                            thickness: 0.8,
                          ),
                        ),
                        _buildMoneyItem(
                            height, "\$ 0\n", '', sn.getMoenyItem(1)),
                        SizedBox(
                          height: height * 0.9,
                          child: const VerticalDivider(
                            color: Colors.white,
                            width: 1,
                            thickness: 0.8,
                          ),
                        ),
                        _buildMoneyItem(
                            height, "\$ 0\n", '', sn.getMoenyItem(2)),
                      ],
                    ),
                  ),
                  PositionedDirectional(
                    end: 0,
                    bottom: 0,
                    child: Transform.scale(
                      scale: 3,
                      child: Container(
                        height: 130.h * .5,
                        width: 130.h * .5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white.withOpacity(0.1),
                        ),
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    end: 0,
                    bottom: 0,
                    child: Transform.scale(
                      scale: 3,
                      child: Container(
                        height: 130.h * .6,
                        width: 130.h * .6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white.withOpacity(0.1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          orElse: () => GestureDetector(
            onTap: () {
              Nav.to(AllCountDownScreen.routeName);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                30.r,
              ),
              child: Stack(
                children: [
                  Container(
                    height: height,
                    // padding: EdgeInsets.symmetric(
                    //   horizontal: 50.w,
                    // ),
                    decoration: BoxDecoration(
                      color: AppColors.mansourDarkOrange4,
                      borderRadius: BorderRadius.circular(
                        30.r,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildMoneyItem(height, "", '', sn.getMoenyItem(0)),
                        SizedBox(
                          height: height * 0.9,
                          child: const VerticalDivider(
                            color: Colors.white,
                            width: 1,
                            thickness: 0.8,
                          ),
                        ),
                        _buildMoneyItem(
                            height, "\$ 0\n", '', sn.getMoenyItem(1)),
                        SizedBox(
                          height: height * 0.9,
                          child: const VerticalDivider(
                            color: Colors.white,
                            width: 1,
                            thickness: 0.8,
                          ),
                        ),
                        _buildMoneyItem(
                            height, "\$ 0\n", '', sn.getMoenyItem(2)),
                      ],
                    ),
                  ),
                  PositionedDirectional(
                    end: 0,
                    bottom: 0,
                    child: Transform.scale(
                      scale: 3,
                      child: Container(
                        height: 130.h * .5,
                        width: 130.h * .5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white.withOpacity(0.1),
                        ),
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    end: 0,
                    bottom: 0,
                    child: Transform.scale(
                      scale: 3,
                      child: Container(
                        height: 130.h * .6,
                        width: 130.h * .6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white.withOpacity(0.1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is GetAllTimeTableLoaded) {
          sn.onTimeTableLoaded(state.tableListEntity);
        }
      },
    );
  }

  Widget _buildMoneyWaitingWidget() {
    return Container(
      height: 200.h,
      child: Container(
        height: 200.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: AppColors.mansourDarkOrange4,
        ),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 200.h,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Shimmer.fromColors(
                                baseColor: AppColors.shimmerBaseColor,
                                highlightColor: AppColors.white,
                                child: Text('0 ${Translation.current.days}'),
                              ),
                            ],
                          ),
                          Gaps.vGap16,
                          Shimmer.fromColors(
                            baseColor: AppColors.shimmerBaseColor,
                            highlightColor: AppColors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                'Loading Title',
                                style: TextStyle(
                                  fontSize: 50.sp,
                                  color: AppColors.white,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 200.h * 0.9,
              child: const VerticalDivider(
                color: Colors.white,
                width: 1,
                thickness: 0.8,
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 200.h,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Shimmer.fromColors(
                                baseColor: AppColors.shimmerBaseColor,
                                highlightColor: AppColors.white,
                                child: Text('0 ${Translation.current.days}'),
                              ),
                            ],
                          ),
                          Gaps.vGap16,
                          Shimmer.fromColors(
                            baseColor: AppColors.shimmerBaseColor,
                            highlightColor: AppColors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                'Loading Title',
                                style: TextStyle(
                                  fontSize: 50.sp,
                                  color: AppColors.white,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 200.h * 0.9,
              child: const VerticalDivider(
                color: Colors.white,
                width: 1,
                thickness: 0.8,
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 200.h,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Shimmer.fromColors(
                                baseColor: AppColors.shimmerBaseColor,
                                highlightColor: AppColors.white,
                                child: Text('0 ${Translation.current.days}'),
                              ),
                            ],
                          ),
                          Gaps.vGap16,
                          Shimmer.fromColors(
                            baseColor: AppColors.shimmerBaseColor,
                            highlightColor: AppColors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                'Loading Title',
                                style: TextStyle(
                                  fontSize: 50.sp,
                                  color: AppColors.white,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoneyItem(
    double height,
    String value,
    String title,
    TimeTableItemEntity? item,
  ) {
    /* return Expanded(
      child: Container(
        color: Colors.blue,
        height: height * 0.7,
      ),
    ); */
    if (item != null) {
      return Expanded(
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text.rich(
                          TextSpan(
                              text: '${item.getDurationInDays()}  ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 70.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: Translation.current.days,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40.sp,
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ),
                    Gaps.vGap16,
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        isArabic ? item.arTitle ?? '' : item.enTitle ?? '',
                        style: TextStyle(
                          fontSize: 40.sp,
                          color: AppColors.white,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Expanded(
        child: Container(
          child: Center(
            child: Text(
              Translation.current.add_new,
              style: TextStyle(
                fontSize: 50.sp,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget _buildCategoriesGridView() {
    final double width = 1.sw - 2 * padding.left;
    final double space = 20.h;
    final double childHeight = 700.h;
    final double childCount = 2;
    final double height = childHeight * childCount * 1.02;
    final bool isAuth =
        BlocProvider.of<GlogalCubit>(AppConfig().appContext, listen: false)
            .isAuth;
    return Container(
      height: isAuth ? height : null,
      width: width,
      child: Column(
        mainAxisAlignment:
            isAuth ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
        children: [
          Container(
            height: childHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (isAuth)
                      _buildCategoryCard(
                        title: Translation.current.health,
                        height: 0.48 * childHeight,
                        width: 0.485 * width,
                        image: AppConstants.IMG_HEALTH,
                        onTap: sn.onHealthTap,
                        // onTap: () {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => MyPackageApp(
                        //                 keyNav: getIt<NavigationService>()
                        //                     .getNavigationKey,
                        //               )));
                        // },
                      ),
                    if (isAuth)
                      _buildCategoryCard(
                        title: Translation.current.home_services,
                        height: 0.48 * childHeight,
                        width: 0.485 * width,
                        image: AppConstants.IMG_SERVICE,
                        textColor: Colors.white,
                        showNotification: true,
                        onTap: () async {
                          try {
                            if (AppConfig().handyManUserData != null) {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyPackageApp(
                                    userData: AppConfig().handyManUserData!,
                                    languageCode: isArabic ? 'ar' : 'en',
                                  ),
                                ),
                              ).then((value) => {sn.userDashboard()});
                            }
                          } catch (e) {
                            Toast.show(Translation.current.please_login_again);
                          }
                        },
                      ),
                  ],
                ),
                _buildCategoryCard(
                  title: Translation.current.religion,
                  height: childHeight,
                  width: isAuth ? 0.485 * width : width,
                  image: AppConstants.IMG_RELIGION,
                  onTap: sn.onReligionTap,
                ),
              ],
            ),
          ),
          Gaps.vGap16,
          Container(
            height: isAuth ? childHeight : null,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCategoryCard(
                      title: Translation.current.news,
                      height: 0.48 * childHeight,
                      width: 0.485 * width,
                      image: AppConstants.IMG_NEWS,
                      onTap: sn.onNewsTap,
                    ),
                    _buildCategoryCard(
                      title: Translation.current.sports,
                      height: 0.48 * childHeight,
                      width: 0.485 * width,
                      image: AppConstants.IMG_SPORTS,
                      onTap: sn.onSportTap,
                    ),
                  ],
                ),
                if (isAuth)
                  _buildCategoryCard(
                    title: Translation.current.event,
                    height: 0.48 * childHeight,
                    width: width,
                    image: AppConstants.IMG_HOME_EVENT,
                    onTap: sn.OnEventTap,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildServiceApp() {
  //   final double width = 1.sw;
  //   final double childHeight = 700.h;
  //   final double childCount = 1;
  //   final double height = childHeight * childCount * 1.02;
  //
  //   return SizedBox(
  //     width: width,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Container(
  //           child: _buildCategoryCard(
  //             title: Translation.current.Services,
  //             height: 0.48 * childHeight,
  //             width: width,
  //             image: AppConstants.IMG_SERVICE,
  //             onTap: () async {
  //               if (await sn.getHandyManService() != null) {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => MyPackageApp(
  //                       userData: sn.handyManUserData!,
  //                     ),
  //                   ),
  //                 );
  //               } else {
  //                 Toast.show(Translation.current.please_login_again);
  //               }
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildCategoryCard({
    required String title,
    required String image,
    required double height,
    required double width,
    required VoidCallback onTap,
    bool showNotification = false,
    Color? textColor,
  }) {
    BoxDecoration decoration(String image) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        image: DecorationImage(
          matchTextDirection: true,
          image: AssetImage(
            image,
          ),
          fit: BoxFit.cover,
        ),
      );
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: height,
          width: width,
          decoration: decoration(image),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              30.r,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: 40.h,
                    bottom: 50.h,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: textColor ?? Colors.white,
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (showNotification)
          PositionedDirectional(
            top: -5.h,
            start: -10.h,
            child: Container(
              decoration: boxDecorationDefault(
                  color: context.cardColor, shape: BoxShape.circle),
              height: 36,
              padding: const EdgeInsets.all(8),
              width: 36,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  ic_notification
                      .iconImage(size: 24, color: primaryColor)
                      .center(),
                  Positioned(
                    top: -20,
                    right: -10,
                    child: sn.serviceProviderNotification > 0
                        ? Container(
                            padding: const EdgeInsets.all(4),
                            child: FittedBox(
                              child: Text(
                                  sn.serviceProviderNotification.toString(),
                                  style: primaryTextStyle(
                                      size: 12, color: Colors.white)),
                            ),
                            decoration: boxDecorationDefault(
                                color: Colors.red, shape: BoxShape.circle),
                          )
                        : Offstage(),
                  )
                ],
              ),
            ).onTap(() {}),
          )
      ],
    );
  }

  /// Top Picks
  Widget _buildTopPicksColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding,
          child: Text(
            Translation.current.picks_for_you,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 40.sp,
            ),
          ),
        ),
        Gaps.vGap64,
        _buildTopPicksFilters(),
      ],
    );
  }

  Widget _buildTopPicksFilters() {
    return SizedBox(
      height: 100.h,
      width: 1.sw,
      child: ListView.separated(
        padding: padding,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          // final filter = sn.topPicksFilters[index];
          return CustomMansourButton(
              height: 100.h,
              padding: EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 50.w,
              ),
              backgroundColor: sn.selectedFilterIndex == index
                  ? AppColors.primaryColorLight
                  : AppColors.mansourLightGreyColor_2,
              titleStyle: TextStyle(
                  color: sn.selectedFilterIndex == index
                      ? Colors.white
                      : Colors.black,
                  fontSize: 35.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular'),
              titleText: sn.newsCategories![index].name,
              onPressed: () =>
                  sn.onFilterPressed(index, sn.newsCategories![index].id!));
        },
        separatorBuilder: (context, index) {
          return Gaps.hGap32;
        },
        itemCount: sn.newsCategories!.length,
      ),
    );
  }

  /// ChallengeCard
  // Widget _buildChallengeCard() {
  //   return ChallengeCard(
  //     padding: EdgeInsets.all(padding.left),
  //   );
  // }

  /// NewsCard
  Widget _buildNewsCard(int index, NewsItemOfCategoryEntity entity) {
    // final news = sn.news[index];
    return NewsCard(
      entity: entity,
      hPadding: padding.left,
      onLikeTap: (liked) => () {},
    );
  }

  Widget _buildItem({
    required String title,
    required String subtitle,
    required double percent,
    required List<Color> percentGradient,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 40.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: AppColors.mansourLightGreyColor_11,
                fontSize: 40.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        Gaps.vGap32,
        LinearPercentIndicator(
          percent: percent,
          backgroundColor: AppColors.mansourLightGreyColor_7,
          linearGradient: LinearGradient(
            colors: percentGradient,
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
          animation: true,
          lineHeight: 22.h,
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }
}
