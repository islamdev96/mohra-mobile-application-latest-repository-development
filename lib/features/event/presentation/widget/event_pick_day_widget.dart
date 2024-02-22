import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/features/event/domain/entity/event_entity.dart';
import 'package:starter_application/features/mylife/presentation/logic/date_time_helper.dart';
import 'package:starter_application/generated/l10n.dart';

import 'event_title_widget.dart';

class EventPickDayWidget extends StatefulWidget {
  final EventEntity eventModel;
  final Function(DateTime) onDatePicked;

  EventPickDayWidget(
      {Key? key, required this.eventModel, required this.onDatePicked})
      : super(key: key);

  @override
  State<EventPickDayWidget> createState() => _EventPickDayWidgetState();
}

class _EventPickDayWidgetState extends State<EventPickDayWidget> {
  late DateTime _pickedDay;
  List<DateTime> _days = [];

  @override
  void initState() {
    super.initState();

    _calculateDays(
        from: widget.eventModel.fromDate!,
        to: widget.eventModel.toDate!,
        schedules: widget.eventModel.schedules);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EventTitleWidget(
            title: widget.eventModel.fromDate!.isAfter(DateTime.now())
                ? Translation.of(context).Book_tickets_in_advance
                : Translation.of(context).pick_day,
            textColor: AppColors.black_text,
            padding: EdgeInsets.only(bottom: 20.h),
          ),
          Text(
            Translation.of(context).when_you_come_at_event,
            style: const TextStyle(
                color: AppColors.accentColorLight,
                overflow: TextOverflow.ellipsis),
            maxLines: 2,
            textAlign: TextAlign.start,
          ),
          _buildDaysList(),
          // DateTimeHelper.eventDate(pickedDay)
          Text(
            DateTimeHelper.eventDate(pickedDay) +
                '  ' +
                '  |  ' +
                DateTimeHelper.dateTo12Format(
                    (widget.eventModel.schedules ?? []).length > 0
                        ? DateTime.tryParse(
                                widget.eventModel.schedules!.first.fromHour!)!
                            .toLocal()
                        : widget.eventModel.fromHour!.toLocal()) +
                ' - ' +
                DateTimeHelper.dateTo12Format(
                    (widget.eventModel.schedules ?? []).length >
                            0
                        ? DateTime.tryParse(
                                widget.eventModel.schedules!.first.toHour!)!
                            .toLocal()
                        : widget.eventModel.toHour!.toLocal()),
            style: const TextStyle(
                color: AppColors.accentColorLight,
                overflow: TextOverflow.ellipsis),
            maxLines: 2,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  Widget _buildDaysList() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.h),
      child: SizedBox(
        height: 210.w,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  setState(() {
                    pickedDay = _days.elementAt(index);
                  });
                },
                child: _buildDayItemWidget(
                  dateTime: _days.elementAt(index),
                  picked: pickedDay == _days.elementAt(index),
                ));
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 40.w,
            );
          },
          itemCount: _days.length,
        ),
      ),
    );
  }

  Widget _buildDayItemWidget(
      {required DateTime dateTime, required bool picked}) {
    return Container(
      width: 210.w,
      decoration: BoxDecoration(
          color: picked
              ? AppColors.mansourDarkPurple
              : AppColors.mansourLightGreyColor,
          borderRadius: BorderRadius.circular(20.r)),
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            DateFormat('EEE').format(dateTime),
            style: TextStyle(
              color: picked ? AppColors.white_text : AppColors.accentColorLight,
            ),
          ),
          const Spacer(),
          Text(
            dateTime.day.toString(),
            style: TextStyle(
                color: picked ? AppColors.white_text : AppColors.black_text,
                fontSize: 60.sp,
                fontWeight: FontWeight.bold),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  void _calculateDays(
      {required DateTime from,
      required DateTime to,
      List<SchedulesEntity>? schedules}) {
    if ((schedules ?? []).isNotEmpty) {
      DateTime now = DateTime.now();
      (schedules ?? []).forEach((element) {
        DateTime dateTime = DateTime.parse(element.startDate!);
        if (!dateTime.isBefore(now)) {
          if (dateTime.day == now.day) {
            DateTime fromHour = DateTime.parse(element.fromHour!);
            if (fromHour.hour >= now.hour) {
              _days.add(DateTime.parse(element.startDate!));
              // pickedDay = DateTime.parse(element.startDate!);
            }
          } else {
            // pickedDay = DateTime.parse(element.startDate!);
            _days.add(DateTime.parse(element.startDate!));
          }
        } else if (dateTime.month == now.month &&
            dateTime.day == now.day &&
            dateTime.year == now.year) {
          DateTime fromHour = DateTime.parse(element.fromHour!);
          if (fromHour.hour >= now.hour) {
            _days.add(DateTime.parse(element.startDate!));
            // pickedDay = DateTime.parse(element.startDate!);
          }
        }
      });
      setState(() {});
    } else {
      DateTime _from = from.isAfter(DateTime.now()) ? from : DateTime.now();
      DateTime fromDate = DateTime(
        _from.year,
        _from.month,
        _from.day,
      );
      int daysCount = ((to.toLocal()).difference(fromDate).inDays).round();
      for (int i = 0; i <= daysCount; i++)
        _days.add(fromDate.add(Duration(days: i)));
    }

    for (int i = 0; i < _days.length; i++) {
      if (_days[i].isAfter(to)) {
        _days.remove(_days[i]);
      }
    }
    if (_days.length > 0) pickedDay = _days.first;
    setState(() {});
  }

  DateTime get pickedDay => _pickedDay;

  set pickedDay(DateTime value) {
    _pickedDay = value;
    widget.onDatePicked(value);
  }
}

//todo refactoring temp
class DayModel {
  int id;
  String day;
  String dayNumber;

  DayModel({required this.id, required this.dayNumber, required this.day});
}
