import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/features/mylife/data/model/request/check_tast_request.dart';
import 'package:starter_application/features/mylife/data/model/request/create_appointment_params.dart';
import 'package:starter_application/features/mylife/data/model/request/delet_item_request.dart';
import 'package:starter_application/features/mylife/data/model/request/get_appointment_request.dart';
import 'package:starter_application/features/mylife/data/model/request/update_appointment_params.dart';
import 'package:starter_application/features/mylife/domain/entity/appointment_entity.dart';
import 'package:starter_application/features/mylife/domain/entity/client_entity.dart';
import 'package:starter_application/features/mylife/domain/entity/task_entity.dart';
import 'package:starter_application/features/mylife/presentation/logic/date_time_helper.dart';
import 'package:starter_application/features/mylife/presentation/logic/test.dart';
import 'package:starter_application/features/mylife/presentation/state_m/cubit/mylife_cubit.dart';
import 'package:starter_application/features/mylife/presentation/widget/my_life_apponiment_bottomsheet.dart';
import 'package:starter_application/features/mylife/presentation/widget/my_life_edit_appointment_bottom_sheet.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';

class AppointmentScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  MylifeCubit myLifeCubit = MylifeCubit();
  DateTime now = DateTime.now();
  List<AppointmentItemEntity> appointments2 = [];
  AppointmentEntity appointment = AppointmentEntity();
  DateTime selectedDay = DateTime.now();
  List<ClientItemEntity> users = [];
  List<int> _selectedIndexes = [];
  bool isOneSelect = false;
  List<int> _selectedId = [];
  bool _tableIsExpanded = false;
  bool isFirst = true;
  LinkedHashMap map2 =
      new LinkedHashMap<DateTime, List<AppointmentItemEntity>>();
  Map<DateTime, List<AppointmentItemEntity>> dataTableDate = {};

  /// Getters and Setters
  bool get tableIsExpanded => _tableIsExpanded;

  set tableIsExpanded(bool value) {
    _tableIsExpanded = value;
    notifyListeners();
  }

  List<AppointmentItemEntity> getEventsForDay(DateTime day) {
    return map2[day] ?? [];
  }

  /// Methods
  void getAppointments() {
    isFirst = true;
    map2.clear();
    var temp = DateTime.parse(now.toString() + 'Z');
    myLifeCubit.getAppointments(GetAppointmentRequest(
        ));
  }

  void getAppointmentByDay(temp) {
    myLifeCubit
        .getAppointmentsPerDay(GetAppointmentRequest(toDate: temp, fromDate: temp));
  }

  void getClients() {
    myLifeCubit.getClients(NoParams());
  }

  void getClientsSuccess(List<ClientItemEntity> result) {
    users = result;
    notifyListeners();
  }

  onTab(int Index) {
    print(appointments2[Index].isSelected);
    if (!appointments2[Index].isSelected) {
      if (!appointments2[Index].isDone!) {
        if (!_selectedIndexes.contains(Index)) {
          _selectedIndexes.add(Index);
          _selectedId.add(appointments2[Index].id!);
        }
        appointments2[Index].isSelected = true;
      }
    }
    else {
      appointments2[Index].isSelected = false;
      _selectedIndexes.remove(Index);
      _selectedId.remove(appointments2[Index].id!);
    }
    if (_selectedIndexes.isNotEmpty) {
      isOneSelect = true;
    }
    else {
      isOneSelect = false;
    }
    print(appointments2[Index].isSelected);
    notifyListeners();
  }

  void onAddTap() {
    showAddAppointmentBottomSheet(
      context: context,
      users: users,
      onNav: () {},
      OnAdd: (title, startDate , endDate, fromHour, toHour, priority, repeat, clientId, reminder,
          isAllDays) {
        Nav.pop();
        CreateAppointmentRequest createAppointmentRequest = CreateAppointmentRequest(
            title: title,
            toHour: toHour,
            isAllDays: isAllDays,
            clients: clientId,
            repeat: repeat,
            startDate: startDate,
            endDate: endDate,
            priority: priority,
            reminder: reminder,
            note: "empty",
            fromHour: fromHour);
        print('aaaaaaaaaaaaaaapppppppppppppppp');
        print(createAppointmentRequest);
        myLifeCubit.createAppointment(createAppointmentRequest);
      },
    );
  }

  void appointmentAddedSuccess(AppointmentItemEntity appointmentItem) {
    getAppointments();
    notifyListeners();
  }

  void loaded(AppointmentEntity appointmentEntity) {

    appointment = appointmentEntity;
    appointments2 = appointmentEntity.items!;
    if (isFirst) {
      dataTableDate.clear();
      print('--------------');
      for (AppointmentItemEntity item in appointments2) {
        if (dataTableDate[DateTimeHelper.getDateOnly(item.startDate)] == null) {
          dataTableDate[DateTimeHelper.getDateOnly(item.startDate)] = [];
        }
          if (dataTableDate[DateTimeHelper.getDateOnly(item.startDate)]!.length < 3) {
            dataTableDate[DateTimeHelper.getDateOnly(item.startDate)]!.add(item);
          }

        map2 = LinkedHashMap<DateTime, List<AppointmentItemEntity>>(
          equals: isSameDay,
          hashCode: getHashCode,
        )..addAll(dataTableDate);
      }
    }
    getAppointmentByDay(DateTime.now());

    isFirst = false;
    notifyListeners();
  }

  onAppointmentPerDateLoaded(AppointmentEntity appointmentEntity){
    appointment = appointmentEntity;
    appointments2 = appointmentEntity.items!;
    notifyListeners();
  }

  onCheck() {
    for (int i = 0; i < _selectedIndexes.length; i++) {
      appointments2[_selectedIndexes[i]].isSelected = false;
      appointments2[_selectedIndexes[i]].isDone = true;
      myLifeCubit.checkAppointment(CheckTasksRequest(list: _selectedId));
      _selectedIndexes.clear();
      isOneSelect = false;
      notifyListeners();
      // print(_selectedId);
      // _selectedIndexes.clear();
    }

    notifyListeners();
  }

  Color getColorPriority(int id) {
    switch (id) {
      case 0:
        return AppColors.mansourLightBlueDream;
      case 1:
        return AppColors.mansourYellow2;
    }
    return AppColors.mansourLightRed;
  }

  void deleteAppointment(id) {
    myLifeCubit.deleteItem(DeleteItemRequest(id: id, type: 1));
  }

  onDeleteAppointmentDone(){
    getAppointmentByDay(selectedDay);
  }


  updateAppointment(AppointmentItemEntity appointmentItem){
    showEditBottomSheet(appointmentItem);
  }

  showEditBottomSheet(AppointmentItemEntity appointmentItem){
    showEditAppointmentBottomSheet(
      context: context,
      users: users,
      appointmentItemEntity: appointmentItem,
      onNav: () {},
      OnEdit:  (title, startDate , endDate, fromHour, toHour, priority, repeat, clientId, reminder,
          isAllDays) {
        Nav.pop();
        UpdateAppointmentRequest updateAppointmentRequest = UpdateAppointmentRequest(
            id: appointmentItem.id!,
            title: title,
            toHour: toHour,
            isAllDays: isAllDays,
            clients: clientId,
            repeat: repeat,
            startDate: startDate,
            endDate: endDate,
            priority: priority,
            reminder: reminder,
            note: "empty",
            fromHour: fromHour);
        print(updateAppointmentRequest);
        myLifeCubit.updateAppointment(updateAppointmentRequest);
      },
    );
  }



  onUpdateSuccess(){
    getAppointmentByDay(selectedDay);
  }

  @override
  void closeNotifier() {
    this.dispose();
  }
}

class Event {
  final String title;

  Event({required this.title});
}
