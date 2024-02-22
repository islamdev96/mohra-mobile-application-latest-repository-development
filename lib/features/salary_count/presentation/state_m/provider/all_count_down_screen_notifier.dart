import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/date_utils.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/mylife/presentation/logic/date_time_helper.dart';
import 'package:starter_application/features/notification/data/model/request/get_all_notification_param.dart';
import 'package:starter_application/features/salary_count/data/model/request/change_order_request.dart';
import 'package:starter_application/features/salary_count/data/model/request/change_selected_time_table_params.dart';
import 'package:starter_application/features/salary_count/data/model/request/create_time_table_params.dart';
import 'package:starter_application/features/salary_count/data/model/request/customize_time_table.dart';
import 'package:starter_application/features/salary_count/data/model/request/delete_time_table_params.dart';
import 'package:starter_application/features/salary_count/data/model/request/get_all_time_table_params.dart';
import 'package:starter_application/features/salary_count/data/model/request/update_time_table_params.dart';
import 'package:starter_application/features/salary_count/domain/entity/time_table_list_entity.dart';
import 'package:starter_application/features/salary_count/domain/usecase/get_time_table_list_usecase.dart';
import 'package:starter_application/features/salary_count/presentation/state_m/cubit/salary_count_cubit.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';

class AllCountDownScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  DateTime selectedDate = DateTime.now();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController minutesController = TextEditingController();
  final TextEditingController secondsController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  final RefreshController momentsRefreshController = RefreshController();
  bool _checkBoxValue = false;
  final salaryCountCubit = SalaryCountCubit();
  List<TimeTableItemEntity> timeTableListEntity = [];

  bool get checkBoxValue => _checkBoxValue;

  set checkBoxValue(bool value) {
    _checkBoxValue = value;
    notifyListeners();
  }
  bool isLoading = true;
  int newOrder = -1;

  /// Getters and Setters

  /// Methods
  void onTimeTablesItemsFetched(List<TimeTableItemEntity> items, int nextUnit) {
    timeTableListEntity = items;
    notifyListeners();
  }

  void TimeTablesLoaded(TimeTableListEntity momentEntity) {
    timeTableListEntity = momentEntity.items;
    notifyListeners();
  }

  void loading(value) {
    isLoading = value;
    notifyListeners();
  }

  Future<Result<AppErrors, List<TimeTableItemEntity>>> getTimeTableItems(
      int unit) async {
    final result = await getIt<GetTimeTableListUsecase>()(GetAllTimeTableParams(
      skipCount: unit * 4,
      maxResultCount: 4, clientId: UserSessionDataModel.userId
    ));

    return Result<AppErrors, List<TimeTableItemEntity>>(
        data: result.data?.items, error: result.error);
  }

  @override
  void closeNotifier() {
    this.dispose();
  }

  getAllTimeTable() {
    salaryCountCubit.getAllTimeTable(GetAllTimeTableParams(maxResultCount: 4,clientId: UserSessionDataModel.userId));
  }

  onTimeListLoaded(TimeTableListEntity tableListEntity) {
    timeTableListEntity = tableListEntity.items;
    notifyListeners();
  }

  onAddEventTapped() {
    DateTime vs = DateTime.parse(
        '${yearController.text.toString()}-${AppConstants.checkTimeValue(
            int.parse(monthController.text.toString()))}-${AppConstants
            .checkTimeValue(
            int.parse(dayController.text.toString()))} ${AppConstants
            .checkTimeValue(
            int.parse(hourController.text.toString()))}:${AppConstants
            .checkTimeValue(int.parse(minutesController.text.toString()))}');
    // print(DateTimeHelper.getFormatedDate(vs.toUtc()));
    CreateTimeTableParams createTimeTableParams = CreateTimeTableParams(
        title: titleController.text,
        date: vs,
        selected: checkBoxValue,
        order: timeTableListEntity.length + 1);
    salaryCountCubit.createTimeTable(createTimeTableParams);
  }

  deleteTimeTable(int id) {
    salaryCountCubit.deleteTimeTable(DeleteTimeTableParams(id: id));
  }

  editTimeTableTapped(int index) {
    DateTime vs = DateTime.parse(
        '${yearController.text.toString()}-${AppConstants.checkTimeValue(
            int.parse(monthController.text.toString()))}-${AppConstants
            .checkTimeValue(
            int.parse(dayController.text.toString()))} ${AppConstants
            .checkTimeValue(
            int.parse(hourController.text.toString()))}:${AppConstants
            .checkTimeValue(int.parse(minutesController.text.toString()))}');
    print(DateTimeHelper.getFormatedDate(vs.toUtc()));
    UpdateTimeTableParams updateTimeTableParams = UpdateTimeTableParams(
        id: timeTableListEntity[index].id,
        arTitle: titleController.text,
        enTitle: titleController.text,
        date: vs.toUtc(),
        selected: checkBoxValue,
        order: newOrder);
    salaryCountCubit.updateTimeTable(updateTimeTableParams);
  }

  clearData() {
    newOrder = -1;
    titleController.clear();
    yearController.clear();
    monthController.clear();
    dayController.clear();
    hourController.clear();
    minutesController.clear();
    checkBoxValue = false;
    selectedDate = DateTime.now();
  }

  initEditData(int index) {
    titleController.text = timeTableListEntity[index].title ?? '';
    dayController.text = timeTableListEntity[index].date.day.toString();
    hourController.text = timeTableListEntity[index].date.hour.toString();
    minutesController.text = timeTableListEntity[index].date.minute.toString();
    yearController.text = timeTableListEntity[index].date.year.toString();
    monthController.text = timeTableListEntity[index].date.month.toString();
    checkBoxValue = timeTableListEntity[index].selected ?? true;
    selectedDate = timeTableListEntity[index].date;
    newOrder = timeTableListEntity[index].order;
  }

  notify() {
    notifyListeners();
  }

  onReorder(int oldIndex, int newIndex) {
    int newRealIndex = newIndex;
    print(newRealIndex);
    ChangeSelectedTimeTableParams changeSelectedTimeTableParams = ChangeSelectedTimeTableParams(
      id: timeTableListEntity[oldIndex].id,
      selected: newRealIndex < 3 ,
      order: newRealIndex + 1,);
    TimeTableItemEntity tableItemEntity = TimeTableItemEntity(
      title: timeTableListEntity[oldIndex].title,
      date: timeTableListEntity[oldIndex].date,
      clientId: timeTableListEntity[oldIndex].clientId,
      creatorUserId: timeTableListEntity[oldIndex].creatorUserId,
      selected: timeTableListEntity[oldIndex].selected,
      order: timeTableListEntity[oldIndex].order,
      isActive: timeTableListEntity[oldIndex].isActive,
      id: timeTableListEntity[oldIndex].id,
      isDefault: timeTableListEntity[oldIndex].isDefault,
      arTitle: timeTableListEntity[oldIndex].arTitle,
      enTitle: timeTableListEntity[oldIndex].enTitle
    );
    timeTableListEntity.removeAt(oldIndex);
    timeTableListEntity.insert(newRealIndex, tableItemEntity);
    print('new real index $newRealIndex');
    // if(timeTableListEntity[newRealIndex].clientId == null){
    //   CustomizeTimeTableParams customizeTimeTableParams = CustomizeTimeTableParams(
    //     id: changeSelectedTimeTableParams.id,
    //     order: changeSelectedTimeTableParams.order,
    //   );
    //   print('new real index ${customizeTimeTableParams.id} , ${customizeTimeTableParams.order}');
    //   salaryCountCubit.customizeTimeTable(
    //       customizeTimeTableParams);
    // }
    // else{
    //   print('new real index ${changeSelectedTimeTableParams.id} , ${changeSelectedTimeTableParams.order}');
      salaryCountCubit.changeSelectedTimeTable(
          changeSelectedTimeTableParams);
    // }
    notifyListeners();
  }


  onBackSalaryCount(){
    timeTableListEntity.clear();
    notifyListeners();
  }
}
