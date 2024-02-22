import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_error_snackbar.dart';
import 'package:starter_application/features/mylife/presentation/logic/date_time_helper.dart';
import 'package:starter_application/generated/l10n.dart';

typedef OnCreate = void Function(
    String title, String fromHour, String toHour, int priority);

void showAddDreamBottomSheet({
  required BuildContext context,
  required VoidCallback onNav,
  required OnCreate OnAdd,
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
              onPress: onNav,
              OnAddToDoTap: (title, fromHour, toHour, priority) {
                OnAdd(title, fromHour, toHour, priority);
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
  final OnCreate OnAddToDoTap;

  const MyLifeBottomSheet(
      {Key? key, required this.onPress, required this.OnAddToDoTap})
      : super(key: key);

  @override
  State<MyLifeBottomSheet> createState() => _MyLifeBottomSheetState();
}

class _MyLifeBottomSheetState extends State<MyLifeBottomSheet> {
  double firstHeight = 0.3.sh;
  double secHeight = 0.7.sh;
  bool isTitleChange = false;
  bool isTextChange = false;
  bool isDate = false;
  bool isSelectDate = false;
  bool isSelectTimeTo = false;
  bool isSelectPriority = false;
  TextEditingController taskName = TextEditingController();
  DateTime tempPickedDateFrom = DateTime.now();
  DateTime? tempPickedDateTo;
  Priority? priority;
  late int selectedPriority;
  List<Priority>? priorities = [
    Priority(name: Translation.current.normal, color: AppColors.mansourDarkBlueColor5),
    Priority(name: Translation.current.important, color: AppColors.mansourYellow2),
    Priority(name: Translation.current.very_important, color: AppColors.redColor),

  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isDate ? secHeight : firstHeight,
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
                        Translation.current.set_time_and_date,
                        style: TextStyle(
                            fontSize: 43.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      IconButton(
                        onPressed: () {

                            setState(() {
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
                        isSelectTimeTo = false;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: 30.w, left: 30.w, top: 100.h, bottom: 40.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '',
                                style: TextStyle(
                                    fontSize: 40.sp,
                                    color: isSelectTimeTo
                                        ? Colors.grey
                                        : AppColors.primaryColorLight),
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${tempPickedDateFrom.day == DateTime.now().day ? "${Translation.current.today} , " : "${DateFormat("EEEE").format(tempPickedDateFrom)} , "}",
                                        style: DateStyle2(),
                                      ),
                                      Text(
                                          DateTimeHelper.dateTo12Format(tempPickedDateFrom),
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
               /*   InkWell(
                    onTap: () {
                      setState(() {
                        isSelectTimeTo = true;
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
                                Translation.of(context).to,
                                style: TextStyle(
                                    fontSize: 40.sp,
                                    color: !isSelectTimeTo
                                        ? Colors.grey
                                        : AppColors.primaryColorLight),
                              ),
                              Row(
                                children: [
                                  if (tempPickedDateTo != null)
                                    Row(
                                      children: [
                                        Text(
                                          "${tempPickedDateTo!.day == DateTime.now().day ? "${Translation.current.today}," : "${DateFormat("EEEE").format(tempPickedDateTo!)},"}",
                                          style: DateStyle2(),
                                        ),
                                        Text(
                                            " ${tempPickedDateTo!.hour} : ${tempPickedDateTo!.minute}",
                                            style: DateStyle2()),
                                        Text(
                                            " ${tempPickedDateTo!.hour > 12 ? "${Translation.current.pm}" : "${Translation.current.am}"}",
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
                  ),*/
                  Expanded(
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.dateAndTime,
                      initialDateTime: tempPickedDateFrom,
                      onDateTimeChanged: (DateTime value) {
                        setState(() {
                          if (isSelectTimeTo) {
                            tempPickedDateTo = value;
                          } else {
                            tempPickedDateFrom = value;
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            )
          : Column(
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
                          hintText: Translation.current.add_a_task,
                          hintStyle: TextStyle(
                              fontSize: 40.sp, color: AppColors.textLight2),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[200]!),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[200]!),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[200]!),
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
                        if (isSelectPriority &&
                            isTitleChange &&
                            isSelectDate
                        ) {

                          widget.OnAddToDoTap(
                              taskName.text,
                              tempPickedDateFrom.toString(),
                              tempPickedDateTo.toString(),
                              selectedPriority);
                        }
                        else{
                          showError();
                        }
                      },
                      child: Container(
                        width: 60.h,
                        height: 60.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: isTitleChange
                                ? AppColors.primaryColorLight
                                : AppColors.dark_text_gray),
                        child: const Center(
                          child: Icon(
                            Icons.add,
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 100.w, vertical: 30.h),
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
                                  borderRadius: BorderRadius.circular(20.r),
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
                                    "${tempPickedDateFrom.day == DateTime.now().day ? "${Translation.current.today}," : "${DateFormat("EEEE").format(tempPickedDateFrom)},"}",
                                    style: DateStyle(),
                                  ),
                                  Text(
                                      DateTimeHelper.dateTo12Format(tempPickedDateFrom),
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
                                tempPickedDateTo = null;
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
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.w, vertical: 30.h),
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
                                  borderRadius: BorderRadius.circular(20.r),
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
                                Translation.current.date_time,
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
                                  borderRadius: BorderRadius.circular(20.r),
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
                               Translation.current.priority,
                                style: TextStyle(
                                    fontSize: 40.sp,
                                    color: AppColors.textLight2),
                              ),
                            ],
                          ),
                          itemBuilder: (context) {
                            return List.generate(priorities!.length, (index) {
                              return PopupMenuItem(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 30.h,
                                      height: 30.h,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: priorities![index].color),
                                    ),
                                    Gaps.hGap64,
                                    Text(
                                      priorities![index].name,
                                      style: TextStyle(
                                          fontSize: 45.sp, color: Colors.black),
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
                      if (isSelectPriority)
                        Container(
                          width: 0.7.sw,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90.r),
                              color: priority!.color),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 3.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 50.h,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        "assets/images/svg/Sort3.svg",
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                  Gaps.hGap64,
                                  Text(
                                    priority!.name + "  ${Translation.current.priority}",
                                    style: TextStyle(
                                        fontSize: 35.sp, color: Colors.white),
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
                    ],
                  ),
                )
              ],
            ),
    );
  }
  showError(){
    if(!isTitleChange){
      showErrorSnackBar(
        message: 'please write a title',
      );
    }
    else if(!isSelectDate){
      showErrorSnackBar(
        message: 'please select a date',
      );
    }
    else if(!isSelectPriority){
      showErrorSnackBar(
        message: 'please select a Priority',
      );
    }
    else{
      showErrorSnackBar(
        message: 'unknown error, try agian later',
      );
    }
  }
}

TextStyle DateStyle() {
  return TextStyle(color: Colors.grey, fontSize: 35.sp);
}

TextStyle DateStyle2() {
  return TextStyle(
      color: Colors.black, fontSize: 45.sp, fontWeight: FontWeight.bold);
}

class Priority {
  final String name;
  final Color color;

  Priority({required this.name, required this.color});
}
