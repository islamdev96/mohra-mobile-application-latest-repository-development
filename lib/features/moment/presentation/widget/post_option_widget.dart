import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';

class PostOptionWidget extends StatelessWidget {
  final double height;
  final double width;
  final String title;

  /// Svg image path
  final String? iconPath;
  final IconData? iconData;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color iconColor;
  const PostOptionWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.title,
    this.iconPath,
    this.iconData,
    this.onTap,
    this.backgroundColor = Colors.white,
    this.iconColor = AppColors.primaryColorLight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildCreatePostOptionWidget();
  }

  Widget _buildCreatePostOptionWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          child: LayoutBuilder(builder: (context, cons) {
            return InkWell(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: onTap,
              child: Center(
                child: SizedBox(
                  height: height * 0.6,
                  width: height * 0.6,
                  child: iconData != null
                      ? Icon(
                          iconData,
                          color: iconColor,
                        )
                      : iconPath != null
                          ? SvgPicture.asset(
                              iconPath!,
                              color: iconColor,
                            )
                          : null,
                ),
              ),
            );
          }),
        ),
        Gaps.vGap8,
        Container(
          // height: height *.39,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: height * 0.29,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
