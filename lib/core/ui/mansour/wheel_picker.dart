import 'package:circular_widgets/circular_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';

void showWheelPickerDialog(
  BuildContext context, {
  /// Can be any widget, preferably a circle
  /// If the items are not circles, then it is preferred to use flexible widgets instead of fixed sizes
  required List<Widget> items,
  required double itemRadius,
  required double centerRadius,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: WheelPickerDialog(
          itemRadius: itemRadius,
          centerRadius: centerRadius,
          items: items,
        ),
      );
    },
    barrierColor: Colors.black.withOpacity(0.9),
  );
}

class WheelPickerDialog extends StatefulWidget {
  final List<Widget> items;
  final double itemRadius;
  final double centerRadius;

  WheelPickerDialog({
    Key? key,
    required this.items,
    required this.itemRadius,
    required this.centerRadius,
  }) : super(key: key);

  @override
  State<WheelPickerDialog> createState() => _WheelPickerDialogState();
}

class _WheelPickerDialogState extends State<WheelPickerDialog>
    with SingleTickerProviderStateMixin {
  late double circleWidgetRadius;
  late AnimationController _controller;
  late CurvedAnimation _animation;

  @override
  void initState() {
    super.initState();

    circleWidgetRadius = widget.itemRadius * 2 + widget.centerRadius;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _controller.reverse();
        return true;
      },
      child: InkWell(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: _onPop,
        child: AnimatedBuilder(
            animation: _animation,
            builder: (
              context,
              _,
            ) {
              return SizedBox(
                height: 1.sh,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: getAnimatedValue(200.h),
                      left: 0,
                      right: 0,
                      child: Container(
                        height: getAnimatedValue(circleWidgetRadius),
                        width: getAnimatedValue(circleWidgetRadius),
                        child: CircularWidgets(
                          config: CircularWidgetConfig(
                            centerWidgetRadius: 140.r,
                            innerSpacing: 0,
                            itemRadius: 120.r,

                          ),

                          itemBuilder: (BuildContext context, int index) {
                            return widget.items[index];
                          },
                          itemsLength: widget.items.length,
                          centerWidgetBuilder: (context) {
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      bottom: 0.h,
                      start: 0,
                      end: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 130.h,
                            width: 130.h,
                            decoration: const BoxDecoration(
                              color: AppColors.mansourDarkGreenColor,
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: _onPop,
                                  child: Center(
                                    child: SizedBox(
                                      height: 70.h,
                                      width: 70.h,
                                      child: SvgPicture.asset(
                                        AppConstants.SVG_CLOSE,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  /// Logic
  double getAnimatedValue(double value) {
    return value * _animation.value;
  }

  void _onPop() {
    _controller.reverse().then((value) => Nav.pop());
  }
}
