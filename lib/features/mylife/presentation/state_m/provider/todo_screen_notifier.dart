import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/mylife/data/model/request/check_tast_request.dart';
import 'package:starter_application/features/mylife/data/model/request/create_task_request.dart';
import 'package:starter_application/features/mylife/data/model/request/delet_item_request.dart';
import 'package:starter_application/features/mylife/data/model/request/get_all_tasks_request.dart';
import 'package:starter_application/features/mylife/domain/entity/task_entity.dart';
import 'package:starter_application/features/mylife/presentation/logic/date_time_helper.dart';
import 'package:starter_application/features/mylife/presentation/logic/test.dart';
import 'package:starter_application/features/mylife/presentation/state_m/cubit/mylife_cubit.dart';
import 'package:starter_application/features/mylife/presentation/widget/my_life_todo_bottomsheet.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';

class TodoScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  MylifeCubit myLifeCubit = MylifeCubit();
  late TaskEntity eventEntity;
  DateTime now = DateTime.now();
  DateTime selectedDay = DateTime.now();
  bool _tableIsExpanded = false;
  List<TaskItemEntity> tasks = [];
  late TaskEntity task;
  List<int> _selectedIndexes = [];
  List<int> _selectedId = [];
  late bool isOneSelect = false;
  Map<DateTime, List<TaskItemEntity>> dataTableDate = {};
  late final ValueNotifier<List<TaskItemEntity>> selectedEvents;
  LinkedHashMap map2 = new LinkedHashMap<DateTime, List<TaskItemEntity>>();
  bool isFirst = true;

  /// Getters and Setters
  List<int> get selectedMessagesIndexes => this._selectedIndexes;

  bool get tableIsExpanded => _tableIsExpanded;

  List<TaskItemEntity> getEventsForDay(DateTime day) {
    return map2[day] ?? [];
  }

  set tableIsExpanded(bool value) {
    _tableIsExpanded = value;
    notifyListeners();
  }

  /// Methods
  onTab(int Index) {
    if (!tasks[Index].isSelected) {
      if (!tasks[Index].isAchieved) {
        if (!selectedMessagesIndexes.contains(Index)) {
          _selectedIndexes.add(Index);
          _selectedId.add(tasks[Index].id!);
        }
        tasks[Index].isSelected = true;
      }
    } else {
      tasks[Index].isSelected = false;
      _selectedIndexes.remove(Index);
      _selectedId.remove(tasks[Index].id!);
    }
    if (_selectedIndexes.isNotEmpty) {
      isOneSelect = true;
    } else {
      isOneSelect = false;
    }
    notifyListeners();
  }

  onCheck() {
    for (int i = 0; i < _selectedIndexes.length; i++) {
      tasks[_selectedIndexes[i]].isSelected = false;
      tasks[_selectedIndexes[i]].isAchieved = true;
      myLifeCubit.checkTask(CheckTasksRequest(list: _selectedId));
      // print(_selectedId);
      // _selectedIndexes.clear();
    }

    notifyListeners();
  }

  void getTask() {
    isFirst = true;
    map2.clear();

    var temp = DateTime.parse(now.toString() + 'Z');
    myLifeCubit.getTasks(GetAllTasksRequest(
       ));
  }

  void getTaskByDay(temp) {
    myLifeCubit
        .getTasksPerDay(GetAllTasksRequest(toDate: temp, fromDate: temp));
  }

  void tasksLoadSuccess(List<TaskItemEntity> items, TaskEntity taskEntity) {
    tasks = items;
    task = taskEntity;
    if (isFirst) {
      dataTableDate.clear();
      print('--------------');
      for (TaskItemEntity item in tasks) {
        print(item.date);
        if (dataTableDate[DateTimeHelper.getDateOnly(item.date)] == null) {
          print('first if');
          dataTableDate[DateTimeHelper.getDateOnly(item.date)] = [];
        }
        if (dataTableDate[DateTimeHelper.getDateOnly(item.date)]!.length < 3) {
          print('third if');
          dataTableDate[DateTimeHelper.getDateOnly(item.date)]!.add(item);
        }
        print('--------------');
        map2 = LinkedHashMap<DateTime, List<TaskItemEntity>>(
          equals: isSameDay,
          hashCode: getHashCode,
        )..addAll(dataTableDate);
      }
    }
    getTaskByDay(selectedDay);
    isFirst = false;
    notifyListeners();
  }

  tasksPerDayLoadSuccess(TaskEntity taskEntity) {
    tasks = taskEntity.items!;
    task = taskEntity;
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

  void onAddTap(selectedDay) {
    print(selectedDay);
    showAddDreamBottomSheet(
      context: context,
      onNav: () {},
      OnAdd: (title, fromHour, toHour, priority) {
        Nav.pop();
        myLifeCubit.createTask(CreateTaskRequest(
            title: title,
            date: fromHour,
            toHour: fromHour,
            fromHour: toHour,
            priority: priority));
      },
    );
  }

  void addedTaskSuccess(TaskItemEntity task) {
    getTask();
  }

  void deleteTask(id) {
    myLifeCubit.deleteItem(DeleteItemRequest(id: id, type: 2));
  }

  deletedTaskDone(){
    getTask();
  }

  @override
  void closeNotifier() {
    this.dispose();
  }
}
