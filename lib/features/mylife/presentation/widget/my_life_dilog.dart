import 'package:circular_widgets/circular_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';

void showMyLifeDialog(
    BuildContext context, {

      /// Can be any widget, preferably a circle
      /// If the items are not circles, then it is preferred to use flexible widgets instead of fixed sizes
      required List<Widget> items,
      required double itemRadius,
      required double centerRadius,
    }) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        clipBehavior: Clip.none,
        child: WheelPickerDialog(
          itemRadius: itemRadius,
          centerRadius: centerRadius,
          items: items,
        ),
      );
    },
    barrierColor: Colors.black.withOpacity(0.8),
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
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  PositionedDirectional(
                    bottom: 450.h,
                    end: 20.w,
                    child: Column(
                      children: [
                        Container(
                          width: 1.sw,
                          height: 150.h,
                          child: widget.items[0],
                        ),
                        Container(
                          width: 1.sw,
                          height: 150.h,
                          child: widget.items[1],
                        ),
                        Container(
                          width: 1.sw,
                          height: 150.h,
                          child: widget.items[2],
                        ),
                        Container(
                          width: 1.sw,
                          height: 150.h,
                          child: widget.items[3],
                        ),
                      ],
                    ),
                  ),
                  // PositionedDirectional(
                  //   bottom: 500.h,
                  //   end: 20.w,
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children:widget.items.map((e) => Container(
                  //       decoration: const BoxDecoration(
                  //         color: Colors.white,
                  //         shape: BoxShape.circle,
                  //       ),
                  //       child: LayoutBuilder(builder: (context, cons) {
                  //         return InkWell(
                  //           hoverColor: Colors.transparent,
                  //           splashColor: Colors.transparent,
                  //           focusColor: Colors.transparent,
                  //           highlightColor: Colors.transparent,
                  //           onTap:(){},
                  //           child: Center(
                  //             child: SizedBox(
                  //               height: 0.6 * cons.maxHeight,
                  //               width: 0.6 * cons.maxHeight,
                  //               child: SvgPicture.asset(
                  //                 AppConstants.SVG_ARROW_IOS_RIGHT,
                  //               ),
                  //             ),
                  //           ),
                  //         );
                  //       }),
                  //     ),).toList()
                  //   ),
                  // ),
                  PositionedDirectional(
                    bottom: 300.h,
                    end: 20.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120.h,
                          height: 120.h,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColorLight,
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
