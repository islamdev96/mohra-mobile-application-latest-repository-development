import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/dimens.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/custom_map/widget/custom_map.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/ui/widgets/empty_error_widget.dart';
import 'package:starter_application/features/booking/presentation/state_m/provider/all_booking_screen_notifier.dart';
import 'package:starter_application/features/booking/presentation/state_m/provider/booking_services_screen_notifier.dart';
import 'package:starter_application/features/booking/presentation/state_m/provider/profile_booking_screen_notifier.dart';
import 'package:starter_application/features/booking/presentation/widget/booking_category_widget.dart';
import 'package:starter_application/features/booking/presentation/widget/booking_review_widget.dart';
import 'package:starter_application/features/booking/presentation/widget/booking_widget.dart';
import 'package:starter_application/features/booking/presentation/widget/home_filter.dart';
import 'package:starter_application/features/booking/presentation/widget/service_profile_booking_widget.dart';
import 'package:starter_application/features/event/domain/entity/event_category_entity.dart';
import 'package:starter_application/features/event/presentation/widget/event_tabs_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_title_widget.dart';
import 'package:starter_application/features/event_orginizer/presentation/state_m/provider/event_organizer_screen_notifier.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/home_screen_notifier.dart';
import 'package:starter_application/features/home_services/presentation/state_m/provider/home_services_screen_notifier.dart';
import 'package:starter_application/features/home_services/presentation/widget/custom_shop_app_bar.dart';
import 'package:starter_application/features/home_services/presentation/widget/home_service_tabs_widget.dart';
import 'package:starter_application/features/home_services/presentation/widget/home_service_widget.dart';
import 'package:starter_application/features/home_services/presentation/widget/home_services_title_widget.dart';
import 'package:starter_application/features/home_services/presentation/widget/slider_home_services_home_page.dart';
import 'package:starter_application/features/shop/domain/entity/slider_entity.dart';
import 'package:starter_application/generated/l10n.dart';

class ProfileBookingScreenContent extends StatefulWidget {
  static const String routeName = "/ProfileBookingScreenContent";
  ProfileBookingScreenContent({Key? key}) : super(key: key);

  @override
  _ProfileBookingScreenContentState createState() =>
      _ProfileBookingScreenContentState();
}

