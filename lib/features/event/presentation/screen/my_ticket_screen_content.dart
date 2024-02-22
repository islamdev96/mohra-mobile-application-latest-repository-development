import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/ui/widgets/pagination_widget.dart';
import 'package:starter_application/features/event/domain/entity/my_tickets_entity.dart';
import 'package:starter_application/features/event/presentation/widget/event_ticket_cut_widget.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/my_ticket_screen_notifier.dart';

class MyTicketScreenContent extends StatefulWidget {
  @override
  State<MyTicketScreenContent> createState() => _MyTicketScreenContentState();
}

class _MyTicketScreenContentState extends State<MyTicketScreenContent> {
  late MyTicketScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<MyTicketScreenNotifier>(context);
    sn.context = context;
    sn.context = context;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60.w),
      child: PaginationWidget<MyTicketsEntity>(
        child: ListView.separated(
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(
                bottom: index == sn.tickets.length - 1 ? 40.h : 0),
            child: _buildItem(sn.tickets.elementAt(index)),
          ),
          separatorBuilder: (context, index) => SizedBox(
            height: 50.h,
          ),
          itemCount: sn.tickets.length,
        ),
        getItems: (unit) async {
          return sn.returnData(unit);
        },
        items: sn.tickets,
        onDataFetched: sn.onDataFetched,
        refreshController: sn.refreshController,
      ),
    );
  }

  Widget _buildItem(MyTicketsEntity entity) {
    return Container(
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(25.r)),
        child: Column(
          children: [
            Container(
              height: 300.h,
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(40.r)),
                width: 1.sw,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 40.w,
                    left: 40.w,
                    right: 40.w,
                    bottom: 20.w,
                  ),
                  child: Row(
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.r),
                            child: CustomNetworkImageWidget(
                              imgPath: entity.event?.mainPicture ?? '',
                            )),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              '${Translation.current.Booking_ID}: ${entity.bookingId}',
                              style: const TextStyle(
                                color: AppColors.mansourDarkOrange3,
                              ),
                            ),
                            Text(
                              entity.event?.title ?? '',
                              style: TextStyle(
                                  color: AppColors.black_text,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 48.sp),
                              maxLines: 1,
                            ),
                            Text(
                              entity.event?.placeName ?? '',
                              style: TextStyle(
                                  color: AppColors.mansourWhiteBackgrounColor_6,
                                  fontSize: 35.sp),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
                height: 75.w,
                child: const EventTicketCutWidget(
                  dottedLineColor: AppColors.black,
                  cutColor: AppColors.mansourDarkPurple,
                  borderColor: AppColors.transparent,
                )),
            Padding(
              padding: EdgeInsets.only(
                bottom: 40.w,
                left: 40.w,
                right: 40.w,
                top: 20.w,
              ),
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 100.h,
                      child: Row(
                        children: [
                          FittedBox(
                            fit: BoxFit.contain,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  entity.tickets.elementAt(index).number,
                                  style: const TextStyle(
                                    color: AppColors.black_text,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${getTicketTypeName(entity.tickets.elementAt(index).type ?? 0)} | ${entity.tickets.elementAt(index).date != null ? DateFormat('EEE, dd-MM-yyyy hh:mm a').format(entity.tickets.elementAt(index).date!.toLocal()) : ''}',
                                  style: TextStyle(
                                      color: AppColors
                                          .mansourWhiteBackgrounColor_6,
                                      fontSize: 35.sp),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          CustomMansourButton(
                            padding: EdgeInsets.symmetric(horizontal: 50.w),
                            onPressed: () {
                              sn.gotoTicketDetails(entity);
                            },
                            textSize: 30.sp,
                            titleText: Translation.of(context).view_ticket,
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 60.h,
                      thickness: 1.h,
                    );
                  },
                  itemCount: entity.tickets.length),
            )
          ],
        ));
  }
}
