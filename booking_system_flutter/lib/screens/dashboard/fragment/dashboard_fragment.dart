import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/dashboard_model.dart';
import 'package:booking_system_flutter/network/rest_apis.dart';
import 'package:booking_system_flutter/screens/dashboard/component/category_component.dart';
import 'package:booking_system_flutter/screens/dashboard/component/featured_service_list_component.dart';
import 'package:booking_system_flutter/screens/dashboard/component/service_list_component.dart';
import 'package:booking_system_flutter/screens/dashboard/component/slider_and_location_component.dart';
import 'package:booking_system_flutter/screens/dashboard/shimmer/dashboard_shimmer.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:booking_system_flutter/utils/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../component/empty_error_state_widget.dart';
import '../../../component/loader_widget.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../component/booking_confirmed_component.dart';
import '../component/new_job_request_component.dart';

class DashboardFragment extends StatefulWidget {
  @override
  _DashboardFragmentState createState() => _DashboardFragmentState();
}

class _DashboardFragmentState extends State<DashboardFragment> {
  Future<DashboardResponse>? future;

  @override
  void initState() {
    super.initState();
    init();

    setStatusBarColor(transparentColor, delayInMilliSeconds: 800);

    LiveStream().on(LIVESTREAM_UPDATE_DASHBOARD, (p0) {
      init();
      setState(() {});
    });
  }

  void init() async {
    future = userDashboard(isCurrentLocation: appStore.isCurrentLocation, lat: getDoubleAsync(LATITUDE), long: getDoubleAsync(LONGITUDE));
    toast(language.homeToExit);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
    LiveStream().dispose(LIVESTREAM_UPDATE_DASHBOARD);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: context.statusBarHeight + 16,
            right: 16,
            child: Container(
              decoration: boxDecorationDefault(color: context.cardColor, shape: BoxShape.circle),
              height: 36,
              padding: EdgeInsets.all(8),
              width: 36,
              child: Stack(
                clipBehavior: Clip.none,
                children: [

                  Observer(builder: (context) {
                    return Positioned(
                      top: -20,
                      right: -10,
                      child: appStore.unreadCount.validate() > 0
                          ? Container(
                        padding: EdgeInsets.all(4),
                        child: FittedBox(
                          child: Text(appStore.unreadCount.toString(), style: primaryTextStyle(size: 12, color: Colors.white)),
                        ),
                        decoration: boxDecorationDefault(color: Colors.red, shape: BoxShape.circle),
                      )
                          : Offstage(),
                    );
                  }),
                ],
              ),
            ).onTap(() {
            }),
          ),
          SnapHelperWidget<DashboardResponse>(
            initialData: cachedDashboardResponse,
            future: future,
            errorBuilder: (error) {
              return NoDataWidget(
                title: error,
                imageWidget: ErrorStateWidget(),
                retryText: language.reload,
                onRetry: () {
                  appStore.setLoading(true);
                  init();

                  setState(() {});
                },
              );
            },
            loadingWidget: DashboardShimmer(),
            onSuccess: (snap) {
              return AnimatedScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                listAnimationType: ListAnimationType.FadeIn,
                fadeInConfiguration: FadeInConfiguration(duration: 2.seconds),
                onSwipeRefresh: () async {
                  appStore.setLoading(true);

                  init();
                  setState(() {});

                  return await 2.seconds.delay;
                },
                children: [
                  SliderLocationComponent(
                    sliderList: snap.slider.validate(),
                    callback: () async {
                      appStore.setLoading(true);

                      init();
                      setState(() {});
                    },
                  ),
                  30.height,
                  PendingBookingComponent(upcomingData: snap.upcomingData),
                  CategoryComponent(categoryList: snap.category.validate()),
                  16.height,
                  FeaturedServiceListComponent(serviceList: snap.featuredServices.validate()),
                  ServiceListComponent(serviceList: snap.service.validate()),
                  16.height,
                  NewJobRequestComponent(),
                ],
              );
            },
          ),
          Observer(builder: (context) => LoaderWidget().visible(appStore.isLoading)),
        ],
      ),
    );
  }
}
