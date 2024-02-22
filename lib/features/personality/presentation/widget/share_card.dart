import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';

class ShareWidget extends StatelessWidget {
  final Function() onScreenShot;
  final Function() onShare;

  const ShareWidget(
      {Key? key, required this.onScreenShot, required this.onShare})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTitleAndIconRow("Take Screenshot", AppConstants.SVG_CAMERA_FILL,
            onTap: onScreenShot),
        _buildTitleAndIconRow("Share", AppConstants.SVG_SHARE_FILL,
            onTap: onShare),
      ],
    );
  }

  Widget _buildTitleAndIconRow(String title, String icon,
      {VoidCallback? onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 40.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gaps.hGap32,
            SizedBox(
              height: 70.h,
              width: 70.h,
              child: SvgPicture.asset(
                icon,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
