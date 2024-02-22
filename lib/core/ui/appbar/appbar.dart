import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';

enum TitleSize {
  small,
  medium,
  large,
}

GradientAppBar buildCustomAppbar(
    {bool hideBackButton = false,
    String? titleText,
    Widget? title,
    TextStyle? style,
    double? elevation,
    Color? backgroundColor,
    Color? forgroundColor,
    Gradient? gradient,
    Widget? leading,
    List<Widget>? actions,
    Widget? bottom,
    bool? centerTitle,
    void Function()? onBackTap,
    Size? bottomSize}) {
  assert(!((bottom != null) ^ (bottomSize != null)),
      "If bottom != null then bottomSize != null and viceversa");
  return GradientAppBar(
    gradient: gradient ??
        LinearGradient(
          colors: [
            backgroundColor ?? Colors.white,
            backgroundColor ?? Colors.white,
          ],
        ),
    centerTitle: centerTitle,
    elevation: elevation ?? 0,
    title: title ??
        (titleText == null
            ? null
            : Text(
                titleText,
                style: style ??
                    TextStyle(
                      fontSize: 55.sp,
                      fontWeight: FontWeight.bold,
                      color: forgroundColor ?? Colors.black,
                    ),
              )),
    leading: leading ??
        (hideBackButton
            ? null
            : IconButton(
                onPressed: () =>
                    onBackTap != null ? onBackTap.call() : Nav.pop(),
                icon: Icon(
                  AppConstants.getIconBack(),
                  color: forgroundColor ?? AppColors.mansourBackArrowColor,
                  size: 75.sp,
                ),
              )),
    actions: actions,
    bottom: bottom != null
        ? PreferredSize(
            child: bottom,
            preferredSize: bottomSize!,
          )
        : null,

    // bottom: PreferredSize(),
  );
}

@deprecated
// Todo replace this with buildCustomAppbar
/// This will be replaced in the future with buildCustomAppbar
AppBar buildAppbar({
  bool hideBackButton = false,
  String? title,
  TextStyle? style,
  Color? backgroundColor,
  Color? forgroundColor,
  double? elevation,
  List<Widget>? actions,
}) {
  return AppBar(
    backgroundColor: backgroundColor ?? Colors.white,
    shadowColor: Colors.transparent,
    elevation: elevation ?? 0,
    title: title == null ? null : Text(title),
    titleTextStyle: style ??
        TextStyle(
          fontSize: 55.sp,
          fontWeight: FontWeight.bold,
          color: forgroundColor ?? Colors.black,
        ),
    leading: hideBackButton
        ? null
        : IconButton(
            onPressed: () => Nav.pop(),
            icon: Icon(
              AppConstants.getIconBack(),
              color: forgroundColor ?? AppColors.mansourBackArrowColor,
              size: 30,
            ),
          ),
    actions: actions,
  );
}

Widget buildAppbarTitle(
  String title, {
  double? speicificSize,
  EdgeInsets? padding,
  TitleSize size = TitleSize.small,
}) {
  return Padding(
    padding: padding ?? AppConstants.screenPadding,
    child: Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontSize: speicificSize ?? _getTitleSize(size),
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

double _getTitleSize(TitleSize size) {
  switch (size) {
    case TitleSize.small:
      return 70.sp;
    case TitleSize.medium:
      return 85.sp;
    case TitleSize.large:
      return 95.sp;
  }
}
