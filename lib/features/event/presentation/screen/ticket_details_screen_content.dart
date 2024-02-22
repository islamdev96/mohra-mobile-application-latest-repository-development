import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_ticket_details_widget.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/ticket_details_screen_notifier.dart';

class TicketDetailsScreenContent extends StatefulWidget {
  @override
  State<TicketDetailsScreenContent> createState() =>
      _TicketDetailsScreenContentState();
}

class _TicketDetailsScreenContentState
    extends State<TicketDetailsScreenContent> {
  late TicketDetailsScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<TicketDetailsScreenNotifier>(context);
    sn.context = context;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: 20.h,
        ),
        Expanded(
            flex: 3,
            child: Container(
              width: 1.sw,
              child: _buildTicketsListWidget(),
            )),
        SizedBox(
          height: 60.h,
        ),
        Expanded(
          child: Container(
            width: 1.sw,
            child: _buildBottomSection(),
          ),
        )
      ],
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 60.w,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          sn.isDownloadPdfLoading
              ? WaitingWidget()
              : CustomMansourButton(
                  titleText: Translation.of(context).download_pdf,
                  backgroundColor: AppColors.mansourDarkOrange3,
                  onPressed: sn.downloadPdf,
                ),
          SizedBox(
            height: 40.h,
          ),
          // CustomMansourButton(
          //   titleText: Translation.of(context).share_ticket,
          //   textColor: AppColors.mansourDarkOrange3,
          //   backgroundColor: AppColors.transparent,
          //   onPressed: sn.shareTicket,
          //   textSize: 35.sp,
          // ),
        ],
      ),
    );
  }

  Widget _buildTicketsListWidget() {
    return sn.isLoading
        ? WaitingWidget()
        : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 60.w,vertical: 16),
              child: Text(Translation.current.num_of_tickets+" "+"${sn.tickets.length}",style: TextStyle(color: AppColors.white),),
            ),
            Expanded(
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsetsDirectional.only(
                            start: index == 0 ? 60.w : 0, end: index == 2 ? 60.w : 0),
                        child: SizedBox(
                          height: 1.sh,
                          width: sn.tickets.length == 1 ? 0.9.sw : 0.85.sw,
                          child: Screenshot(
                            controller:
                                sn.tickets.elementAt(index).screenShotController,
                            child: EventTicketDetailsWidget(
                              ticket: sn.tickets.elementAt(index),
                            ),
                          ),
                        ));
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 25.w,
                    );
                  },
                  itemCount: sn.tickets.length),
            ),
          ],
        );
  }
}
