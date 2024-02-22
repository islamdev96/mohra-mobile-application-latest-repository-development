import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/mylife/domain/entity/task_entity.dart';
import 'package:starter_application/features/mylife/presentation/logic/date_time_helper.dart';
import 'package:starter_application/features/mylife/presentation/state_m/cubit/mylife_cubit.dart';
import 'package:starter_application/features/mylife/presentation/state_m/provider/todo_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:table_calendar/table_calendar.dart';

class TodoScreenContent extends StatefulWidget {
  @override
  State<TodoScreenContent> createState() => _TodoScreenContentState();
}

class _TodoScreenContentState extends State<TodoScreenContent> {
  late TodoScreenNotifier sn;
  EdgeInsets padding = EdgeInsets.symmetric(horizontal: 60.w, vertical: 40.h);
  late TextEditingController _eventController;
  late Map<DateTime, List<dynamic>> _events;

  // CalendarController _controller;

  // CalendarController _calendarController;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<TodoScreenNotifier>(context);
    sn.context = context;
    return BlocConsumer<MylifeCubit, MylifeState>(
      bloc: sn.myLifeCubit,
      builder: (context, state) {
        return state.maybeMap(
          orElse: ()=> const ScreenNotImplementedError(),
          storyLoaded: (s) => const ScreenNotImplementedError(),
          checkDreamSuccess: (s) => const ScreenNotImplementedError(),
          appointmentLoadedPerDayState: (s) => const ScreenNotImplementedError(),
          deleteDreamSuccess: (s) => const ScreenNotImplementedError(),
          appointmentLoadedState: (s) => const ScreenNotImplementedError(),
          createDream: (s) => const ScreenNotImplementedError(),
          dreamListLoaded: (s) => const ScreenNotImplementedError(),
          dreamCreated: (s) => const ScreenNotImplementedError(),
          mylifeInitState: (s) => WaitingWidget(),
          mylifeLoadingState: (s) => WaitingWidget(),
          taskLoadedSuccess: (s) => _buildScreen(),
          createAppointmentSuccess: (s) => const ScreenNotImplementedError(),
          clientLoadedState: (s) => const ScreenNotImplementedError(),
          imageUploaded: (s) => const ScreenNotImplementedError(),
          positiveCreated: (s) => const ScreenNotImplementedError(),
          mylifeErrorState: (s) => ErrorScreenWidget(
            error: s.error,
            callback: s.callback,
          ),
          createTaskSuccess: (s) => _buildScreen(),
          checkTaskSuccess: (CheckTaskSuccess value) => _buildScreen(),
          positivesListLoaded: (s) => const ScreenNotImplementedError(),
          storiesLoadedState: (s) => const ScreenNotImplementedError(),
          qouteLoadedSuccess: (s) => const ScreenNotImplementedError(),
          deleteItemSuccess: (s) => const ScreenNotImplementedError(),
          taskPerDayLoadedSuccess:(s) => _buildScreen(),
        );
      },
      listener: (context, state) {
        if (state is TaskLoadedSuccess) {
          sn.tasksLoadSuccess(state.taskEntity.items!, state.taskEntity);
        }
        if (state is CreateTaskSuccess) {
          sn.addedTaskSuccess(state.taskEntity);
        }
        if (state is DeleteItemSuccess) {
         sn.deletedTaskDone();
        }
        if(state is TaskPerDayLoadedSuccess){
          sn.tasksPerDayLoadSuccess(state.taskEntity);
        }
      },
    );
  }

  _buildScreen() {
    return Container(
      width: 1.sw,
      height: 1.sh,
      child: Stack(
        children: [
          SingleChildScrollView(
              child: Column(
            children: [_buildHeader(), _buildContent()],
          )),
          PositionedDirectional(
              bottom: 50.h,
              end: AppConfig().isLTR ? 40.w : null,
              start: AppConfig().isLTR ? null : 40.w ,
              child: Container(
                width: 120.h,
                height: 120.h,
                decoration: const BoxDecoration(
                    color: AppColors.primaryColorLight, shape: BoxShape.circle),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      sn.isOneSelect
                          ? sn.onCheck()
                          : sn.onAddTap(sn.selectedDay);
                    },
                    icon: Icon(
                      sn.isOneSelect ? Icons.check : Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  _buildHeader() {
    return _buildTableCalendar();
  }

  _buildContent() {
    return Container(
      width: 1.sw,
      color: AppColors.mansourLightGreyColor_6,
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateTimeHelper.getToDoListTitle(sn.selectedDay),
              style: TextStyle(
                  fontSize: 60.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Gaps.vGap24,
            Text(
              "${sn.task.achievedTasksCount} ${Translation.current.of_trs} ${sn.task.totalTasksCount} ${Translation.current.todo_list}",
              style: TextStyle(
                  fontSize: 40.sp,
                  color: AppColors.mansourWhiteBackgrounColor_6),
            ),
            Gaps.vGap64,
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _buildTodoWidget(
                  id: sn.tasks[index].id!,
                  date: DateFormat("yyyy-MM-dd").format(DateTime.parse(sn.tasks[index].date!)),
                  title: sn.tasks[index].title!,
                  color: sn.tasks[index].priority!,
                  index: index,
                  checked: sn.tasks[index].isAchieved,
                  isSelected: sn.tasks[index].isSelected,
                );
              },
              separatorBuilder: (context, index) {
                return Gaps.vGap32;
              },
              itemCount: sn.tasks.length,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableCalendar() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          TableCalendar(
            currentDay: sn.selectedDay,
            headerVisible: true,

            headerStyle: const HeaderStyle(
                formatButtonVisible: false, titleCentered: true),
            pageAnimationEnabled: true,
            calendarFormat:
                sn.tableIsExpanded ? CalendarFormat.month : CalendarFormat.week,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: sn.selectedDay,
            eventLoader: sn.getEventsForDay,
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, List<TaskItemEntity> events) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: events
                      .map((e) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Container(
                              height: 9,
                              width: 9,
                              decoration: BoxDecoration(
                                  color: sn.getColorPriority(e.priority!),
                                  shape: BoxShape.circle),
                            ),
                          ))
                      .toList(),
                );
              },

            ),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                sn.selectedDay = selectedDay;
                sn.getTaskByDay(sn.selectedDay);
                // print(sn.selectedDay.isUtc);
                print(selectedDay);
              });
            },
            daysOfWeekHeight: 100.h,
            weekendDays: const [DateTime.friday, DateTime.saturday],
            startingDayOfWeek: StartingDayOfWeek.sunday,
            calendarStyle: CalendarStyle(
              outsideDaysVisible: true,
              cellMargin:
                  EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              todayDecoration: BoxDecoration(
                  color: AppColors.primaryColorLight,
                  borderRadius: BorderRadius.circular(45.r)),
            ),
          ),
          InkWell(
            onTap: () {
              sn.tableIsExpanded = !sn.tableIsExpanded;
            },
            child: Container(
              width: 1.sw,
              height: 40.h,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        color: AppColors.mansourLightGreyColor_12,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Gaps.vGap32,
        ],
      ),
    );
  }

  _buildTodoWidget(
      {required bool checked,
      required int id,
      required String title,
      required String date,
      required int index,
      required bool isSelected,
      required int color}) {
    return InkWell(
      onTap: () {
        sn.onTab(index);
      },
      child: Slidable(
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.8.w,
          children: [
            SlidableAction(
              onPressed: (context) {
                sn.deleteTask(id);
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          width: 1.sw,
          height: 200.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.r), color: Colors.white),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  VerticalDivider(
                    color: sn.getColorPriority(color),
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Gaps.hGap32,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          decoration: checked
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: checked
                              ? AppColors.text_gray
                              : AppColors.black_text,
                          fontWeight: FontWeight.bold,
                          fontSize: 45.sp,
                        ),
                      ),
                      Gaps.vGap12,
                      Text(
                        date,
                        style: TextStyle(
                          color: AppColors.mansourNotSelectedBorderColor,
                          fontSize: 40.sp,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60.h,
                      width: 60.h,
                      child: SvgPicture.asset(
                        isSelected
                            ? AppConstants.SVG_CHECKMARK_CIRCLE_FILL
                            : "assets/images/svg/ovalCopy.svg",
                        color: isSelected
                            ? AppColors.primaryColorLight
                            : AppColors.text_gray,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
