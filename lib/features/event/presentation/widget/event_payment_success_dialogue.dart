import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/ticket_details_screen_params.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/features/event/domain/entity/create_event_ticket_entity.dart';
import 'package:starter_application/features/event/presentation/screen/ticket_details_screen.dart';
import 'package:starter_application/generated/l10n.dart';

class EventPaymentSuccessDialogue extends StatefulWidget {
  final CreateEventTicketEntity createEventTicketEntity;
  const EventPaymentSuccessDialogue(
      {Key? key, required this.createEventTicketEntity})
      : super(key: key);

  @override
  _EventPaymentSuccessDialogueState createState() =>
      _EventPaymentSuccessDialogueState();
}

class _EventPaymentSuccessDialogueState
    extends State<EventPaymentSuccessDialogue> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.r),
      ),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.r),
            color: AppColors.white,
          ),
          padding: EdgeInsets.all(80.w),
          child: SizedBox(
            width: 1.sw,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppConstants.IMG_EVENT_PROCESS_SUCCESS,
                  height: 0.1.sh,
                ),
                SizedBox(
                  height: 60.h,
                ),
                Text(
                  Translation.of(context).your_order_placed,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.mansourWhiteBackgrounColor_6,
                  ),
                ),
                SizedBox(
                  height: 60.h,
                ),
                CustomMansourButton(
                  height: 90.h,
                  onPressed: () {
                    Nav.pop();
                    Nav.off(TicketDetailsScreen.routeName,
                        arguments: TicketDetailsScreenParams(
                          createEventTicketEntity:
                              widget.createEventTicketEntity,
                        ));
                  },
                  titleText: Translation.of(context).view_my_ticket,
                  backgroundColor: AppColors.mansourDarkPurple,
                ),
              ],
            ),
          )),
    );
  }
}
