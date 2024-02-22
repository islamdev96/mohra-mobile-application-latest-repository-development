import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/mylife/domain/entity/appointment_entity.dart';
import 'package:starter_application/features/mylife/presentation/logic/date_time_helper.dart';
import 'package:starter_application/features/mylife/presentation/state_m/cubit/mylife_cubit.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/appointment_screen_notifier.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentScreenContent extends StatefulWidget {
  @override
  State<AppointmentScreenContent> createState() =>
      _AppointmentScreenContentState();
}

class _AppointmentScreenContentState extends State<AppointmentScreenContent> {
  late AppointmentScreenNotifier sn;
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
    sn = Provider.of<AppointmentScreenNotifier>(context);
    sn.context = context;
    return BlocConsumer<MylifeCubit, MylifeState>(
      bloc: sn.myLifeCubit,
      builder: (context, state) {
        return state.maybeMap(
          orElse: ()=> const ScreenNotImplementedError(),
          storyLoaded: (s) => const ScreenNotImplementedError(),
          appointmentLoadedState: (s) => _buildScreen(s),
          appointmentLoadedPerDayState:(s) => _buildScreen(s),
          taskPerDayLoadedSuccess: (s) => const ScreenNotImplementedError(),
          createDream: (s) => const ScreenNotImplementedError(),
          checkDreamSuccess: (s)=>const ScreenNotImplementedError(),
          deleteDreamSuccess: (s)=>const ScreenNotImplementedError(),
          dreamListLoaded: (s) => const ScreenNotImplementedError(),
          dreamCreated: (s) => const ScreenNotImplementedError(),
          mylifeInitState: (s) => WaitingWidget(),
          mylifeLoadingState: (s) => WaitingWidget(),
          taskLoadedSuccess: (s) => const ScreenNotImplementedError(),
          createAppointmentSuccess: (s) => _buildScreen(s),
          clientLoadedState: (s) => _buildScreen(s),
          deleteItemSuccess: (s) => const ScreenNotImplementedError(),
          mylifeErrorState: (s) => ErrorScreenWidget(
            error: s.error,
            callback: s.callback,
          ),
          qouteLoadedSuccess: (s) => const ScreenNotImplementedError(),
          storiesLoadedState: (s) => const ScreenNotImplementedError(),
          createTaskSuccess: (s) => const ScreenNotImplementedError(),
          checkTaskSuccess: (s) => _buildScreen(s),
          imageUploaded: (s) => const ScreenNotImplementedError(),
          positivesListLoaded: (s) => const ScreenNotImplementedError(),
          positiveCreated: (s) => const ScreenNotImplementedError(),
          updateAppointmentSuccess:  (s)=> _buildScreen(s),
          updateAppointmentLoading: (s)=> WaitingWidget(),
        );
      },
      listener: (context, state) {
        if (state is ClientLoadedState) {
          sn.getClientsSuccess(state.eventsEntity.items!);
        }
        if (state is CreateAppointmentSuccess) {
          sn.appointmentAddedSuccess(state.appointmentItem);
        }
        if (state is AppointmentLoadedState) sn.loaded(state.eventsEntity);
        if(state is AppointmentLoadedPerDayState){
          sn.onAppointmentPerDateLoaded(state.eventsEntity);
        }
        if (state is DeleteItemSuccess) {
          sn.onDeleteAppointmentDone();
        }
        if(state is UpdateAppointmentSuccess){
          sn.onUpdateSuccess();
        }
      },
    );
  }

  _buildScreen(MylifeState state) {
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
                      sn.isOneSelect ? sn.onCheck() : sn.onAddTap();
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
            Text(
              DateTimeHelper.getAppointmentTitle(sn.selectedDay),
              style: TextStyle(
                  fontSize: 60.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Gaps.vGap24,
            Text(
              "${sn.appointment.doneAppointmentsCount} of ${sn.appointment.totalAppointmentsCount}",
              style: TextStyle(
                  fontSize: 40.sp,
                  color: AppColors.mansourWhiteBackgrounColor_6),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Slidable(
                  startActionPane: ActionPane(
                    motion: const DrawerMotion(),

                    extentRatio: 2.w,
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          sn.deleteAppointment(sn.appointments2[index].id);
                        },
                        flex: 2,
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: Translation.current.delete,
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          sn.updateAppointment(sn.appointments2[index]);
                        },
                        flex: 1,
                        backgroundColor: AppColors.mansourYellow,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: Translation.current.edit,
                      ),
                    ],
                  ),
                  child: appointmentItem(
                      isSelected: sn.appointments2[index].isSelected,
                      check: sn.appointments2[index].isDone!,
                      // image: sn.appointments2[index].image,
                      end: sn.appointments2[index].toHour!,
                      color: sn.appointments2[index].priority!,
                      start: sn.appointments2[index].fromHour!,
                      // persons: sn.appointments[index].persons,
                      title: sn.appointments2[index].title!,
                      index: index),
                );
              },
              separatorBuilder: (context, index) {
                return Gaps.vGap8;
              },
              itemCount: sn.appointments2.length,
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
            eventLoader: sn.getEventsForDay,
            headerStyle: const HeaderStyle(
                formatButtonVisible: false, titleCentered: true),
            pageAnimationEnabled: true,
            calendarFormat:
                sn.tableIsExpanded ? CalendarFormat.month : CalendarFormat.week,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: sn.selectedDay,
            calendarBuilders: CalendarBuilders(
              selectedBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(40.0)),
                  child: Text(
                    date.day.toString(),
                    style: const TextStyle(color: Colors.white),
                  )),
              holidayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
              markerBuilder:
                  (context, day, List<AppointmentItemEntity> events) {
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
                sn.selectedDay = focusedDay; //
                sn.getAppointmentByDay(sn.selectedDay);
                // print(sn.selectedDay.isUtc);
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
                    borderRadius: BorderRadius.circular(45.r))),
          ),
          Gaps.vGap50,
          InkWell(
            onTap: () {
              sn.tableIsExpanded = !sn.tableIsExpanded;
            },
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
          Gaps.vGap32,
        ],
      ),
    );
  }

  Widget appointmentItem({
    required bool check,
    required String start,
    required String end,
    required String title,
    required int color,
    required bool isSelected,
    required int index,
  }) {
    return InkWell(
      onTap: () {
        sn.onTab(index);

      },
      child: Padding(
        padding: EdgeInsets.only(top: 50.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 65.h,
                      width: 65.h,
                      child: check ? SvgPicture.asset(
                        check
                            ? AppConstants.SVG_CHECKMARK_CIRCLE_FILL
                            : AppConstants.SVG_RADIO_BUTTON_OFF,
                        color: check
                            ? AppColors.primaryColorLight
                            : AppColors.mansourWhiteBackgrounColor_6,
                      ): SvgPicture.asset(
                        isSelected
                            ? AppConstants.SVG_CHECKMARK_CIRCLE_FILL
                            : AppConstants.SVG_RADIO_BUTTON_OFF,
                        color: isSelected
                            ? AppColors.primaryColorLight
                            : AppColors.mansourWhiteBackgrounColor_6,
                      ),
                    )
                  ],
                ),
                Gaps.hGap32,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      start,
                      style: TextStyle(
                          fontSize: 40.sp,
                          color: AppColors.mansourWhiteBackgrounColor_6),
                    ),
                    Gaps.vGap8,
                    Text(
                      end,
                      style: TextStyle(
                          fontSize: 40.sp,
                          color: AppColors.mansourWhiteBackgrounColor_6),
                    )
                  ],
                ),
              ],
            ),
            Gaps.hGap64,
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(
                      color: isSelected
                          ? AppColors.primaryColorLight
                          : Colors.transparent),
                  color: sn.getColorPriority(color),
                ),
                child: Padding(
                  padding: padding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gaps.vGap12,
                            Text(
                              title,
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 45.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white),
                            ),
                            Gaps.vGap12,
                            // Text(
                            //   persons,
                            //   style: TextStyle(
                            //       fontSize: 35.sp, color: AppColors.white),
                            // ),
                          ],
                        ),
                      ),
                      // if (image != "")
                      //   Flexible(
                      //     child: ClipOval(
                      //       child: Container(
                      //         height: 100.h,
                      //         width: 100.h,
                      //         decoration: const BoxDecoration(
                      //           shape: BoxShape.circle,
                      //         ),
                      //         child: Image.asset(
                      //           image,
                      //           fit: BoxFit.cover,
                      //         ),
                      //       ),
                      //     ),
                      //   )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
