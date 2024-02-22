import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/features/personality/presentation/state_m/provider/check_personality_screen_notifier.dart';
import 'package:starter_application/features/personality/presentation/widget/personality_question_choice_card.dart';
import 'package:starter_application/main.dart';

class PersonalityQuestionGridView extends StatelessWidget {
  final String title;
  final List<PersonalityChoice> choices;
  final EdgeInsets? padding;
  final Function(int index)? onItemSelected;
  final double ratio;
  final int? currentSelectedIndex;
  final bool? shrinkWrap;
  const PersonalityQuestionGridView({
    Key? key,
    required this.choices,
    required this.title,
    required this.ratio,
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
        _buildTitle(),
        Gaps.vGap50,
        GridView.builder(
          padding: padding,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: choices.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: ratio,
            crossAxisSpacing: 50.w,
            mainAxisSpacing: 50.w,
          ),
          itemBuilder: (BuildContext context, int index) {
            final choice = choices[index];
            return PersonalityQuestionChoiceCard(
              image: choice.image,
              name: !isArabic? choice.enContent : choice.arContent,
              isSelected: index == currentSelectedIndex,
              onTap: () {
                onItemSelected?.call(index);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      title,
      style: TextStyle(
        fontSize: 50.sp,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
