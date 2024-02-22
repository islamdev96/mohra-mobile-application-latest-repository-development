import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';

class EventExpansionTileWidget extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const EventExpansionTileWidget(
      {Key? key, required this.title, required this.children})
      : super(key: key);

  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: AppColors.transparent),
      child: ExpansionTile(
        title: Text(
          title,
          style: TextStyle(
            color: AppColors.black_text,
            fontSize: 60.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        tilePadding: EdgeInsets.symmetric(
          horizontal: 60.w,
        ),
        childrenPadding: EdgeInsets.symmetric(horizontal: 60.w),
        children: children,
      ),
    );
  }
}
