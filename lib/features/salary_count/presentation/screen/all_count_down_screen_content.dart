import 'dart:io';

import 'package:analog_clock/analog_clock.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/core/ui/widgets/pagination_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/notification/domain/entity/notification_entity.dart';
import 'package:starter_application/features/salary_count/data/model/response/Data.dart';
import 'package:starter_application/features/salary_count/data/model/response/Fractiontime.dart';
import 'package:starter_application/features/salary_count/domain/entity/time_table_list_entity.dart';
import 'package:starter_application/features/salary_count/presentation/state_m/cubit/salary_count_cubit.dart';
import 'package:starter_application/features/salary_count/presentation/widget/countdown_item.dart';
import 'package:starter_application/features/salary_count/presentation/widget/row_item_widget.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/all_count_down_screen_notifier.dart';

class AllCountDownScreenContent extends StatelessWidget {
  late AllCountDownScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<AllCountDownScreenNotifier>(context);
    sn.context = context;
    return ProgressHUD(
      indicatorWidget: Material(
        color: Colors.transparent,
        child: TextWaitingWidget(
          Translation.current.claiming_rewards,
          textColor: Colors.white,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<SalaryCountCubit, SalaryCountState>(
                  bloc: sn.salaryCountCubit,
                  listener: (context, state) {
                    if (state is GetAllTimeTableLoaded) {
                      sn.loading(false);
                      sn.onTimeListLoaded(state.tableListEntity);
                    }
                    if (state is CreateTimeTableLoading) {
                      ProgressHUD.of(context)!.show();
                    }
                    if (state is CreateTimeTableLoaded) {
                      sn.clearData();
                      sn.getAllTimeTable();
                      ProgressHUD.of(context)!.dismiss();
                    }
                    if (state is DeleteTimeTableLoading) {
                      ProgressHUD.of(context)!.show();
                    }
                    if (state is DeleteTimeTableLoaded) {
                      sn.getAllTimeTable();
                      ProgressHUD.of(context)!.dismiss();
                    }
                    if (state is UpdateTimeTableLoading) {
                      ProgressHUD.of(context)!.show();
                    }
                    if (state is UpdateTimeTableLoaded) {
                      sn.clearData();
                      sn.getAllTimeTable();
                      ProgressHUD.of(context)!.dismiss();
                    }
                    if (state is ChangeTimeTableSelectedLoading) {
                      ProgressHUD.of(context)?.show();
                    }
                    if (state is ChangeTimeTableSelectedLoaded) {
                      ProgressHUD.of(context)?.dismiss();
                      sn.getAllTimeTable();
                    }
                    if (state is SalaryCountErrorState) {
                      sn.loading(false);
                    }
                  },
                  builder: (context, state) {
                    return state.maybeMap(
                      salaryCountLoadingState: (s) => Container(
                        height: 200,
                        width: 200,
                        child: WaitingWidget(),
                      ),
                      getAllTimeTableLoaded: (s) => buildList(),
                      createTimeTableLoaded: (s) => buildList(),
                      createTimeTableLoading: (s) => buildList(),
                      deleteTimeTableLoaded: (s) => buildList(),
                      deleteTimeTableLoading: (s) => buildList(),
                      salaryCountErrorState: (s) =>
                          ErrorScreenWidget(error: s.error, callback: () {}),
                      orElse: () => buildList(),
                    );
                  }),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      _showAddEventDialog(context);
                    },
                    child: Image.asset(
                      AppConstants.PLUS_ICON,
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  /* buildList() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key('${sn.timeTableListEntity[index].id}'),
            direction: DismissDirection.startToEnd,
            confirmDismiss: (s) async {
              if (sn.timeTableListEntity[index].clientId != null &&
                  sn.timeTableListEntity[index].clientId ==
                      UserSessionDataModel.userId) {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(Translation.current.confirm),
                      content:  Text(Translation.current.confirm_delete_countdown),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () {
                              sn.deleteTimeTable(
                                  sn.timeTableListEntity[index].id);
                              Navigator.of(context).pop(true);
                            },
                            child: Text(Translation.current.delete)
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(Translation.current.cancel),
                        ),
                      ],
                    );
                  },
                );
              }
              else {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(Translation.current.warning),
                      content: Text(Translation.current.cant_delete_event),
                      actions: [
                        CustomMansourButton(
                          titleText: Translation.current.ok,
                          onPressed: () {
                            Nav.pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: GestureDetector(
              onTap: () {
                if (sn.timeTableListEntity[index].clientId != null &&
                    sn.timeTableListEntity[index].clientId ==
                        UserSessionDataModel.userId) {
                  _showEditEventDialog(context, index);
                }
              },
              child: CountdownItem(
                tableItemEntity: sn.timeTableListEntity[index],
              ),
            ),
          );
        },
        itemCount: sn.timeTableListEntity.length,
      ),
    );
  }*/

  buildList() {
    return sn.isLoading
        ? WaitingWidget()
        : PaginationWidget<TimeTableItemEntity>(
            items: sn.timeTableListEntity,
            getItems: sn.getTimeTableItems,
            onDataFetched: sn.onTimeTablesItemsFetched,
            refreshController: sn.momentsRefreshController,
            footer: ClassicFooter(
              loadingText: "",
              noDataText: Translation.of(getIt<NavigationService>()
                      .getNavigationKey
                      .currentContext!)
                  .noDataRefresher,
              failedText: Translation.of(getIt<NavigationService>()
                      .getNavigationKey
                      .currentContext!)
                  .failedRefresher,
              idleText: "",
              canLoadingText: "",
              /*  loadingIcon: Padding(
                      padding: EdgeInsets.only(
                        bottom: AppConstants.bottomNavigationBarHeight + 300.h,
                      ),
                      child: const CircularProgressIndicator.adaptive(),
                    ), */
              height: AppConstants.bottomNavigationBarHeight + 300.h,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 5.0,
                  ),

                  Stack(
                    children: [
                      AnalogClock(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Colors.transparent),
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.1),
                                offset: Offset(0, 0),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ]),
                        width: 0.75.sw,
                        height: 0.75.sw,
                        isLive: true,
                        useMilitaryTime: true,
                        hourHandColor: Colors.black,
                        minuteHandColor: Colors.black,
                        showSecondHand: true,
                        numberColor: Colors.black87,
                        showNumbers: true,
                        showAllNumbers: false,
                        textScaleFactor: 1,
                        showTicks: true,
                        secondHandColor: AppColors.primaryColorLight,
                        showDigitalClock: false,
                        tickColor: Colors.transparent,
                        datetime: DateTime.now(),
                      ),


                      // Positioned(
                      //   top: 20,
                      //   width: 0.500.sw,
                      //   child: Text(
                      //     "12",
                      //     textAlign: TextAlign.center,
                      //   ),
                      // ),
                      //
                      //
                      // Positioned(
                      //   bottom: 10,
                      //   width: 0.75.sw,
                      //   child: Text(
                      //     "6",
                      //     textAlign: TextAlign.center,
                      //   ),
                      // ),
                      //
                      //
                      // Positioned(
                      //   right: 10,
                      //   bottom: 0.75.sw / 2,
                      //   child: Text(
                      //     "3",
                      //     textAlign: TextAlign.center,
                      //   ),
                      // ),
                      //
                      //
                      // Positioned(
                      //   left: 10,
                      //   bottom: 0.75.sw / 2,
                      //   child: Text(
                      //     "9",
                      //     textAlign: TextAlign.center,
                      //   ),
                      // ),
                    ],
                  ),
                  Gaps.vGap32,
                  Text(
                    Translation.current.swipe_card_to_delete,
                    style: TextStyle(color: AppColors.mansourDarkOrange, fontSize: 50.sp,),
                    textAlign: TextAlign.center,
                  ),
                  DragAndDropLists(
                    disableScrolling: true,
                    lastItemTargetHeight: 0,
                      lastListTargetSize: 0,
                    children: [
                      DragAndDropList(
                        header: Text(''),
                        children: <DragAndDropItem>[
                          for (int i = 0; i < sn.timeTableListEntity.length; i++)
                            DragAndDropItem(child: buildItem(i)),
                        ],
                      )
                    ],
                    onItemReorder:
                        (oldItemIndex, oldListIndex, newItemIndex, newListIndex) {
                      sn.onReorder(oldItemIndex, newItemIndex);
                    },
                    onListReorder: (int oldIndex, int newIndex) {
                      sn.onReorder(oldIndex, newIndex);
                    },
                  ),
                ],
              ),
            ),
          );
  }

  buildItem(int index) {
    return Dismissible(
      key: Key('${sn.timeTableListEntity[index].id}'),
      direction: DismissDirection.startToEnd,
      confirmDismiss: (s) async {
        if (sn.timeTableListEntity[index].clientId != null &&
            sn.timeTableListEntity[index].clientId ==
                UserSessionDataModel.userId) {
          return await showDialog(
            context: sn.context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(Translation.current.confirm),
                content: Text(Translation.current.confirm_delete_countdown),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        sn.deleteTimeTable(sn.timeTableListEntity[index].id);
                        Navigator.of(context).pop(true);
                      },
                      child: Text(Translation.current.delete)),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(Translation.current.cancel),
                  ),
                ],
              );
            },
          );
        } else {
          return await showDialog(
            context: sn.context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(Translation.current.warning),
                content: Text(Translation.current.cant_delete_event),
                actions: [
                  CustomMansourButton(
                    titleText: Translation.current.ok,
                    onPressed: () {
                      Nav.pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      },
      child: GestureDetector(
        onTap: () {
          if (sn.timeTableListEntity[index].clientId != null &&
              sn.timeTableListEntity[index].clientId ==
                  UserSessionDataModel.userId) {
            _showEditEventDialog(sn.context, index);
          }
        },
        child: CountdownItem(
          tableItemEntity: sn.timeTableListEntity[index],
          isBorder: index <= 2,
        ),
      ),
    );
  }

  Future<void> _showAddEventDialog(BuildContext parentContext) async {
    sn.clearData();
    return showDialog<void>(
      context: parentContext,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (ctx, setState) {
          return AlertDialog(
            title: Center(
                child: Text(Translation.current.add_event,
                    style: const TextStyle(
                        color: AppColors.black, fontSize: 20.0))),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.mansourLightGreyCountdown,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        style: const TextStyle(
                            fontSize: 13.0,
                            color: AppColors.mansourDarkBlueColor2),
                        decoration: InputDecoration.collapsed(
                          hintText: Translation.current.event_title_hint,
                        ),
                        controller: sn.titleController,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                  StatefulBuilder(
                    key: UniqueKey(),
                    builder: (ctx, setState) {
                      return InkWell(
                        onTap: () async {
                          if (Platform.isAndroid) {
                            await _selectDate(parentContext);
                          } else {
                            await iosDatePicker(parentContext);
                          }
                          setState(() {
                            print("edited");
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  Translation.current.input_your_date,
                                  style: const TextStyle(
                                    color: AppColors.black,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 4.0),
                                child: RowItemWidget(
                                    v1: sn.dayController.text.isNotEmpty
                                        ? sn.dayController.text.toString()
                                        : "0",
                                    v2: Translation.current.days,
                                    v3: ":",
                                    boxColor:
                                        AppColors.mansourLightGreyCountdown,
                                    textColor: AppColors.black),
                              ),
                              RowItemWidget(
                                  v1: sn.monthController.text.isNotEmpty
                                      ? sn.monthController.text.toString()
                                      : "0",
                                  v2: Translation.current.month,
                                  v3: ":",
                                  boxColor: AppColors.mansourLightGreyCountdown,
                                  textColor: AppColors.black),
                              RowItemWidget(
                                  v1: sn.yearController.text.isNotEmpty
                                      ? sn.yearController.text.toString()
                                      : "0",
                                  v2: Translation.current.year,
                                  v3: "",
                                  boxColor: AppColors.mansourLightGreyCountdown,
                                  textColor: AppColors.black),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  StatefulBuilder(
                      key: UniqueKey(),
                      builder: (ctx, setState) {
                        return InkWell(
                          onTap: () async {
                            if (Platform.isAndroid) {
                              await _selectTime(parentContext);
                            } else {
                              await iosTimePicker(parentContext);
                            }
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    Translation.current.input_your_time,
                                    style: const TextStyle(
                                      color: AppColors.black,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: RowItemWidget(
                                      v1: sn.hourController.text.isNotEmpty
                                          ? sn.hourController.text.toString()
                                          : "0",
                                      v2: Translation.current.hours2,
                                      v3: ":",
                                      boxColor:
                                          AppColors.mansourLightGreyCountdown,
                                      textColor: AppColors.black),
                                ),
                                RowItemWidget(
                                    v1: sn.minutesController.text.isNotEmpty
                                        ? sn.minutesController.text.toString()
                                        : "0",
                                    v2: Translation.current.minutes2,
                                    v3: "",
                                    boxColor:
                                        AppColors.mansourLightGreyCountdown,
                                    textColor: AppColors.black),
                              ],
                            ),
                          ),
                        );
                      }),
                  Row(
                    children: [
                      Text(Translation.current.selected),
                      Checkbox(
                          value: sn.checkBoxValue,
                          onChanged: (v) {
                            setState(() {
                              sn.checkBoxValue = v ?? false;
                            });
                          })
                    ],
                  )
                ],
              ),
            ),
            actions: <Widget>[
              Center(
                child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.mansourLightOrangeCountdown,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        if (sn.yearController.text.isNotEmpty &&
                            sn.monthController.text.isNotEmpty &&
                            sn.dayController.text.isNotEmpty &&
                            sn.hourController.text.isNotEmpty &&
                            sn.minutesController.text.isNotEmpty &&
                            sn.titleController.text.isNotEmpty) {
                          Nav.pop();
                          sn.onAddEventTapped();

                          // Navigator.pop(context);
                        } else {
                          /* if(userId==null){
                      showSnackbar(Translation.current.invalid_user_id,context: context);
                    }else{
                      showSnackbar(Translation.current.all_fields_are_mandatory,context: context);
                    }*/

                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Text(
                          Translation.current.submit,
                          style: const TextStyle(
                              color: AppColors.mansourWhiteBackgrounColor,
                              fontSize: 15.0),
                        ),
                      ),
                    )),
              ),
            ],
          );
        });
      },
    );
  }

  Future<void> _showEditEventDialog(
      BuildContext parentContext, int index) async {
    sn.initEditData(index);
    return showDialog<void>(
      context: parentContext,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (ctx, setState) {
          return AlertDialog(
            title: Center(
                child: Text(Translation.current.edit_event,
                    style: const TextStyle(
                        color: AppColors.black, fontSize: 20.0))),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.mansourLightGreyCountdown,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        style: TextStyle(
                            fontSize: 13.0,
                            color: AppColors.mansourDarkBlueColor2),
                        decoration: InputDecoration.collapsed(
                          hintText: Translation.current.event_title_hint,
                        ),
                        onChanged: (value) {
                          sn.titleController.text = value;
                        },
                        controller: sn.titleController,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                  StatefulBuilder(
                    key: UniqueKey(),
                    builder: (ctx, setState) {
                      return InkWell(
                        onTap: () async {
                          await _selectDate(parentContext);
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  Translation.current.input_your_date,
                                  style: const TextStyle(
                                    color: AppColors.black,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 4.0),
                                child: RowItemWidget(
                                    v1: sn.dayController.text.isNotEmpty
                                        ? sn.dayController.text.toString()
                                        : "0",
                                    v2: Translation.current.days,
                                    v3: ":",
                                    boxColor:
                                        AppColors.mansourLightGreyCountdown,
                                    textColor: AppColors.black),
                              ),
                              RowItemWidget(
                                  v1: sn.monthController.text.isNotEmpty
                                      ? sn.monthController.text.toString()
                                      : "0",
                                  v2: Translation.current.month,
                                  v3: ":",
                                  boxColor: AppColors.mansourLightGreyCountdown,
                                  textColor: AppColors.black),
                              RowItemWidget(
                                  v1: sn.yearController.text.isNotEmpty
                                      ? sn.yearController.text.toString()
                                      : "0",
                                  v2: Translation.current.year,
                                  v3: "",
                                  boxColor: AppColors.mansourLightGreyCountdown,
                                  textColor: AppColors.black)
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  StatefulBuilder(
                    key: UniqueKey(),
                    builder: (ctx, setState) {
                      return InkWell(
                        onTap: () async {
                          await _selectTime(parentContext);
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  Translation.current.input_your_time,
                                  style: const TextStyle(
                                    color: AppColors.black,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: RowItemWidget(
                                    v1: sn.hourController.text.isNotEmpty
                                        ? sn.hourController.text.toString()
                                        : "0",
                                    v2: Translation.current.hours2,
                                    v3: ":",
                                    boxColor:
                                        AppColors.mansourLightGreyCountdown,
                                    textColor: AppColors.black),
                              ),
                              RowItemWidget(
                                  v1: sn.minutesController.text.isNotEmpty
                                      ? sn.minutesController.text.toString()
                                      : "0",
                                  v2: Translation.current.minutes2,
                                  v3: "",
                                  boxColor: AppColors.mansourLightGreyCountdown,
                                  textColor: AppColors.black),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Row(
                    children: [
                      Text(Translation.current.selected),
                      Checkbox(
                          value: sn.checkBoxValue,
                          onChanged: (v) {
                            setState(() {
                              sn.checkBoxValue = v ?? false;
                            });
                          })
                    ],
                  ),
                  Text(Translation.current.order_2),
                  NumberPicker(
                    value: sn.newOrder,
                    minValue: 0,
                    maxValue: 20,
                    axis: Axis.horizontal,
                    textStyle: TextStyle(
                      color: AppColors.black,
                      fontSize: 40.sp,
                    ),
                    // infiniteLoop: false,
                    haptics: true,
                    selectedTextStyle: TextStyle(
                      color: AppColors.mansourDarkOrange,
                      fontSize: 50.sp,
                    ),
                    onChanged: (value) => setState(
                      () {
                        sn.newOrder = value;
                        print(sn.newOrder);
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Center(
                child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.mansourLightOrangeCountdown,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        if (sn.yearController.text.isNotEmpty &&
                            sn.monthController.text.isNotEmpty &&
                            sn.dayController.text.isNotEmpty &&
                            sn.hourController.text.isNotEmpty &&
                            sn.minutesController.text.isNotEmpty &&
                            sn.titleController.text.isNotEmpty) {
                          Nav.pop();
                          sn.editTimeTableTapped(index);

                          // Navigator.pop(context);
                        } else {
                          showSnackbar(Translation.current.all_fields_required,
                              context: context);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Text(
                          Translation.current.submit,
                          style: const TextStyle(
                              color: AppColors.mansourWhiteBackgrounColor,
                              fontSize: 15.0),
                        ),
                      ),
                    )),
              ),
            ],
          );
        });
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: sn.selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));
    if (picked != null) {
      sn.selectedDate = picked;
      var y = sn.selectedDate.year.toString();
      var m = sn.selectedDate.month.toString();
      var d = sn.selectedDate.day.toString();
      sn.yearController.text = y;
      sn.monthController.text = m;
      sn.dayController.text = d;
      sn.dateController.text = y + " " + m + " " + d;
    }
  }

  Future<void> iosDatePicker(BuildContext context) async {
    DateTime picked = DateTime.now();
    await showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
              key: UniqueKey(),
              builder: (ctx, setState) {
                return Container(
                  height: 350,
                  padding: const EdgeInsets.only(top: 6.0),
                  color: CupertinoColors.systemBackground.resolveFrom(context),
                  child: Column(
                    children: [
                      SafeArea(
                        top: false,
                        child: Container(
                          height: 216,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            initialDateTime: sn.selectedDate,
                            minimumDate: DateTime.now(),
                            maximumDate: DateTime(2050),
                            onDateTimeChanged: (DateTime value) {
                              print(value);
                              picked = value;
                            },
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomMansourButton(
                            width: 150,
                            titleText: Translation.current.cancel,
                            backgroundColor: Colors.white,
                            borderColor: AppColors.primaryColorLight,
                            textColor: AppColors.primaryColorLight,
                            onPressed: () {
                              Nav.pop();
                            },
                          ),
                          CustomMansourButton(
                            width: 150,
                            titleText: Translation.current.confirm,
                            textColor: AppColors.lightFontColor,
                            onPressed: () {
                              sn.selectedDate = picked;
                              var y = sn.selectedDate.year.toString();
                              var m = sn.selectedDate.month.toString();
                              var d = sn.selectedDate.day.toString();
                              sn.yearController.text = y;
                              sn.monthController.text = m;
                              sn.dayController.text = d;
                              sn.dateController.text = y + " " + m + " " + d;
                              setState(() {
                                print("edited");
                              });
                              Nav.pop();
                            },
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            ));
  }

  Future<void> iosTimePicker(BuildContext context) async {
    Duration picked = Duration();
    await showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
              key: UniqueKey(),
              builder: (ctx, setState) {
                return Container(
                  height: 350,
                  padding: const EdgeInsets.only(top: 6.0),
                  color: CupertinoColors.systemBackground.resolveFrom(context),
                  child: Column(
                    children: [
                      SafeArea(
                        top: false,
                        child: Container(
                          height: 216,
                          child: CupertinoTimerPicker(
                            mode: CupertinoTimerPickerMode.hm,
                            initialTimerDuration:
                                Duration(hours: 0, minutes: 0),
                            onTimerDurationChanged: (Duration value) {
                              print(value);
                              picked = value;
                            },
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomMansourButton(
                            width: 150,
                            titleText: Translation.current.cancel,
                            backgroundColor: Colors.white,
                            borderColor: AppColors.primaryColorLight,
                            textColor: AppColors.primaryColorLight,
                            onPressed: () {
                              Nav.pop();
                            },
                          ),
                          CustomMansourButton(
                            width: 150,
                            titleText: Translation.current.confirm,
                            textColor: AppColors.lightFontColor,
                            onPressed: () {
                              print("minutes are ${picked}");

                              sn.hourController.text =
                                  picked.inHours.toString();
                              sn.minutesController.text =
                                  (picked.inMinutes % 60)
                                      .toString()
                                      .padLeft(2, '0');
                              sn.secondsController.text = '00';
                              Nav.pop();
                            },
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            ));
  }

  Future<void> _selectTime(BuildContext context) async {
    MediaQuery.of(context).alwaysUse24HourFormat;
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    if (pickedTime != null) {
      sn.hourController.text = pickedTime.hour.toString();
      sn.minutesController.text = pickedTime.minute.toString();
      sn.secondsController.text = '00';
    } else {
      print("Time is not selected");
    }
  }
}
