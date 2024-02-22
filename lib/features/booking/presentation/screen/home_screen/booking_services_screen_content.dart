import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/ui/widgets/empty_error_widget.dart';
import 'package:starter_application/features/booking/presentation/state_m/provider/booking_services_screen_notifier.dart';
import 'package:starter_application/features/booking/presentation/widget/booking_category_widget.dart';
import 'package:starter_application/features/booking/presentation/widget/booking_widget.dart';
import 'package:starter_application/features/event/domain/entity/event_category_entity.dart';
import 'package:starter_application/features/event/presentation/widget/event_tabs_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_title_widget.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/home_screen_notifier.dart';
import 'package:starter_application/features/home_services/presentation/state_m/provider/home_services_screen_notifier.dart';
import 'package:starter_application/features/home_services/presentation/widget/custom_shop_app_bar.dart';
import 'package:starter_application/features/home_services/presentation/widget/home_service_tabs_widget.dart';
import 'package:starter_application/features/home_services/presentation/widget/home_service_widget.dart';
import 'package:starter_application/features/home_services/presentation/widget/home_services_title_widget.dart';
import 'package:starter_application/features/home_services/presentation/widget/slider_home_services_home_page.dart';
import 'package:starter_application/features/shop/domain/entity/slider_entity.dart';
import 'package:starter_application/generated/l10n.dart';

import '../profile_booking_member_screen/porfile_booking_screen_content.dart';
import '../profile_booking_member_screen/profile_booking_screen.dart';

class BookingServicesScreenContent extends StatefulWidget {
  BookingServicesScreenContent({Key? key}) : super(key: key);

  @override
  _BookingServicesScreenContentState createState() =>
      _BookingServicesScreenContentState();
}

class _BookingServicesScreenContentState extends State<BookingServicesScreenContent> {
  late BookingServicesScreenNotifier sn;
  final padding = EdgeInsets.symmetric(
    horizontal: 50.w,
  );

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<BookingServicesScreenNotifier>(context);
    sn.context = context;
    return Scaffold(
      backgroundColor: AppColors.mansourLightGreyColor_6,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.mansourLightGreyColor_6,
        leading: InkWell(
            onTap: () {
              Nav.pop();
            },
            child: Icon(
              AppConstants.getIconBack(),
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Translation.current.Booking,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  _buildInfoRow(
                    title: Text("Jeddah, Saudi Arabia"),
                    subtitle: "",
                    image:  AppConstants.IMG_EVENT_LOCATION,
                  ),
                  Gaps.vGap24
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: HomeServicesTextField(
                hint: Translation.of(context).wha_services_are_you_looking_for,
                suffix: const Icon(Icons.search),
                hintSize: 14,
                onChanged: (s) => setState(() {
                  sn.search = s;
                }),
                controller: sn.controller,
                prefix: (sn.search != null ||
                    (sn.search != null && sn.search != ''))
                    ? InkWell(
                    onTap: () => setState(() {
                      sn.controller.clear;
                    }),
                    child: const Icon(Icons.close))
                    : null,
              ),
            ),
            HomeServicesSlider(
              imageSlider: [
                ItemEntity(
                    isActive: true,
                    id: 10,
                    startDate: DateTime.now(),
                    endDate: DateTime.now().add(Duration(days: 1)),
                    imageUrl:
                        "https://img.freepik.com/premium-photo/bottle-dishwashing-liquid-basket-rags-blue-background_393202-13839.jpg?w=1060",
                    productId: 1,
                    shopId: 1,
                    shopName: "ff"),
                ItemEntity(
                    isActive: true,
                    id: 10,
                    startDate: DateTime.now(),
                    endDate: DateTime.now().add(Duration(days: 1)),
                    imageUrl:
                        "https://m.media-amazon.com/images/I/41eFcBVIPoL._SX300_SY300_QL70_FMwebp_.jpg",
                    productId: 1,
                    shopId: 1,
                    shopName: "ff")
              ],
              onSendToParent: (id) {
                print(id);
              },
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: AppConstants.screenPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Translation.current.categories,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 40.sp,
                        ),
                      ),
                        InkWell(
                          onTap: () {

                          },
                          child: Text(
                            Translation.current.see_all,
                            style: TextStyle(
                              color: AppColors.mansourBackArrowColor2,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.sp,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Gaps.vGap40,
                SizedBox(
                  height: 130,
                  child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return LayoutBuilder(builder: (context, cons) {
                          return BookingCategoryWidget();
                        });
                      },
                      separatorBuilder: (context, index) {
                        return Gaps.hGap32;
                      },
                      itemCount: 10),
                ),

              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: AppConstants.screenPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Top Provider",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 40.sp,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Nav.to(ProfileBookingScreen.routeName);
                        },
                        child: Text(
                          Translation.current.see_all,
                          style: TextStyle(
                            color: AppColors.mansourBackArrowColor2,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Gaps.vGap40,
                SizedBox(
                  height: 0.3.sh,
                  width: 1.sw,
                  child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SizedBox(
                            width: 0.8.sw,
                            child: BookingWidget());
                      },
                      separatorBuilder: (context, index) {
                        return Gaps.hGap32;
                      },
                      itemCount: 10),
                ),
                Gaps.vGap40,
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Widgets
  Widget _buildEmptyWidget() {
    return SizedBox(
      height: 0.2.sh,
      child: Center(
        child: EmptyErrorScreenWidget(
          message: Translation.current.no_data,
          textColor: AppColors.white_text,
        ),
      ),
    );
  }


  Widget _buildInfoRow({
    required Text title,
    required String subtitle,
    required String image,
    bool isNetwork = false,
    Widget? button,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      SizedBox(
      height: 50.h,
      width: 50.h,
      child: SvgPicture.asset(
        AppConstants.SVG_PIN,
        color: AppColors.primaryColorLight,
      ),
    ),
        SizedBox(
          width: 40.w,
        ),
        title,
      ],
    );
  }
}
