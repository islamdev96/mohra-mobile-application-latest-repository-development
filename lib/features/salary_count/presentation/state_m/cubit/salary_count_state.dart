part of 'salary_count_cubit.dart';

@freezed
class SalaryCountState with _$SalaryCountState {
  const factory SalaryCountState.salaryCountInitState() = SalaryCountInitState;

  const factory SalaryCountState.salaryCountLoadingState() = SalaryCountLoadingState;

  const factory SalaryCountState.salaryCountErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = SalaryCountErrorState;

  const factory SalaryCountState.getAllTimeTableLoaded(
      TimeTableListEntity tableListEntity
      ) = GetAllTimeTableLoaded;

  const factory SalaryCountState.createTimeTableLoading() = CreateTimeTableLoading;
  const factory SalaryCountState.createTimeTableLoaded() = CreateTimeTableLoaded;
  const factory SalaryCountState.changeTimeTableSelectedLoaded() = ChangeTimeTableSelectedLoaded;
  const factory SalaryCountState.changeTimeTableSelectedLoading() = ChangeTimeTableSelectedLoading;
  const factory SalaryCountState.deleteTimeTableLoading() = DeleteTimeTableLoading;
  const factory SalaryCountState.deleteTimeTableLoaded() = DeleteTimeTableLoaded;
  const factory SalaryCountState.updateTimeTableLoaded() = UpdateTimeTableLoaded;
  const factory SalaryCountState.updateTimeTableLoading() = UpdateTimeTableLoading;



}