class _ProfileBookingScreenContentState
    extends State<ProfileBookingScreenContent>
    with SingleTickerProviderStateMixin {
  late ProfileBookingScreenNotifier sn;
  final padding = EdgeInsets.symmetric(
    horizontal: 50.w,
  );
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 4,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<ProfileBookingScreenNotifier>(context);
    sn.context = context;
    return Scaffold(
      backgroundColor: AppColors.mansourLightGreyColor_6,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Truefit & Hill",
          style: TextStyle(color: AppColors.white, fontSize: 20),
        ),
        leading: InkWell(
            onTap: () {
              Nav.pop();
            },
            child: Icon(
              AppConstants.getIconBack(),
              color: AppColors.white,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              AppConstants.SVG_SHARE_FILL,
              color: AppColors.white,
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: 1.sh,
            width: 1.sw,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 0.27.sh,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AppConstants.IMG_HOME_NIGHT),
                            fit: BoxFit.cover)),
                  ),
                  Container(
                    height: 0.7.sh,
                    color: AppColors.mansourLightGreyColor_4,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            width: 1.sw,
            top: 0.19.sh,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: AppColors.mansourLightGreyColor_6,
                      borderRadius: BorderRadius.circular(8)),
                  width: 1.sw,
                  height: 1.sh - 0.19.sh,
                  child: Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                        width: 1.sw,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            Container(
                              height: 130.h,
                              width: 130.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.primaryColorLight),
                                color: Colors.white,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://media.istockphoto.com/id/872361244/photo/man-getting-his-beard-trimmed-with-electric-razor.jpg?s=1024x1024&w=is&k=20&c=-5rC2g01SMHDEbCkU5hhpnrLodV4Xf4HMNWyGhk-k_4="),
                                    fit: BoxFit.cover),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.mansourBackArrowColor2
                                        .withOpacity(0.1),
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              // child: Center(
                              //   child: CustomNetworkImageWidget(
                              //     imgPath: image,
                              //     boxFit: BoxFit.cover,
                              //   ),
                              // ),
                            ),
                            Gaps.hGap64,
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        AppConstants.SVG_SHOP_STAR,
                                        color: AppColors.mansourYellow,
                                      ),
                                      Text("4.7"),
                                    ],
                                  ),
                                  Text(Translation.current.reviews),
                                ],
                              ),
                            ),
                            Gaps.hGap64,
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("1km"),
                                  Text(Translation.current.Distance),
                                ],
                              ),
                            ),
                            Gaps.hGap64,
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("20"),
                                  Text(Translation.current.following),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(color: AppColors.white, height: Dimens.dp40.h),
                      Container(
                        color: AppColors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomMansourButton(
                              width: 0.40.sw,
                              height: 0.043.sh,
                              backgroundColor: AppColors.white,
                              borderColor:
                                  AppColors.mansourGrey.withOpacity(0.5),
                              borderRadius: Radius.circular(10),
                              title: Text(Translation.current.Send_Message,
                                  style: TextStyle(
                                      color: AppColors.greyBackButton)),
                            ),
                            Gaps.hGap32,
                            CustomMansourButton(
                              width: 0.40.sw,
                              height: 0.043.sh,
                              backgroundColor: AppColors.white,
                              borderColor:
                                  AppColors.mansourGrey.withOpacity(0.5),
                              borderRadius: Radius.circular(10),
                              title: Text(
                                Translation.current.Follow,
                                style:
                                    TextStyle(color: AppColors.greyBackButton),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(color: AppColors.white, height: Dimens.dp40.h),
                      Container(
                        alignment: Alignment.center,
                        width: 1.sw,
                        color: AppColors.white,
                        child: TabBar(
                          onTap: (value) {
                            setState(() {});
                          },
                          padding: EdgeInsets.zero,
                          indicatorPadding: EdgeInsets.zero,
                          indicatorColor: AppColors.primaryColorLight,
                          controller: tabController,
                          labelColor: AppColors.primaryColorLight,
                          unselectedLabelColor: Colors.grey,
                          labelPadding: EdgeInsets.all(16),
                          isScrollable: false,
                          tabs: [
                            getItem(
                                icon: AppConstants.SVG_booking_list,
                                isColor: tabController.index == 0),
                            getItem(
                                icon: AppConstants.SVG_booking_images,
                                isColor: tabController.index == 1),
                            getItem(
                                icon: AppConstants.SVG_booking_stars,
                                isColor: tabController.index == 2),
                            getItem(
                                icon: AppConstants.SVG_booking_info,
                                isColor: tabController.index == 3),
                          ],
                        ),
                      ),
                      Container(color: AppColors.white, height: Dimens.dp40.h),
                      Expanded(
                          child: Container(
                        color: AppColors.mansourLightGreyColor_6,
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            SizedBox(
                              width: 1.sw,
                              child: ListView.separated(
                                itemCount: 10,
                                padding: EdgeInsets.zero,
                                separatorBuilder: (context, index) {
                                  return Gaps.vGap40;
                                },
                                itemBuilder: (context, index) {
                                  return ServiceProfileBookingWidget();
                                },
                              ),
                            ),
                            SizedBox(
                              width: 1.sw,
                              child: GridView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: 21,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 5,
                                        childAspectRatio: 1,
                                        mainAxisSpacing: 5),
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    // height:75,
                                    // width: 75,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "https://media.istockphoto.com/id/872361244/photo/man-getting-his-beard-trimmed-with-electric-razor.jpg?s=1024x1024&w=is&k=20&c=-5rC2g01SMHDEbCkU5hhpnrLodV4Xf4HMNWyGhk-k_4="),
                                          fit: BoxFit.cover,
                                        )),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: 1.sw,
                              child: ListView(
                                padding: EdgeInsets.zero,
                                children: [
                                  BookingReviewWidget(),
                                  BookingReviewWidget(),
                                  BookingReviewWidget(),
                                  BookingReviewWidget(),
                                ],
                              ),
                            ),
                            ListView(
                              padding: EdgeInsets.zero,
                              children: [
                                Gaps.vGap12,
                                Text(
                                  Translation.current.about_us,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Gaps.vGap32,
                                Text(
                                  "The Truefitt & Hill Grooming Experience is a combination of our three signature treatments that will ensure that a gentleman leaves our barbershop perfectly groomed and refreshed",
                                  style: TextStyle(
                                      color: AppColors.black.withOpacity(0.6)),
                                ),
                                Gaps.vGap64,
                                Text(
                                  "Opening Hours",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Gaps.vGap32,
                                Text(
                                  "SUN-MON 08:00 -16:00",
                                  style: TextStyle(
                                      color: AppColors.black.withOpacity(0.6)),
                                ),
                                Gaps.vGap64,
                                Text(
                                  "Locations",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Gaps.vGap32,
                                Text(
                                  "Al-Hada District Abdullah Bin Huzafah, Al-Sahmi Street, Riyadh 64819, Saudi Arabia",
                                  style: TextStyle(
                                      color: AppColors.black.withOpacity(0.6)),
                                ),
                                Gaps.vGap32,
                                Container(
                                  height: 0.25.sh,
                                  width: 1.sw,
                                  child: CustomMap(
                                    height: 0.25.sh,
                                    width: 1.sw,
                                    mapApiKey: AppConstants.API_KEY_GOOGLE_MAPS,
                                    distanceInfoWindowEnabled: false,
                                    disableMyLocationIcon: false,
                                    disableMyLocationButton: true,
                                    disableMyLocationPolylines: true,
                                    initialIndex: 0,
                                    onTap: (lat) {
                                      setState(() {});
                                    },
                                    mapToolbarEnabled: false,
                                    zoomControlsEnabled: false,
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(22.3,33.3),
                                      zoom: 10,
                                    ),
                                    onCameraMove: (l) async {
                                      // print("${l.target.latitude}, ${l.target.longitude}");
                                    },
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Widgets
  Widget getItem({required String icon, required bool isColor}) {
    return Container(
      alignment: Alignment.center,
      height: 0.03.sh,
      width: 0.13.sw,
      child: SvgPicture.asset(
        icon,
        color: isColor ? AppColors.primaryColorLight : Colors.grey,
      ),
    );
  }
}
