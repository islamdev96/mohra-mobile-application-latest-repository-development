import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/features/health/presentation/widget/health_amount_unit_picker.dart';

class FoodInfo extends StatelessWidget {
  final bool isTrackWalletOn;
  final void Function(bool value) onTrackWalletSwitchChange;
  final VoidCallback onEatTap;
  FoodInfo({
    Key? key,
    required this.isTrackWalletOn,
    required this.onTrackWalletSwitchChange,
    required this.onEatTap,
  }) : super(key: key);

  final divider = Divider(
    height: 150.h,
    thickness: 1,
    color: AppColors.accentColorLight,
  );
  final titleStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 50.sp,
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAboutFood(),
        divider,
        _buildNutritionsInfo(),
        divider,
        _buildTrackInWallet(),
        divider,
        _buildEatButton(),
      ],
    );
  }

  /// Widgets
  Widget _buildAboutFood() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "About the food",
          style: titleStyle,
        ),
        Gaps.vGap32,
        Text(
          "This healthy beef and broccoli stir-fry recipe is quick-and-easy to prepare, and so low in calories compared to its take-out counterpart that it will probably become one of your favorite meals.",
          style: TextStyle(
            color: AppColors.accentColorLight,
            fontSize: 37.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildNutritionsInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Nutritions Info",
          style: titleStyle,
        ),
        Gaps.vGap32,
        _buildNutritionsCircularIndecatorsRow(),
        divider,
        _buildNutritionsValues(),
      ],
    );
  }

  Widget _buildNutritionsCircularIndecatorsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCircularIndecator(
          title: "CALORIES",
          value: 398,
          totalValue: 2000,
          color: AppColors.mansourLightGreenColor,
          showPercent: false,
        ),
        _buildCircularIndecator(
          title: "CARBS",
          value: 398,
          totalValue: 660,
          color: AppColors.mansourPurple,
        ),
        _buildCircularIndecator(
          title: "PROTEIN",
          value: 398,
          totalValue: 3000,
          color: AppColors.mansourLightBlueColor_4,
        ),
        _buildCircularIndecator(
          title: "FAT",
          value: 398,
          totalValue: 1100,
          color: AppColors.mansourLightRed2,
        ),
      ],
    );
  }

  Widget _buildCircularIndecator({
    required String title,
    required int value,
    required int totalValue,
    required Color color,
    bool showPercent = true,
  }) {
    double percent = value / totalValue;
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 230.h,
          animation: true,
          percent: percent,
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: color,
          backgroundColor: AppColors.mansourLightGreyColor_9,
          center: Text(
            "${showPercent ? "${(percent * 100).round()}%" : value}",
            style: TextStyle(
              color: AppColors.accentColorLight,
              fontSize: 45.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Gaps.vGap32,
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 40.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildNutritionsValues() {
    return Column(
      children: [
        _buildNutritionItem(
          name: "Carbs",
          value: 31,
          color: AppColors.mansourPurple,
          fontWeight: FontWeight.bold,
        ),
        _buildNutritionItem(
          name: "Fiber",
          value: 11,
        ),
        _buildNutritionItem(
          name: "Sugar",
          value: 20,
        ),
        _buildNutritionItem(
          name: "Proteins",
          value: 1.7,
          color: AppColors.mansourLightBlueColor_4,
          fontWeight: FontWeight.bold,
        ),
        _buildNutritionItem(
          name: "Fat",
          value: 0.8,
          color: AppColors.mansourLightRed2,
          fontWeight: FontWeight.bold,
        ),
        _buildNutritionItem(
          name: "Saturated fat",
          value: 0.2,
        ),
        _buildNutritionItem(
          name: "Unsaturated Fat",
          value: 0.4,
        ),
        _buildNutritionItem(
          name: "Other",
          value: 5,
          fontWeight: FontWeight.bold,
        ),
        _buildNutritionItem(
          name: "Cholesterol",
          value: 0.2,
        ),
        _buildNutritionItem(
          name: "Sodium",
          value: 0.4,
        ),
        _buildNutritionItem(
          name: "Potasium",
          value: 0.4,
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }

  Widget _buildNutritionItem({
    required String name,
    required num value,
    Color? color,
    FontWeight? fontWeight,
    EdgeInsets? padding,
  }) {
    return Padding(
      padding: padding ??
          EdgeInsets.only(
            bottom: 32.h,
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
              color: color ?? Colors.black,
              fontSize: 45.sp,
              fontWeight: fontWeight,
            ),
          ),
          Text(
            "$value g",
            style: TextStyle(
              color: color ?? Colors.black,
              fontSize: 45.sp,
              fontWeight: fontWeight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackInWallet() {
    return Column(
      children: [
        _buildTrackInWalletRow(),
        if (isTrackWalletOn)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.vGap96,
              Text(
                "Price",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 50.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.vGap32,
              HealthAmountUnitPicker(
                units: [
                  "USD",
                  "SR",
                  "SP",
                ],
                hint: "currency",
                valueFlex: 7,
                unitFlex: 4,
              ),
              Gaps.vGap64,
              Text(
                "Payment",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 50.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.vGap32,
              CustomListTile(
                onTap: () {},
                padding: EdgeInsets.all(
                  40.h,
                ),
                backgroundColor: AppColors.mansourLightGreyColor_4,
                borderRadius: BorderRadius.circular(
                  30.r,
                ),
                leadingFlex: 1,
                leading: SizedBox(
                  height: 90.h,
                  width: 90.h,
                  child: SvgPicture.asset(
                    AppConstants.SVG_MY_WALLET,
                    color: AppColors.primaryColorLight,
                  ),
                ),
                title: Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: 50.w,
                  ),
                  child: Text(
                    "Pay With My Wallet",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 45.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildTrackInWalletRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Track In Wallet ?",
          style: TextStyle(
            color: Colors.black,
            fontSize: 50.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        FlutterSwitch(
          height: 80.h,
          width: 150.w,
          value: isTrackWalletOn,
          onToggle: onTrackWalletSwitchChange,
          activeColor: AppColors.mansourLightGreenColor,
          inactiveColor: AppColors.mansourLightGreyColor_3,
          toggleColor: Colors.white,
        ),
      ],
    );
  }

  Widget _buildEatButton() {
    return CustomMansourButton(
      titleText: "Eat This",
      textColor: Colors.white,
      backgroundColor: AppColors.mansourDarkGreenColor2,
      titleFontWeight: FontWeight.bold,
      onPressed: onEatTap,
      height: 150.h,
    );
  }
}
