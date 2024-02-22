import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';

import 'dotted_line_widget.dart';

class EventTicketCutWidget extends StatelessWidget {
  final Color? cutColor;
  final double? circleDiameter;
  final Color? borderColor;
  final Color? dottedLineColor;
  const EventTicketCutWidget(
      {Key? key,
      this.circleDiameter,
      this.cutColor,
      this.borderColor,
      this.dottedLineColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _circleDiameter = circleDiameter ?? 50.w;
    double _circleRadius = _circleDiameter / 2;

    return Stack(
      children: [
        Positioned(
          left: -_circleRadius,
          // top: 150.h,
          child: Container(
            height: _circleDiameter,
            width: _circleDiameter,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: cutColor ?? AppColors.white,
              border: Border.all(
                  color: borderColor ?? AppColors.mansourLightGreyColor_5),
            ),
          ),
        ),
        Positioned(
            right: _circleRadius,
            left: _circleRadius + 3.w,
            top: _circleRadius,
            child: DottedLineWidget(
              color: dottedLineColor ?? AppColors.mansourLightGreyColor_5,
            )),
        Positioned(
          right: -_circleRadius,
          // top: 150.h,
          child: Container(
            height: _circleDiameter,
            width: _circleDiameter,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: cutColor ?? AppColors.white,
              border: Border.all(
                  color: borderColor ?? AppColors.mansourLightGreyColor_5),
            ),
          ),
        ),
      ],
    );
  }
}
