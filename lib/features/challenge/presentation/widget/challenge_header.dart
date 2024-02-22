import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';

class ChallengeHeader extends StatelessWidget {
  final String image;
  const ChallengeHeader({Key? key,required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.3.sh,
      decoration: BoxDecoration(
        // color: AppColors.mansourLightRed,
        image:  DecorationImage(
          image: NetworkImage(
            image,
          ),
          fit: BoxFit.contain,
        ),
        borderRadius: BorderRadius.circular(
          40.r,
        ),
      ),
      // child: Stack(
      //   children: [
      //     // _buildContent(),
      //     _buildBackgroundImage(),
      //   ],
      // ),
    );
  }

  Widget _buildContent() {
    return PositionedDirectional(
      top: 0,
      bottom: 0,
      start: 50.w,
      child: Container(
        width: 0.35.sw,
        child: Center(
          child: Text(
            "Lets help all orphand kids arround the world",
            style: TextStyle(
              color: Colors.white,
              fontSize: 50.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return PositionedDirectional(
        end: 0,
        top: 0,
        bottom: 0,
        child: IgnorePointer(
          child: Image.asset(
            AppConstants.IMG_HOME_CHALLENGE_2,
          ),
        ));
  }
}
