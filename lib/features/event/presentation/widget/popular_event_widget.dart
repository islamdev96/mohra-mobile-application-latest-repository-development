import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/event_details_screen_params.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/features/event/domain/entity/event_entity.dart';
import 'package:starter_application/features/event/presentation/screen/event_details_screen.dart';
import 'package:starter_application/features/event/presentation/widget/event_ads_widget.dart';
import 'package:starter_application/generated/l10n.dart';

class PopularEventWidget extends StatelessWidget {
  final EventEntity event;
  const PopularEventWidget({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Nav.to(EventDetailsScreen.routeName,
            arguments:
            EventDetailsScreenParams(eventEntity: event));
      },
      child: SizedBox(
        width: 0.8.sw,
        child: Column(
          children: [
            Expanded(
                flex: 7,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.r),
                          topLeft: Radius.circular(20.r),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.r),
                          topLeft: Radius.circular(20.r),
                        ),
                        child: CustomNetworkImageWidget(
                          imgPath: event.mainPicture,boxFit: BoxFit.fill,
                        ),
                      ),
                    ),
                    if(event.fromDate!.isAfter(DateTime.now()))
                      Align(
                        alignment: AppConfig().isLTR
                            ? Alignment.topLeft
                            : Alignment.topRight,
                        child: ClipPath(
                          clipper:
                          DiscountClipper(AppConfig().isLTR ? "en":"ar"),
                          child: Container(
                            width: 0.15.sw,
                            height: 0.15.sw,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight:
                                    !AppConfig().isLTR
                                        ? Radius.circular(8.0)
                                        : Radius.zero,
                                    topLeft:
                                    !AppConfig().isLTR
                                        ? Radius.zero
                                        : Radius.circular(8.0)),
                                color: AppColors.primaryColorLight),
                            child: Align(
                              alignment: AppConfig().isLTR
                                  ? Alignment.topLeft
                                  : Alignment.topRight,
                              child: Transform.rotate(
                                angle: AppConfig().isLTR
                                    ? -0.25 * 3.14
                                    : 0.25 * 3.14,
                                child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Marquee(
                                      text: Translation.current.coming_soon,
                                      style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.white),
                                      scrollAxis: Axis.horizontal,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      blankSpace: 20.0,
                                      velocity: 100.0,
                                      pauseAfterRound: Duration(seconds: 1),
                                      startPadding: 10.0,
                                      accelerationDuration: Duration(seconds: 1),
                                      accelerationCurve: Curves.linear,
                                      decelerationDuration: Duration(milliseconds: 500),
                                      decelerationCurve: Curves.easeOut,
                                    )
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                )),
            Expanded(flex: 3, child: _buildWidgetFooter(context))
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetFooter(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
        color: AppColors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 45.w),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.black_text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        event.placeName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            color: AppColors.mansourWhiteBackgrounColor_6,
                            fontSize: 35.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                CustomMansourButton(
                  onPressed: () {
                    Nav.to(EventDetailsScreen.routeName,
                        arguments:
                            EventDetailsScreenParams(eventEntity: event));
                  },
                  height: 80.h,
                  textSize: 35.sp,
                  titleText: Translation.of(context).view_details,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
