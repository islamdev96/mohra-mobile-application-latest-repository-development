import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/date_utils.dart' as date;
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_error_snackbar.dart';
import 'package:starter_application/core/ui/mansour/search_textfield.dart';
import 'package:starter_application/features/mylife/domain/entity/appointment_entity.dart';
import 'package:starter_application/features/mylife/domain/entity/client_entity.dart';
import 'package:starter_application/generated/l10n.dart';

import 'my_life_todo_bottomsheet.dart';

typedef OnEditAppointment = void Function(
    String title,
    String startDate,
    String endDate,
    String fromHour,
    String toHour,
    int priority,
    int repeat,
    List<int> clientId,
    int reminder,
    bool isAllDays,
    );

void showEditAppointmentBottomSheet({
  required BuildContext context,
  required VoidCallback onNav,
  required OnEditAppointment OnEdit,
  required List<ClientItemEntity> users,
  required AppointmentItemEntity appointmentItemEntity,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return BottomSheet(
        builder: (BuildContext context) {
          return AnimatedPadding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            duration: const Duration(milliseconds: 300),
            child: MyLifeBottomSheet(
              users: users,
              onPress: onNav,
              appointmentItemEntity: appointmentItemEntity,
              onEdit: (title, startDate, endDate, fromHour, toHour, priority,
                  repeat, clientId, reminder, isAllDays) {
                OnEdit(title, startDate, endDate, fromHour, toHour, priority,
                    repeat, clientId, reminder, isAllDays);
              },
            ),
          );
        },
        onClosing: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
              40.r,
            ),
          ),
        ),
        constraints: BoxConstraints(
          maxHeight: 1.sh,
        ),
      );
    },
    isScrollControlled: true,
    isDismissible: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(
          40.r,
        ),
      ),
    ),
    constraints: BoxConstraints(
      maxHeight: 1.sh,
    ),
  );
}

class MyLifeBottomSheet extends StatefulWidget {
  final VoidCallback onPress;
  final OnEditAppointment onEdit;
  final List<ClientItemEntity> users;
  final AppointmentItemEntity appointmentItemEntity;
  const MyLifeBottomSheet(
      {Key? key,
        required this.onPress,
        required this.appointmentItemEntity,
        required this.onEdit,
        required this.users})
      : super(key: key);

  @override
  State<MyLifeBottomSheet> createState() => _MyLifeBottomSheetState();
}

class _MyLifeBottomSheetState extends State<MyLifeBottomSheet> {
  double firstHeight = 0.3.sh;
  double secHeight = 0.7.sh;
  double thirdHeight = 0.90.sh;
  bool isTitleChange = false;
  bool isTextChange = false;
  bool isDate = false;
  bool isAddClient = false;
  bool isSelectDate = false;
  bool isSelectTimeTo = false;
  bool isSelectTimeFrom = false;
  bool isSelectStartDate = false;
  bool isSelectEndDate = false;
  bool isDateType = false;
  bool isSelectPriority = false;
  bool isSelectRepeat = false;
  bool isSelectRemainder = false;
  bool isSelectClient = false;
  TextEditingController taskName = TextEditingController();
  DateTime tempPickedDateFrom = DateTime.now();
  DateTime tempPickedStartDate = DateTime.now();
  DateTime tempPickedEndDate = DateTime.now();
  DateTime tempPickedDateTo = DateTime.now();
  TextEditingController search = TextEditingController();
  Priority? priority;
  Repeat? repeat;
  bool isAllDays = false;
  late int numberOfClients = 0;
  Remainder? remainder;
  late int selectedPriority;
  late int selectedRepeat;
  late int selectedRemainder;
  List<Priority>? priorities = [
    Priority(
        name: Translation.current.normal,
        color: AppColors.mansourDarkBlueColor5),
    Priority(
        name: Translation.current.important, color: AppColors.mansourYellow2),
    Priority(
        name: Translation.current.very_important, color: AppColors.redColor),
  ];
  List<ClientItemEntity> shareList = [];
  List<int> ids = [];
  List<Repeat>? repeats = [
    Repeat(
      name: Translation.current.none,
    ),
    Repeat(name: Translation.current.daily),
    Repeat(
      name: Translation.current.weekly,
    ),
    Repeat(
      name: Translation.current.monthly,
    )
  ];
  List<Remainder>? remainders = [
    Remainder(
      name: "1 ${Translation.current.days}",
    ),
    Remainder(
      name: "1 ${Translation.current.hours}",
    ),
    Remainder(
      name: "15 ${Translation.current.minutes}",
    ),
  ];


