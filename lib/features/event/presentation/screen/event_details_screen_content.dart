import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/constants/enums/user_type.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/buy_ticket_screen_params.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/event/domain/entity/event_entity.dart';
import 'package:starter_application/features/event/presentation/screen/event_comment_section_screen.dart';
import 'package:starter_application/features/event/presentation/widget/event_ads_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_buy_ticket_bottom_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_divider_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_expansion_tile_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_gallery_grid_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_gallery_shimmer_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_info_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_people_going_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_select_ticket_widget.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/event_details_screen_notifier.dart';
import '../widget/event_select_ticket_widget_without_select.dart';
import 'buy_ticket_screen.dart';

class EventDetailsScreenContent extends StatefulWidget {
  @override
  State<EventDetailsScreenContent> createState() =>
      _EventDetailsScreenContentState();
}

class _EventDetailsScreenContentState extends State<EventDetailsScreenContent> {
  late EventDetailsScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<EventDetailsScreenNotifier>(context);
    sn.context = context;
    return sn.isLoading
        ? WaitingWidget()
        : Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 60.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildCoverWidget(),
                            SizedBox(
                              height: 40.h,
                            ),
                            _buildTypeWidget(),
                            SizedBox(
                              height: 40.h,
                            ),
                            _buildTitleWidget(sn.eventEntity.title),
                            SizedBox(
                              height: 40.h,
                            ),
                            _buildDescriptionWidget(),
                          ],
                        ),
                      ),
                      EventDividerWidget(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 60.w),
                        child: EventInfoWidget(eventEntity: sn.eventEntity),
                      ),
                      sn.eventEntity.gallery.isEmpty && !sn.eventLoaded
                          ? EventGalleryShimmerWidget(
                              width: 1.sw,
                            )
                          : sn.eventEntity.gallery.isNotEmpty
                              ? _buildGalleryGridWidget(sn.eventEntity)
                              : const SizedBox.shrink(),
                      EventDividerWidget(noBottomSpace: true),
                      EventExpansionTileWidget(
                        children: [_buildAboutWidget()],
                        title: Translation.of(context).about_this_event,
                      ),
                      EventDividerWidget(noTopSpace: true, noBottomSpace: true),
                      EventExpansionTileWidget(
                        children: [
                          EventSelectTicketWidgetWithOutSelect(
                            onTicketUnSelect: (info) {},
                            onTicketSelect: (info) {},
                            eventEntity: sn.eventEntity,
                          )
                        ],
                        title: Translation.of(context).ticketing,
                      ),
                      EventDividerWidget(
                        noTopSpace: true,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 60.w),
                            child: _buildTitleWidget(
                                (sn.eventEntity.bookedSeats ?? 0).toString() +
                                    ' ' +
                                    Translation.of(context)
                                        .people_going_to_event),
                          ),
                          SizedBox(
                            height: 40.w,
                          ),
                          EventPeopleGoingWidget(
                            clients: sn.eventEntity.clients,
                            peopleGoing: sn.eventEntity.bookedSeats,
                            commentCount: sn.commentsCount,
                            likeCount: sn.likesCount,
                            like: sn.like,
                            isLiked: sn.isLiked,
                            onCommentSectionTap: () {
                              if (UserSessionDataModel.userType ==
                                  UserType.CLIENT) sn.viewCommentSection = true;
                            },
                          ),
                          !sn.eventEntity.hideComments
                              ? Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 60.w),
                                  child: EventCommentSectionScreen(
                                    eventEntity: sn.eventEntity,
                                    onAddComment: () {
                                      sn.increaseComments();
                                    },
                                    onHideAllPressed: () {
                                      sn.viewCommentSection = false;
                                    },
                                  ),
                                )
                              : const SizedBox.shrink(),
                          SizedBox(
                            height: 30.w,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 60.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildTitleWidget(Translation.of(context).tags),
                                SizedBox(
                                  height: 40.h,
                                ),
                                _buildTagsWidget(),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                    ],
                  ),
                ),
              ),
              if (UserSessionDataModel.userType == UserType.CLIENT)
                EventBuyTicketBottomWidget(
                  eventEntity: sn.eventEntity,
                  firstButtonText: sn.eventEntity.eventType == 0
                      ? Translation.of(context).get_ticket_now
                      : Translation.of(context).buy_ticket_now,
                  onFirstButtonPressed: () {
                    Nav.off(BuyTicketScreen.routeName,
                        arguments: BuyTicketScreenParams(
                          eventEntity: sn.eventEntity,
                        ));
                  },
                )
            ],
          );
  }

  Widget _buildGalleryGridWidget(EventEntity eventEntity) {
    return Column(
      children: [
        EventDividerWidget(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 60.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleWidget(Translation.of(context).event_gallery),
              SizedBox(
                height: 40.h,
              ),
              EventGalleryGridWidget(
                images: eventEntity.gallery,
                width: 1.sw,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTypeWidget() {
    return Container(
      height: 65.h,
      decoration: BoxDecoration(
        color: AppColors.mansourLightPink,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 45.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              sn.eventEntity.categoryName,
              style: TextStyle(
                  color: AppColors.mansourDarkPurple,
                  fontSize: 45.sp,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverWidget() {
    return Stack(
      children: [
        Container(
          height: 0.20.sh,
          width: 1.sw,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.r),
            child: CustomNetworkImageWidget(
              imgPath: sn.eventEntity.mainPicture,
              boxFit: BoxFit.cover,
            ),
          ),
        ),
        if (sn.eventEntity.fromDate!.isAfter(DateTime.now()))
          Align(
            alignment:
                AppConfig().isLTR ? Alignment.topLeft : Alignment.topRight,
            child: ClipPath(
              clipper: DiscountClipper(AppConfig().isLTR ? "en" : "ar"),
              child: Container(
                width: 0.15.sw,
                height: 0.15.sw,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: !AppConfig().isLTR
                            ? Radius.circular(8.0)
                            : Radius.zero,
                        topLeft: !AppConfig().isLTR
                            ? Radius.zero
                            : Radius.circular(8.0)),
                    color: AppColors.primaryColorLight),
                child: Align(
                  alignment: AppConfig().isLTR
                      ? Alignment.topLeft
                      : Alignment.topRight,
                  child: Transform.rotate(
                    angle: AppConfig().isLTR ? -0.25 * 3.14 : 0.25 * 3.14,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Marquee(
                          text: Translation.current.coming_soon,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.white),
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
                        )),
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }

  Widget _buildTitleWidget(String title) {
    return Text(
      title,
      style: TextStyle(
        color: AppColors.black_text,
        fontWeight: FontWeight.bold,
        fontSize: 60.sp,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildDescriptionWidget() {
    return Html(data: sn.eventEntity.description);
    /* return Text.rich(TextSpan(
        text: sn.seeMoreDescription
            ? sn.eventEntity.description
            : sn.eventEntity.description.characters.take(70).string,
        children: <InlineSpan>[
          TextSpan(
              text: sn.eventEntity.description.characters.length > 70
                  ? sn.seeMoreDescription
                      ? ' ' + Translation.of(context).see_less
                      : ' ' + Translation.of(context).see_more
                  : '',
              style: const TextStyle(
                color: AppColors.mansourDarkOrange,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  sn.seeMoreDescription = !sn.seeMoreDescription;
                })
        ]));*/
  }

  Widget _buildAboutWidget() {
    return SizedBox(
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sn.eventEntity.title,
            style: TextStyle(
              color: AppColors.mansourDarkOrange3,
              fontSize: 60.sp,
            ),
          ),
          SizedBox(
            height: 50.w,
          ),
          Text(
            sn.eventEntity.about,
            style: TextStyle(
              color: AppColors.black_text,
              fontSize: 55.sp,
            ),
          ),
          if (UserSessionDataModel.userType == UserType.EventOrganizer)
            SizedBox(
              height: 50.w,
            ),
          if (UserSessionDataModel.userType == UserType.EventOrganizer)
            Text(
              "Scanned Tickets Number : ${sn.eventEntity.scannedTicketsNum ?? 0}",
              style: TextStyle(
                color: AppColors.black_text,
                fontSize: 55.sp,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTagsWidget() {
    return Wrap(
      spacing: 20.w,
      children: sn.eventEntity.tags.map((e) => _buildTagWidget(e)).toList(),
    );
  }

  Widget _buildTagWidget(String tagName) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 60.h,
          decoration: BoxDecoration(
              color: AppColors.mansourLightGreyColor_14,
              borderRadius: BorderRadius.circular(40.r)),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Text(
                tagName,
                style: const TextStyle(
                  color: AppColors.black_text,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
