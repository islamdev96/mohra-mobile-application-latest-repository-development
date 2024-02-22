import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';

void showCreatePostPickerDialog(
  BuildContext context, {
  required List<Widget> items,
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
        child: CreatePostPickerDialog(
          items: items,
        ),
      );
    },
    barrierColor: Colors.black.withOpacity(0.8),
  );
}

class CreatePostPickerDialog extends StatefulWidget {
  final List<Widget> items;

  CreatePostPickerDialog({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  State<CreatePostPickerDialog> createState() => _CreatePostPickerDialogState();
}

class _CreatePostPickerDialogState extends State<CreatePostPickerDialog>
    with SingleTickerProviderStateMixin {
  late double circleWidgetRadius;
  late AnimationController _controller;
  late CurvedAnimation _animation;

  @override
  void initState() {
    super.initState();

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
                    bottom: AppConstants.bottomNavigationBarHeight + 10.h,
                    end: 30.w,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0; i < widget.items.length; i++) ...{
                            SizedBox(
                              width: 45.w,
                            ),
                            widget.items[i],
                          },
                        ]),
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