  @override
  void initState() {
    selectedRepeat = widget.appointmentItemEntity.repeat!;
    selectedRemainder = widget.appointmentItemEntity.reminder!;
    selectedPriority = widget.appointmentItemEntity.priority!;
   isSelectPriority = true;
   isSelectRepeat = true;
   isSelectRemainder = true;
    priority = priorities![selectedPriority];
    repeat = repeats![selectedRepeat];
    remainder = remainders![selectedRemainder];
    isSelectDate = true;
    isSelectTimeTo = false;
    isSelectTimeFrom = true;
    isSelectStartDate = true;
    isSelectEndDate = true;
    tempPickedStartDate = DateTime.parse(widget.appointmentItemEntity.startDate!);
    tempPickedEndDate = DateTime.parse(widget.appointmentItemEntity.endDate!);
    TimeOfDay from = date.DateUtils.stringToTimeOfDay(widget.appointmentItemEntity.fromHour!);
    TimeOfDay to = date.DateUtils.stringToTimeOfDay(widget.appointmentItemEntity.toHour!);
    tempPickedDateTo = DateTime(1,1,1,to.hour,to.minute);
     tempPickedDateFrom = DateTime(1,1,1,from.hour,from.minute);
    taskName.value = TextEditingValue(text:widget.appointmentItemEntity.title ?? '');


  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isDate
          ? secHeight
          : isAddClient
          ? thirdHeight
          : firstHeight,
      padding: EdgeInsets.only(
        left: 20.h,
        right: 20.h,
        top: 30.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            40.r,
          ),
        ),
      ),
      child: isDate
          ? Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      isDate = false;
                      isSelectDate = false;
                    });
                  },
                  icon: SizedBox(
                    height: 80.h,
                    width: 80.h,
                    child: SvgPicture.asset(
                      AppConstants.SVG_CLOSE,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  Translation.of(context).set_time_and_date,
                  style: TextStyle(
                      fontSize: 43.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                IconButton(
                  onPressed: () {
                    if (tempPickedDateTo != null)
                      setState(() {
                        print('aaaa');
                        isDate = false;
                        isSelectDate = true;
                      });
                  },
                  icon: SizedBox(
                    height: 80.h,
                    width: 80.h,
                    child: SvgPicture.asset(
                      AppConstants.SVG_CHECK_MARK,
                      color: AppColors.primaryColorLight,
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isDateType = false;
                  isSelectTimeTo = false;
                  isSelectTimeFrom = true;
                  isSelectStartDate = false;
                  isSelectEndDate = false;
                });
              },
              child: Padding(
                padding: EdgeInsets.only(
                    right: 30.w, left: 30.w, top: 50.h, bottom: 40.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Translation.of(context).from_time,
                          style: TextStyle(
                              fontSize: 40.sp,
                              color: !isSelectTimeFrom
                                  ? Colors.grey
                                  : AppColors.primaryColorLight),
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                    "${DateFormat("hh:mm a").format(tempPickedDateFrom)}",
                                    style: DateStyle2()),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Gaps.vGap32,
                    Divider(
                        color: isSelectTimeTo
                            ? Colors.grey
                            : AppColors.primaryColorLight)
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isDateType = false;
                  isSelectTimeTo = true;
                  isSelectTimeFrom = false;
                  isSelectStartDate = false;
                  isSelectEndDate = false;
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Translation.of(context).to_time,
                          style: TextStyle(
                              fontSize: 40.sp,
                              color: !isSelectTimeTo
                                  ? Colors.grey
                                  : AppColors.primaryColorLight),
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                    "${DateFormat("hh:mm a").format(tempPickedDateTo)}",
                                    style: DateStyle2()),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    Gaps.vGap32,
                    Divider(
                        color: !isSelectTimeTo
                            ? Colors.grey
                            : AppColors.primaryColorLight)
                  ],
                ),
              ),
            ),
            Expanded(
              child: isDateType
                  ? CupertinoDatePicker(
                key: UniqueKey(),
                mode: CupertinoDatePickerMode.date,
                initialDateTime: isSelectStartDate
                    ? tempPickedStartDate
                    : tempPickedEndDate,
                onDateTimeChanged: (value) {
                  setState(() {
                    if (isSelectTimeTo) {
                      tempPickedDateTo = value;
                    } else if (isSelectTimeFrom) {
                      tempPickedDateFrom = value;
                    } else if (isSelectStartDate) {
                      tempPickedStartDate = value;
                    } else if (isSelectEndDate) {
                      tempPickedEndDate = value;
                    }
                  });
                },
              )
                  : CupertinoDatePicker(
                key: UniqueKey(),
                mode: CupertinoDatePickerMode.time,
                initialDateTime: isSelectTimeFrom
                    ? tempPickedDateFrom
                    : tempPickedDateTo,
                onDateTimeChanged: (value) {
                  setState(() {
                    if (isSelectTimeTo) {
                      tempPickedDateTo = value;
                    } else if (isSelectTimeFrom) {
                      tempPickedDateFrom = value;
                    } else if (isSelectStartDate) {
                      tempPickedStartDate = value;
                    } else if (isSelectEndDate) {
                      tempPickedEndDate = value;
                    }
                  });
                },
              ),
            ),
          ],
        ),
      )
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Visibility(
                  visible: !isTextChange,
                  child: SizedBox(
                    width: 50.h,
                    height: 50.h,
                    child: const VerticalDivider(
                      color: AppColors.primaryColorLight,
                      thickness: 2,
                      width: 2,
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: taskName,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.black_text,
                        fontSize: 45.sp),
                    decoration: InputDecoration(
                      hintText: Translation.of(context).add_an_task,
                      hintStyle: TextStyle(
                          fontSize: 40.sp,
                          color: AppColors.textLight2),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.grey[200]!),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.grey[200]!),
                      ),
                      border: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.grey[200]!),
                      ),
                    ),
                    inputFormatters: [],
                    onChanged: (value) {
                      setState(() {
                        if (taskName.text.isEmpty) {
                          isTitleChange = false;
                          isTextChange = false;
                        } else {
                          isTextChange = true;
                          isTitleChange = true;
                        }
                      });
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    // if (
                    // isSelectDate &&
                    //     isTitleChange ) {

                      if(!isSelectPriority){
                        selectedPriority = 0;
                      }
                      if(!isSelectRepeat){
                        selectedRepeat = 0;
                      }
                      if(!isSelectRemainder){
                        selectedRemainder = 2;
                      }
                      widget.onEdit(
                          taskName.text,
                          tempPickedStartDate.toString(),
                          tempPickedEndDate.toString(),
                          tempPickedDateFrom.toString(),
                          tempPickedDateTo.toString(),
                          selectedPriority,
                          selectedRepeat,
                          ids,
                          selectedRemainder,
                          isAllDays);
                    // }
                    /*else{
                      showError();
                    }*/
                  },
                  child: Container(
                    width: 60.h,
                    height: 60.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: AppColors.primaryColorLight),
                    child: const Center(
                      child: Icon(
                        Icons.done,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gaps.vGap64,
            if (isSelectDate)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: AppColors.mansourLightGreyColor_2),
                  padding: EdgeInsets.symmetric(
                      horizontal: 10.w, vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 60.h,
                            height: 60.h,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(20.r),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/images/svg/Clock2.svg",
                                color: AppColors.primaryColorLight,
                              ),
                            ),
                          ),
                          Gaps.hGap32,
                          Row(
                            children: [
                              Text(
                                " ${DateFormat("EEEE").format(tempPickedStartDate)}, ",
                                style: DateStyle(),
                              ),
                              Text(
                                " ${DateFormat("EEEE").format(tempPickedEndDate)}, ",
                                style: DateStyle(),
                              ),
                              Text(
                                  "${tempPickedDateFrom.hour} : ${tempPickedDateFrom.minute} ${tempPickedDateFrom.hour > 12 ? "PM" : "AM"} - ",
                                  style: DateStyle()),
                              Text(
                                  "${tempPickedDateTo.hour} : ${tempPickedDateTo.minute} ${tempPickedDateTo.hour > 12 ? "PM" : "AM"}",
                                  style: DateStyle()),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isDate = false;
                            isSelectDate = false;
                          });
                        },
                        icon: SizedBox(
                          height: 50.h,
                          width: 50.h,
                          child: SvgPicture.asset(
                            AppConstants.SVG_CLOSE,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (isSelectPriority)
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 40.w, vertical: 30.h),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      if (isSelectPriority)
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(90.r),
                              color: priority!.color),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 3.h),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40.h,
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(20.r),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        "assets/images/svg/Sort3.svg",
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                  Gaps.hGap8,
                                  Text(
                                    priority!.name +
                                        " ${Translation.of(context).priority}",
                                    style: TextStyle(
                                        fontSize: 35.sp,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isSelectPriority = false;
                                  });
                                },
                                icon: SizedBox(
                                  height: 50.h,
                                  width: 50.h,
                                  child: SvgPicture.asset(
                                    AppConstants.SVG_CLOSE,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (isSelectPriority) Gaps.hGap32,
                      if (isSelectRepeat)
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(90.r),
                              color:
                              AppColors.mansourLightGreyColor_2),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.w, vertical: 3.h),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 60.h,
                                    height: 60.h,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(20.r),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        "assets/images/svg/repeat2svg.svg",
                                        color: AppColors
                                            .primaryColorLight,
                                      ),
                                    ),
                                  ),
                                  Gaps.hGap16,
                                  Text(
                                    repeat!.name,
                                    style: DateStyle(),
                                  )
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isSelectRepeat = false;
                                  });
                                },
                                icon: SizedBox(
                                  height: 50.h,
                                  width: 50.h,
                                  child: SvgPicture.asset(
                                    AppConstants.SVG_CLOSE,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            Gaps.vGap32,
            if (isSelectRemainder )
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      /*if (isSelectClient)
                        Row(
                          children: shareList
                              .map((e) => client(
                            e,
                          ))
                              .toList(),
                        ),*/
                      Gaps.hGap32,
                      if (isSelectRemainder)
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(90.r),
                              color:
                              AppColors.mansourLightGreyColor_2),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.w, vertical: 3.h),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 60.h,
                                    height: 60.h,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(20.r),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        "assets/images/svg/reminder.svg",
                                        color: AppColors
                                            .primaryColorLight,
                                      ),
                                    ),
                                  ),
                                  Gaps.hGap16,
                                  Text(
                                    remainder!.name,
                                    style: DateStyle(),
                                  )
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isSelectRemainder = false;
                                  });
                                },
                                icon: SizedBox(
                                  height: 50.h,
                                  width: 50.h,
                                  child: SvgPicture.asset(
                                    AppConstants.SVG_CLOSE,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            if (isSelectRemainder) Gaps.vGap32,
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 0.w, vertical: 40.h),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: !isSelectDate,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isDate = true;
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 50.h,
                              height: 50.h,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(20.r),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/images/svg/Clock2.svg",
                                  color: AppColors.primaryColorLight,
                                ),
                              ),
                            ),
                            Gaps.hGap32,
                            Text(
                              Translation.of(context).Date_and_time,
                              style: TextStyle(
                                  fontSize: 40.sp,
                                  color: AppColors.textLight2),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gaps.hGap64,
                    Visibility(
                      visible: !isSelectPriority,
                      child: PopupMenuButton(
                        child: Row(
                          children: [
                            Container(
                              width: 50.h,
                              height: 50.h,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(20.r),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/images/svg/Sort3.svg",
                                  color: AppColors.primaryColorLight,
                                ),
                              ),
                            ),
                            Gaps.hGap32,
                            Text(
                              Translation.of(context).priority,
                              style: TextStyle(
                                  fontSize: 40.sp,
                                  color: AppColors.textLight2),
                            ),
                          ],
                        ),
                        itemBuilder: (context) {
                          return List.generate(priorities!.length,
                                  (index) {
                                return PopupMenuItem(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 30.h,
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                            priorities![index].color),
                                      ),
                                      Gaps.hGap64,
                                      Text(
                                        priorities![index].name,
                                        style: TextStyle(
                                            fontSize: 45.sp,
                                            color: Colors.black),
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      isSelectPriority = true;
                                      priority = priorities![index];
                                      selectedPriority = index;
                                    });
                                  },
                                );
                              });
                        },
                      ),
                    ),
                    Gaps.hGap64,
                    Visibility(
                      visible: !isSelectRepeat,
                      child: PopupMenuButton(
                        child: Row(
                          children: [
                            Container(
                              width: 50.h,
                              height: 50.h,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(20.r),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/images/svg/repeat2svg.svg",
                                  color: AppColors.primaryColorLight,
                                ),
                              ),
                            ),
                            Gaps.hGap32,
                            Text(
                              Translation.of(context).repeat,
                              style: TextStyle(
                                  fontSize: 40.sp,
                                  color: AppColors.textLight2),
                            ),
                          ],
                        ),
                        itemBuilder: (context) {
                          return List.generate(repeats!.length,
                                  (index) {
                                return PopupMenuItem(
                                  child: Row(
                                    children: [
                                      Text(
                                        repeats![index].name,
                                        style: TextStyle(
                                            fontSize: 45.sp,
                                            color: Colors.black),
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      isSelectRepeat = true;
                                      repeat = repeats![index];
                                      selectedRepeat = index;
                                    });
                                  },
                                );
                              });
                        },
                      ),
                    ),
                   /* Gaps.hGap64,
                    Visibility(
                      visible: !isSelectClient,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isAddClient = true;
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 50.h,
                              height: 50.h,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(20.r),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/images/svg/addUser.svg",
                                  color: AppColors.primaryColorLight,
                                ),
                              ),
                            ),
                            Gaps.hGap32,
                            Text(
                              Translation.of(context).share_with,
                              style: TextStyle(
                                  fontSize: 40.sp,
                                  color: AppColors.textLight2),
                            ),
                          ],
                        ),
                      ),
                    ),*/
                    Gaps.hGap64,
                    Visibility(
                      visible: !isSelectRemainder,
                      child: PopupMenuButton(
                        child: Row(
                          children: [
                            Container(
                              width: 50.h,
                              height: 50.h,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(20.r),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/images/svg/reminder.svg",
                                  color: AppColors.primaryColorLight,
                                ),
                              ),
                            ),
                            Gaps.hGap32,
                            Text(
                              Translation.of(context).reminder,
                              style: TextStyle(
                                  fontSize: 40.sp,
                                  color: AppColors.textLight2),
                            ),
                          ],
                        ),
                        itemBuilder: (context) {
                          return List.generate(remainders!.length,
                                  (index) {
                                return PopupMenuItem(
                                  child: Row(
                                    children: [
                                      Text(
                                        remainders![index].name,
                                        style: TextStyle(
                                            fontSize: 45.sp,
                                            color: Colors.black),
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      isSelectRemainder = true;
                                      remainder = remainders![index];
                                      selectedRemainder = index;
                                    });
                                  },
                                );
                              });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ) ,
    );
  }

  showError(){
    if(
    !isSelectDate
    ){
      showErrorSnackBar(
        message:
        Translation.current.my_life_appointment_date_time_validation,
      );
    }
    else if(!isTitleChange){
      showErrorSnackBar(
        message:
        Translation.current.my_life_appointment_title_validation,
      );
    }
    else{
      showErrorSnackBar(
        message:
        Translation.current.my_life_appointment_unknown_validation,
      );
    }


  }
}

class Repeat {
  final String name;

  Repeat({required this.name});
}

class Remainder {
  final String name;

  Remainder({required this.name});
}
