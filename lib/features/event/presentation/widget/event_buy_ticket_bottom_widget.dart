import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/features/event/domain/entity/event_entity.dart';
import 'package:starter_application/generated/l10n.dart';

class EventBuyTicketBottomWidget extends StatelessWidget {
  final String firstButtonText;
  final VoidCallback onFirstButtonPressed;
  bool isLoading;
  final EventEntity eventEntity;

  EventBuyTicketBottomWidget({
    Key? key,
    required this.eventEntity,
    required this.firstButtonText,
    this.isLoading = false,
    required this.onFirstButtonPressed,
  }) : super(key: key);

//const CircularProgressIndicator(
//                         color: AppColors.mansourDarkPurple,
//                       )
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50.r),
          topLeft: Radius.circular(50.r),
        ),
        boxShadow: [
          const BoxShadow(
              color: AppColors.mansourWhiteBackgrounColor_4,
              spreadRadius: 5,
              blurRadius: 5)
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 80.w),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           if(isLoading) const CircularProgressIndicator(
             color: AppColors.mansourDarkPurple,
           ),
          if(!isLoading) CustomMansourButton(
                backgroundColor: AppColors.mansourDarkPurple,
                titleText: firstButtonText,
                textColor: AppColors.white_text,
                onPressed: () {
                  onFirstButtonPressed();
                }),
            SizedBox(
              height: 20.h,
            ),
            // eventEntity.eventType == 4
            //     ? CustomMansourButton(
            //         backgroundColor: AppColors.mansourLightGreyColor_13,
            //         titleText: eventEntity.eventType == 0
            //             ? Translation.of(context).get_ticket_on_website
            //             : Translation.of(context).buy_ticket_on_website,
            //         textColor: AppColors.mansourDarkPurple,
            //         onPressed: () {
            //           launchURL(eventEntity.organizer!.companyWebsite);
            //         })
            //     : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
