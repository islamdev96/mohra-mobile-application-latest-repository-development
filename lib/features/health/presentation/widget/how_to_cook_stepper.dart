import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/features/challenge/presentation/widget/custom_stepper.dart';

class HowToCookStepper extends StatelessWidget {
  HowToCookStepper({Key? key}) : super(key: key) {
    maxWidth = 1.sw - (AppConstants.hPadding * 2) - indecatorSize;
    height1 = getHeight(text1);
    height2 = getHeight(text2);
    height3 = getHeight(text3);
    height4 = getHeight(text4);
    print(height1);
    print(height2);
    print(height3);
    print(height4);
  }

  final textStyle = TextStyle(
    color: Colors.black,
    fontSize: 40.sp,
  );
  final double indecatorSize = 80.h;
  final double space = 32.h;
  final double imageHeight = 600.h;
  late final double maxWidth;

  String text1 = "Gather the ingredients.";
  String text2 =
      "Slice the sirloin steak into thin strips, against the grain to help with tenderness.";
  String text3 =
      "Add the beef strips to a large plastic bag and pour in 1 tablespoon of the cornstarch and the salt. Shake the bag to mix the ingredients until the beef is well coated.";
  String text4 =
      "Heat the sesame oil in a large skillet or wok over medium-high heat. Add the beef, and stir-fry for about 4 minutes, until it is no longer pink. Remove the beef from the pan, place it in a bowl, and set aside.";
  String text5 = "Enjoy";
  late final height1;
  late final height2;
  late final height3;
  late final height4;

  @override
  Widget build(BuildContext context) {
    return CustomStepper(
      steps: [
        CustomStep(
          title: _buildTitle(text1, "assets/images/png/temp/food_category.png"),
          selectedIndecator: _buildSelectedIndicator(0),
          height: height1,
        ),
        CustomStep(
          title: _buildTitle(text2, "assets/images/png/temp/food_category.png"),
          selectedIndecator: _buildSelectedIndicator(1),
          height: height2,
        ),
        CustomStep(
          title: _buildTitle(text3, "assets/images/png/temp/food_category.png"),
          selectedIndecator: _buildSelectedIndicator(2),
          height: height3,
        ),
        CustomStep(
          title: _buildTitle(text4, "assets/images/png/temp/food_category.png"),
          selectedIndecator: _buildSelectedIndicator(3),
          height: height4,
        ),
        CustomStep(
          title: _buildTitle(text5, null),
          selectedIndecator: _buildSelectedIndicator(4),
          height: indecatorSize,
        ),
      ],
      selectedLineColor: AppColors.accentColorLight,
      animationDuration: const Duration(
        milliseconds: 0,
      ),
      currentStep: 4,
    );
  }

  Widget _buildTitle(String title, String? image) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.vGap5,
        Text(
          title,
          style: textStyle,
        ),
        if (image != null)
          SizedBox(
            height: space,
          ),
        if (image != null) _buildImage(image),
      ],
    );
  }

  Widget _buildImage(String image) {
    return SizedBox(
        height: imageHeight,
        width: 1.sw,
        child: Image.asset(
          image,
          fit: BoxFit.cover,
        ));
    // return Expanded(
    //   child: SizedBox(
    //       height: imageHeight,
    //       child: Image.asset(
    //         image,
    //         fit: BoxFit.cover,
    //       )),
    // );
  }

  Widget _buildSelectedIndicator(int index) {
    return ClipOval(
      child: Container(
        height: indecatorSize,
        width: indecatorSize,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.mansourDarkGreenColor,
        ),
        child: Center(
            child: Text(
          "${index + 1}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 35.sp,
          ),
        )),
      ),
    );
  }

  /// Methods
  double getHeight(String text) {
    return textSize(
          text,
          textStyle,
          maxWidth: maxWidth,
        ).height +
        imageHeight +
        70.h;
  }
}
