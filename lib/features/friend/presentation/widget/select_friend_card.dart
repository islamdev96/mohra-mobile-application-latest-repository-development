import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';

class SelectFriendCard extends StatelessWidget {
  final double height;
  final double? width;
  final Color? color;
  final String? title;
  final TextStyle? titleStyle;
  final double? bottomPadding;
  final String? image;
  final bool isSelected;
  final VoidCallback? onTap;

  const SelectFriendCard({
    Key? key,
    this.height = 100,
    this.isSelected = false,
    this.width,
    this.color,
    this.title,
    this.image,
    this.titleStyle,
    this.bottomPadding,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      padding: EdgeInsetsDirectional.only(
        start: AppConstants.hPadding,
        end: AppConstants.hPadding,
        bottom: bottomPadding ?? 0,
      ),
      height: height,
      width: width,
      backgroundColor: color,
      leading: image == null
          ? null
          : ClipOval(
              child: SizedBox(
                  height: height * 0.6,
                  width: height * 0.6,
                  child: CustomNetworkImageWidget(
                    imgPath: image!,
                  )),
            ),
      title: Text(
        title ?? "",
        style: titleStyle ??
            TextStyle(
              color: Colors.black,
              fontSize: 45.sp,
              fontWeight: FontWeight.bold,
            ),
      ),
      trailing: Align(
        alignment: Alignment.center,
        child: SvgPicture.asset(

          isSelected
              ? AppConstants.SVG_CHECKMARK_CIRCLE_FILL
              : AppConstants.SVG_RADIO_BUTTON_OFF,
          color: isSelected
              ? AppColors.primaryColorLight
              : AppColors.accentColorLight,
          alignment: Alignment.center,
          height: 60.h,
          width: 60.h,
        ),
      ),
      onTap: onTap,
    );
  }
}
