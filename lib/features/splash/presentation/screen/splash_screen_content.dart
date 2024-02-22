import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';

class SplashScreenContent extends StatefulWidget {
  SplashScreenContent({Key? key}) : super(key: key);

  @override
  _SplashScreenContentState createState() => _SplashScreenContentState();
}

class _SplashScreenContentState extends State<SplashScreenContent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 0.32.sw,
            width: 0.32.sw,
            child: Image.asset(AppConstants.IMG_APP_LOGO),
          ),
          Gaps.vGap64,
          SizedBox(
            width: 0.35.sw,
            child: const LinearProgressIndicator(
              color: AppColors.mansourLightGreenColor,
            ),
          ),
        ],
      ),
    );
  }
}
