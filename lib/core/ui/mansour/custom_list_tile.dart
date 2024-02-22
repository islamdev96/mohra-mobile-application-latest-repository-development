import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    this.height,
    this.width,
    this.padding,
    this.margin,
    this.border,
    this.borderRadius,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.gradient,
    this.backgroundColor,
    this.boxShadow,
    this.onTap,
    this.trailingAlignment,
    this.splashColor,
    this.trailingFlex,
    this.leadingFlex,
  })  : assert((leadingFlex == null && trailingFlex == null) ||
            (leadingFlex != null &&
                trailingFlex != null &&
                leadingFlex + trailingFlex >= 2 &&
                leadingFlex + trailingFlex <= 9) ||
            (leadingFlex != null && leadingFlex >= 1 && leadingFlex <= 8) ||
            (trailingFlex != null && trailingFlex >= 1 && trailingFlex <= 8)),
        super(key: key);

  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final Gradient? gradient;
  final Color? backgroundColor;
  final List<BoxShadow>? boxShadow;
  final Function()? onTap;
  final AlignmentDirectional? trailingAlignment;
  final Color? splashColor;
  final int? trailingFlex;
  final int? leadingFlex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: border,
        borderRadius: borderRadius,
        gradient: gradient,
        boxShadow: boxShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: onTap,
          borderRadius: borderRadius,
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (leading != null)
                  Expanded(
                    flex: leadingFlex ?? 2,
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: leading,
                    ),
                  ),
                Expanded(
                  flex: leading == null
                      ? trailing == null
                          ? 10
                          : trailingFlex != null
                              ? 10 - trailingFlex!
                              : 8
                      : trailing == null
                          ? leadingFlex == null
                              ? 8
                              : 10 - leadingFlex!
                          : leadingFlex == null
                              ? trailingFlex != null
                                  ? 8 - trailingFlex!
                                  : 6
                              : trailingFlex != null
                                  ? 10 - leadingFlex! - trailingFlex!
                                  : 8 - leadingFlex!,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title ?? const SizedBox(),
                      subtitle ?? const SizedBox(),
                    ],
                  ),
                ),
                if (trailing != null)
                  Expanded(
                    flex: trailingFlex ?? 2,
                    child: Align(
                      alignment: trailingAlignment ?? Alignment.topCenter,
                      child: trailing,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
