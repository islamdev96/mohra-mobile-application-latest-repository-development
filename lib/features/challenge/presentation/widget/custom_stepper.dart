import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';

class CustomStepper extends StatelessWidget {
  final List<CustomStep> steps;
  final int currentStep;
  final Widget? selectedIndecator;
  final Color? selectedLineColor;
  final Widget? unSelectedIndecator;
  final Color? unSelectedLineColor;
  final Duration animationDuration;

  CustomStepper({
    Key? key,
    required this.steps,
    this.currentStep = -1,
    this.selectedIndecator,
    this.selectedLineColor,
    this.unSelectedIndecator,
    this.unSelectedLineColor,
    this.animationDuration = const Duration(
      milliseconds: 300,
    ),
  }) : super(key: key) {
    _selectedLineColor = selectedLineColor ?? AppColors.primaryColorLight;
    _unSelectedLineColor =
        unSelectedLineColor ?? AppColors.mansourLightGreyColor;
  }

  final Widget _selectedIndecator = Container(
    height: 70.h,
    width: 70.h,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: AppColors.mansourLightGreyColor,
    ),
    child: Center(
      child: Container(
        height: 50.h,
        width: 50.h,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryColorLight,
        ),
      ),
    ),
  );

  late final Color _selectedLineColor;

  final Widget _unSelectedIndecator = Container(
    height: 70.h,
    width: 70.h,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: AppColors.mansourLightGreyColor,
    ),
    child: Center(
      child: Container(
        height: 50.h,
        width: 50.h,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.accentColorLight,
        ),
      ),
    ),
  );

  late final Color _unSelectedLineColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              children: [
                for (int i = 0; i < steps.length; i++)
                  SizedBox(
                    height: steps[i].height,
                    child: Column(
                      children: [
                        currentStep >= i
                            ? _getSelectedIndecator(i)
                            : _getUnSelectedIndecator(i),
                        Expanded(
                          child: Container(
                            width: 5.w,
                            color: _unSelectedLineColor,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: AnimatedContainer(
                                duration: animationDuration,
                                width: 5.w,
                                height: currentStep > i ? steps[i].height : 0,
                                color: _selectedLineColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            Gaps.hGap32,
            Expanded(
              child: Column(
                children: steps,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _getSelectedIndecator(int index) {
    return steps[index].selectedIndecator ?? _selectedIndecator;
  }

  Widget _getUnSelectedIndecator(int index) {
    return steps[index].unSelectedIndecator ?? _unSelectedIndecator;
  }
}

class CustomStep extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? content;
  final Widget? selectedIndecator;
  final Widget? unSelectedIndecator;

  final double height;
  const CustomStep({
    Key? key,
    required this.title,
    required this.height,
    this.subtitle,
    this.content,
    this.selectedIndecator,
    this.unSelectedIndecator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Todo need more handling(ex: if subtitle == null then title and content need more flex,ect )
    return SizedBox(
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Align(
                  alignment: AlignmentDirectional.topStart, child: title)),
          if (subtitle != null)
            // Gaps.vGap32,
            Expanded(flex: 2, child: subtitle!),
          if (content != null)
            // Gaps.vGap64,
            Expanded(
                flex: 2,
                child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Row(
                      children: [
                        content!,
                      ],
                    ))),
        ],
      ),
    );
  }
}
