import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/mansour/info_widget.dart';
import 'package:starter_application/features/health/presentation/widget/health_dropdown.dart';
import 'package:starter_application/generated/l10n.dart';

class GoalSection extends StatelessWidget {
  final double selectedWeight;
  final double gainKG;
  final int reachMonth;
  final int reachWeeks;
  final void Function(double weight) onWeightChanged;
  final List<String> goalDifficulties;
  final Function(int?) onDifficaltySelected;
  final bool gainOrLoss;
  const GoalSection({
    Key? key,
    required this.selectedWeight,
    required this.onWeightChanged,
    required this.goalDifficulties,
    required this.onDifficaltySelected,
    required this.reachMonth,
    required this.reachWeeks,
    required this.gainKG,
    required this.gainOrLoss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        Text(
          Translation.current.set_goal,
          style: TextStyle(
            color: Colors.black,
            fontSize: 60.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gaps.vGap32,

        /// Subtitle
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Translation.current.set_target_weight,
              style: TextStyle(
                color: AppColors.accentColorLight,
                fontSize: 40.sp,
              ),
            ),
            Text(
              "${selectedWeight.toStringAsFixed(1)} kg",
              style: TextStyle(
                color: Colors.black,
                fontSize: 60.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Gaps.vGap32,

        /// Target weight slider
        SliderTheme(
          data: SliderThemeData(
            overlayShape: const RoundSliderOverlayShape(
              overlayRadius: 0,
            ),
            trackHeight: 20.h,
            activeTrackColor: AppColors.mansourDarkGreenColor,
            thumbColor: Colors.white,
          ),
          child: Slider(
            min: 10,
            max: 100,
            value: selectedWeight,
            onChanged: onWeightChanged,
          ),
        ),
        Gaps.vGap64,
        Text(
          gainOrLoss
              ? Translation.current.quickly_gain + " $gainKG kg ?"
              : Translation.current.quickly_loss + " $gainKG kg ?",
          style: TextStyle(
            color: AppColors.accentColorLight,
            fontSize: 40.sp,
          ),
        ),
        Gaps.vGap32,

        /// Goal difficulties dropdown
        _buildGoalDifficultiesDropdown(),

        /// Divider
        Divider(
          color: AppColors.accentColorLight.withOpacity(0.19),
          height: 150.h,
          thickness: 1,
        ),
        _buildInfoWidget(),
      ],
    );
  }

  Widget _buildGoalDifficultiesDropdown() {
    return HealthDropdown(
      items: goalDifficulties,
      hint: Translation.current.select_difficulty,
      onChange: onDifficaltySelected,
    );
  }

  Widget _buildInfoWidget() {
    return InfoWidget(
      content:
          "${Translation.current.reach_goal} $reachMonth ${Translation.current.month} $reachWeeks ${Translation.current.week}",
      forgroundColor: AppColors.mansourDarkGreenColor,
      backgroundColor: AppColors.mansourDarkGreenColor,
      backgroundOpacity: 0.06,
      icon: SizedBox(
        height: 60.h,
        width: 60.h,
        child: SvgPicture.asset(
          AppConstants.SVG_INFO2,
        ),
      ),
    );
  }
}
