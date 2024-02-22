import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';

class DaysList extends StatelessWidget {
  final double height;
  final int daysCount;
  final int selectedDay;
  final Color selectedBackgroundColor;
  final Function(int day, int dayIndex) onDayChange;

  DaysList({
    Key? key,
    required this.height,
    required this.selectedDay,
    required this.onDayChange,
    this.selectedBackgroundColor = AppColors.mansourLightGreenColor,
    this.daysCount = 31,
  }) : super(key: key);
  final ItemScrollController _controller = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ScrollablePositionedList.separated(
        padding: AppConstants.screenPadding,
        scrollDirection: Axis.horizontal,
        itemScrollController: _controller,
        initialScrollIndex: currentDayIndex,
        itemBuilder: (context, index) {
          return _buildDay(index);
        },
        separatorBuilder: (context, index) {
          return Gaps.hGap32;
        },
        itemCount: this.daysCount,
        initialAlignment: 0.45,
      ),
    );
  }

  /// Widgets

  Widget _buildDay(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        30.r,
      ),
      child: Container(
        height: height,
        width: height,
        decoration: BoxDecoration(
          color: isSelectedDay(index) ? selectedBackgroundColor : Colors.white,
          borderRadius: BorderRadius.circular(
            30.r,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              _controller.scrollTo(
                index: index,
                duration: const Duration(
                  milliseconds: 300,
                ),
                curve: Curves.easeOut,
                alignment: 0.45,
              );
              onDayChange(days[index],index);
            },
            child: Center(
              child: Text(
                "${days[index]}",
                style: TextStyle(
                  color: !isSelectedDay(index)
                      ? AppColors.mansourLightGreyColor_11
                      : Colors.white,
                  fontSize: 45.sp,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Getters

  int get leftDaysCount => ((daysCount - 1) * 0.5).toInt() + daysCount % 2;
  int get righDaysCount => ((daysCount - 1) * 0.5).toInt();
  List<int> get days => List.generate(daysCount, (index) => _getDay(index));
  int get currentDayIndex => (daysCount ~/ 2);

  /// Methdos
  bool isSelectedDay(int index) {
    return days[index] == selectedDay;
  }

  int _getDay(int index) {
    int diff = index - currentDayIndex;
    late DateTime dayDate;
    dayDate = DateTime.now().add(Duration(days: diff));
    return dayDate.day;
  }
}
