import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
//Todo refactor this widget and make it more customizable
//Todo1 create HorizontalStep widget that contains all info needed to build each step
//Todo2 Make dynamic steprs count
class HorizontalStepper extends StatefulWidget {
  final int currentStep;
  final String? currentStepTitle;
  final VoidCallback? onCurrentStepTap;

  HorizontalStepper({
    Key? key,
    this.currentStep = 0,
    this.currentStepTitle,
    this.onCurrentStepTap,
  }) : super(key: key);

  @override
  State<HorizontalStepper> createState() => _HorizontalStepperState();
}

class _HorizontalStepperState extends State<HorizontalStepper> {
  final double _indecatorSize = 50.h;
  late final Widget _doneIndecator;
  late final Widget _unDoneIndecator;

  @override
  void initState() {
    _doneIndecator = _buildIndicator(true);

    _unDoneIndecator = _buildIndicator(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            for (int i = 0; i < 4; i++)
              ...{
                widget.currentStep > i ? _doneIndecator : _unDoneIndecator,
                if (i != 3)
                  Expanded(
                    child: Container(
                      height: 5.h,
                      color: AppColors.mansourLightGreyColor,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: AnimatedContainer(
                          duration: const Duration(),
                          width: 5.w,
                          // height: currentStep >= i ? steps[i].height : 0,
                          // color: _selectedLineColor,
                        ),
                      ),
                    ),
                  ),
              }.toList(),
          ],
        ),
        Gaps.vGap32,
        Row(
          children: [
            if (widget.currentStep >= 2)
              Spacer(
                flex: widget.currentStep == 3 ? 2 : 1,
              ),
            Expanded(
              flex: 2,
              child: _buildCurrentStepWindow(),
            ),
            if (widget.currentStep <= 1)
              Spacer(
                flex: widget.currentStep == 0 ? 2 : 1,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildIndicator(bool isDone) {
    return Container(
      height: _indecatorSize,
      width: _indecatorSize,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      child: Center(
        child: Container(
          height: _indecatorSize * 0.75,
          width: _indecatorSize * 0.75,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDone
                ? AppColors.mansourLightRed
                : AppColors.mansourLightGreyColor_3,
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentStepWindow() {
    if (widget.currentStepTitle == null || widget.currentStep >=4) return const SizedBox.shrink();
    double tailHeight = 25.h;
    double contentHeight = 100.h;
    return InkWell(
      onTap: widget.onCurrentStepTap,
      child: SizedBox(
        height: tailHeight + contentHeight,
        child: Stack(
          children: [
            PositionedDirectional(
              top: 5.h,
              end: getTailEnd,
              start: getTailStart,
              child: Center(
                child: Triangle.isosceles(
                  edge: Edge.TOP,
                  child: Container(
                    color: Colors.white,
                    width: 30.w,
                    height: tailHeight,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: tailHeight,
              child: Container(
                /// Add half of indicator width to the margin to center it with the indicator
                margin: widget.currentStep == 0 || widget.currentStep == 3
                    ? EdgeInsets.zero
                    : EdgeInsetsDirectional.only(
                        start: 80.w +
                            (widget.currentStep == 1
                                ? _indecatorSize * 0.5
                                : 0),
                        end: 80.w +
                            (widget.currentStep == 2
                                ? _indecatorSize * 0.5
                                : 0),
                      ),
                // padding: const EdgeInsets.symmetric(
                //   horizontal: 10,
                // ),

                height: 100.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.r),
                ),

                child: Center(
                  child: Text(
                    widget.currentStepTitle!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.mansourLightRed,
                      fontSize: 35.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double? get getTailEnd {
    return widget.currentStep == 2 || widget.currentStep == 3
        ? _indecatorSize * 0.5
        : widget.currentStep == 0
            ? null
            : 0;
  }

  double? get getTailStart => widget.currentStep == 1 || widget.currentStep == 0
      ? _indecatorSize * 0.5
      : widget.currentStep == 3
          ? null
          : 0;
}
