import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';
import 'package:shimmer/shimmer.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/localization/translations.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/event_details_screen_params.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/features/event/domain/entity/event_entity.dart';
import 'package:starter_application/features/event/presentation/screen/event_details_screen.dart';
import 'package:starter_application/generated/l10n.dart';

class EventsAdsWidget extends StatelessWidget {
  final double height;
  final bool isLoading;
  final ScrollController scrollController;
  final List<EventEntity> events;
  const EventsAdsWidget({
    Key? key,
    required this.events,
    required this.height,
    required this.isLoading,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Row(
          children: [
            ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Nav.to(EventDetailsScreen.routeName,
                          arguments: EventDetailsScreenParams(
                              eventEntity: events.elementAt(index)));
                    },
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                          start: index == 0 ? 60.w : 0,
                          end: index == events.length - 1 ? 60.w : 0),
                      child: Stack(
                        children: [
                          Container(
                            // height: 0.18.sh,
                            width: 0.8.sw,
                            // color: AppColors.white,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.r),
                              color: AppColors.white,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40.r),
                              child: CustomNetworkImageWidget(
                                imgPath: events.elementAt(index).mainPicture,
                                boxFit: BoxFit.fill,
                              ),
                            ),
                          ),
                          if(events[index].fromDate!.isAfter(DateTime.now()))
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
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 50.w,
                  );
                },
                itemCount: events.length),
            isLoading
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
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
class DiscountClipper extends CustomClipper<Path> {
  final String lang;

  DiscountClipper(this.lang);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(lang == "en" ? 0 : size.width, 0);
    path.lineTo(lang == "en" ? size.width : 0, 0);
    path.lineTo(lang == "en" ? 0 : size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper old) {
    return old != this;
  }
}