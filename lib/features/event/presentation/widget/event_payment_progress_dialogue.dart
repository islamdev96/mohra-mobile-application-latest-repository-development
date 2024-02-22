import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/generated/l10n.dart';

class EventProgressDialogue extends StatefulWidget {
  const EventProgressDialogue({Key? key}) : super(key: key);

  @override
  _EventProgressDialogueState createState() => _EventProgressDialogueState();
}

class _EventProgressDialogueState extends State<EventProgressDialogue> {
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AppConstants.IMG_EVENT_PROCESSING,
                height: 0.1.sh,
              ),
              SizedBox(
                height: 60.h,
              ),
              Text(
                Translation.of(context).processing_your_order,
                style: TextStyle(
                    fontSize: 50.sp,
                    color: AppColors.black_text,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                Translation.of(context).wait_processing_your_order_now,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.mansourWhiteBackgrounColor_6,
                ),
              ),
            ],
          )),
    );
  }

  @override
  void initState() {
    super.initState();
    /*Future.delayed(const Duration(
      seconds: 2,
    )).then((value) {
      Nav.pop();
    });*/
  }
}
