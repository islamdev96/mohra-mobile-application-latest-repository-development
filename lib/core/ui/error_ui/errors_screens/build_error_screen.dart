import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/constants/enums/app_options_enum.dart';
import 'package:starter_application/generated/l10n.dart';

Widget buildErrorScreen({
  required BuildContext context,
  @required VoidCallback? callback,
  bool disableRetryButton = false,
  String? title,
  String? content,
  String? imageUrl,
  String? buttonContent,
  IconData? icon,
  ErrorAnimation? errorAnimation,
}) {
  final options = AppConfig().appOptions;

  Widget image = SizedBox.shrink();
  switch (options.errorViewOption) {
    case ErrorWidgetOptions.IMAGE:
      if (imageUrl != null && imageUrl != "") image = Image.asset(imageUrl);
      break;
    case ErrorWidgetOptions.LOTTIE:
      if (errorAnimation != null)
        image = SizedBox(
          height: ScreenUtil().setHeight(500),
          width: ScreenUtil().setWidth(500),
          child: GestureDetector(
            onTap: () async {
              if (!errorAnimation.animationController.isAnimating) {
                errorAnimation.animationController.reset();
                errorAnimation.animationController.forward();
              }
            },
            child: Lottie.asset(
              errorAnimation.animUrl,
              controller: errorAnimation.animationController,
              onLoaded: (composition) {
                // Configure the AnimationController with the duration of the
                // Lottie file and start the animation.
                errorAnimation.animationController
                  ..duration = composition.duration
                  ..forward();
              },
              repeat: false,
            ),
          ),
        );
      break;
    case ErrorWidgetOptions.NONE:
      image = SizedBox.shrink();
      break;
  }

  return Center(
    child: Container(
      height: ScreenUtil().setHeight(1000),
      width: ScreenUtil().setWidth(800),
      // width: ScreenUtil().setHeight(630),
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: ScreenUtil().setHeight(100),
            ),
            Container(
              width: ScreenUtil().setWidth(450),
              child: image,
            ),
            SizedBox(
              height: ScreenUtil().setHeight(100),
            ),
            Text(title ?? ""),
            if (content != null)
              Container(
                width: ScreenUtil().setWidth(800),
                height: ScreenUtil().setHeight(200),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Text(
                    content,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: ScreenUtil().setSp(40),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            SizedBox(
              height:
                  disableRetryButton != true ? ScreenUtil().setHeight(100) : 0,
            ),
            if (disableRetryButton == false && callback != null)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: Theme.of(context).primaryColor,
                ),
                onPressed: callback,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      icon != null
                          ? Icon(
                              icon,
                              color: Colors.white,
                            )
                          : const SizedBox(),
                      icon != null
                          ? const SizedBox(
                              width: 6,
                            )
                          : const SizedBox(),
                      Text(
                        buttonContent ?? Translation.of(context).retry,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(38),
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

class ErrorAnimation {
  final String animUrl;
  final AnimationController animationController;

  ErrorAnimation({
    required this.animUrl,
    required this.animationController,
  });
}
