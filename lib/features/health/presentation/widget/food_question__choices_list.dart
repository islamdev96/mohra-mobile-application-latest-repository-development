import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/features/health/domain/entity/question_entity.dart';

class FoodQuestionChoicesList extends StatelessWidget {
  final List<ChoiceEntity> choices;
  final EdgeInsets? padding;
  final Function(int index)? onItemSelected;
  final int? currentSelectedIndex;
  final bool? shrinkWrap;
  const FoodQuestionChoicesList({
    Key? key,
    required this.choices,
    this.onItemSelected,
    this.padding,
    this.currentSelectedIndex,
    this.shrinkWrap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.vGap96,
        ListView.separated(
          padding: padding,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: choices.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildChoice(
              index,
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 50.h,
            );
          },
        ),
      ],
    );
  }

  Widget _buildChoice(int index) {
    bool isSelected = index == currentSelectedIndex;
    return CustomListTile(
      leadingFlex: 1,
      leading: SizedBox(
        height: 75.h,
        width: 75.h,
        child: SvgPicture.asset(
          isSelected
              ? AppConstants.SVG_CHECKMARK_CIRCLE_FILL
              : AppConstants.SVG_RADIO_BUTTON_OFF,
          color: isSelected
              ? AppColors.mansourDarkGreenColor
              : AppColors.accentColorLight,
        ),
      ),
      title: Text(
        '${choices[index].content}',
        style: TextStyle(
          color: Colors.black,
          fontSize: 50.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () => onItemSelected?.call(index),
    );
  }
}
