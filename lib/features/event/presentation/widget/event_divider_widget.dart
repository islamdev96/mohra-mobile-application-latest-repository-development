import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';

class EventDividerWidget extends StatelessWidget {
  final bool noBottomSpace;
  final bool noTopSpace;
  EventDividerWidget(
      {Key? key, this.noBottomSpace = false, this.noTopSpace = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        !noTopSpace
            ? SizedBox(
                height: 40.h,
              )
            : const SizedBox.shrink(),
        const Divider(
          color: AppColors.mansourLightGreyColor,
          thickness: 1,
        ),
        !noBottomSpace
            ? SizedBox(
                height: 40.h,
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
