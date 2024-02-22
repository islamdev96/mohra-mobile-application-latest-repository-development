import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/features/challenge/presentation/widget/custom_stepper.dart';
import 'package:starter_application/generated/l10n.dart';

class ToStayFitStepper extends StatelessWidget {
    final double caloriesBrun;
    final double caloriesEat;
    final double water;
    final double steps;
   ToStayFitStepper({Key? key, required this.caloriesBrun,required this.caloriesEat,required this.water,required this.steps,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomStepper(
      steps: [
        CustomStep(
          title: _buildTitle(Translation.current.eat_stepper_1 + ' ' + '${caloriesEat.toStringAsFixed(0)}' +' ' +Translation.current.eat_stepper_2),
          selectedIndecator: _buildSelectedIndicator(
            AppConstants.SVG_SALAD,
          ),
          height: 200.h,
        ),
        CustomStep(
          title: _buildTitle(Translation.current.drink_stepper_1 + ' ' + '${water}' +' ' +Translation.current.drink_stepper_2),
          selectedIndecator: _buildSelectedIndicator(
            AppConstants.SVG_GLASS_OF_WATER,
          ),
          height: 200.h,
        ),
        CustomStep(
          title: _buildTitle(Translation.current.walk_stepper_1 + ' ' + '${steps.toStringAsFixed(0)}' +' ' +Translation.current.walk_stepper_2),
          selectedIndecator: _buildSelectedIndicator(
            AppConstants.SVG_FOOTPRINT,
          ),
          height: 200.h,
        ),
        CustomStep(
          title: _buildTitle(Translation.current.burn_stepper_1 + ' ' + '${caloriesBrun.toStringAsFixed(0)}' +' ' +Translation.current.burn_stepper_2),
          selectedIndecator: _buildSelectedIndicator(
            AppConstants.SVG_CALORIES,
          ),
          height: 100.h,
        ),
      ],
      selectedLineColor: AppColors.mansourDarkGreenColor,
      animationDuration: const Duration(
        milliseconds: 0,
      ),
      currentStep: 3,
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(
        //Todo Calculate the value that center the indecator with the title
        top: 20.h,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 40.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSelectedIndicator(String icon) {
    return ClipOval(
      child: Container(
        height: 100.h,
        width: 100.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.mansourDarkGreenColor,
            width: 1.5,
          ),
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Center(
          child: SizedBox(
            height: 50.h,
            width: 50.h,
            child: SvgPicture.asset(
              icon,
            ),
          ),
        ),
      ),
    );
  }
}
