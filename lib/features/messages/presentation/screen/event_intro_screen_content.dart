import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/messages/presentation/widgets/poll_intro_screen.dart';
import '../screen/../state_m/provider/event_intro_screen_notifier.dart';

class EventIntroScreenContent extends StatefulWidget {
  @override
  State<EventIntroScreenContent> createState() =>
      _EventIntroScreenContentState();
}

class _EventIntroScreenContentState extends State<EventIntroScreenContent> {
  late EventIntroScreenNotifier sn;
  double HeaderHeight = 0.15.sh;
  double ContentHeight = 0.13.sh;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<EventIntroScreenNotifier>(context);
    sn.context = context;
    return Stack(
      children: [
        _buildHeader(),
        _buildContent()
        // SectionIntro(
        //     title:
        //         "${dayTimeTitle()}\n${Provider.of<SessionData>(context).firstName}",
        //     bottomDescription:
        //         "Before using health feautre we need to know about your self and your goal, so we can give proper plans, exrecise and diet for your health",
        //     image: AppConstants.IMG_HEALTH_INTRO2,
        //     buttonTitle: "Start",
        //     buttonColor: AppColors.mansourDarkGreenColor,
        //     onTap: () {}),
      ],
    );
  }

  Widget _buildHeader() {
    return Positioned(
      top: 0,
      child: Container(
        width: 1.sw,
        height: HeaderHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(35.r),
            bottomLeft: Radius.circular(35.r),
          ),
          gradient: const LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: AppColors.MessageOrangeGradiant,
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Nav.pop(),
                    icon: Icon(
                      AppConstants.getIconBack(),
                      color: AppColors.white,
                      size: 75.sp,
                    ),
                  ),
                  Text(
                    "Create Event",
                    style: TextStyle(
                        fontSize: 50.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Positioned.fill(
        top: ContentHeight - 40.h,
        left: 0.0,
        right: 0.0,
        child: Container(
          width: 1.sw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.r),
              topRight: Radius.circular(50.r),
            ),
            color: AppColors.mansourLightGreyColor_4,
            boxShadow: [
              BoxShadow(
                color: AppColors.mansourNotSelectedBorderColor.withOpacity(0.3),
                blurRadius: 5,
              ),
            ],
          ),
          child: PollScreenIntro(
              bottomDescription:
                  "Create event with your friend, schedule it and invite them to join",
              TitleDescription: "Event",
              image: AppConstants.IMG_EVENT_INTRO,
              buttonTitle: "Create Now",
              button2Title: "",

              buttonColor: AppColors.primaryColorLight,
              onTap: sn.navTOCreateSplitScreen),
        ));
  }
}
