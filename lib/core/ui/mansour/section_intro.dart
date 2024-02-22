import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';

import 'button/custom_mansour_button.dart';

class SectionIntro extends StatelessWidget {
  final String title;
  final String? topDescription;
  final String? bottomDescription;
  final String? image;
  final String? buttonTitle;
  final Color? buttonColor;
  final VoidCallback? onTap;
  final Widget? button;

  const SectionIntro({
    Key? key,
    required this.title,
    this.topDescription,
    this.bottomDescription,
    this.image,
    this.buttonTitle,
    this.buttonColor,
    this.onTap,
    this.button,
  }) : super(key: key);

  double get imageHeight => bottomDescription == null ? 0.42.sh : 0.32.sh;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConstants.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildAppbarTitle(
            title,
            padding: EdgeInsets.zero,
            size: TitleSize.large,
          ),
          _buildTopDescription(),
          const Spacer(),
          Column(
            children: [
              _buildImage(),
              _buildBottomDescription(),
            ],
          ),
          const Spacer(),
          CustomMansourButton(
            titleText: buttonTitle,
            textColor: AppColors.lightFontColor,
            backgroundColor: buttonColor ?? AppColors.primaryColorLight,
            onPressed: () {
              onTap?.call();
            },
          ),
          Gaps.vGap32,
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (image == null) return const SizedBox.shrink();
    return Center(
      child: SizedBox(
        height: imageHeight,
        width: 0.7.sw,
        child: Image.asset(image!),
      ),
    );
  }

  Widget _buildTopDescription() {
    if (topDescription == null) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.vGap32,
        Text(
          topDescription!,
          style: TextStyle(
            color: Colors.black,
            fontSize: 45.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomDescription() {
    if (bottomDescription == null) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.vGap64,
        Text(
          bottomDescription!,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.accentColorLight,
            fontSize: 45.sp,
          ),
        ),
      ],
    );
  }
}
