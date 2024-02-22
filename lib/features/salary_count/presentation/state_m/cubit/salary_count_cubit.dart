
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/salary_count/data/model/request/change_selected_time_table_params.dart';
import 'package:starter_application/features/salary_count/data/model/request/create_time_table_params.dart';
import 'package:starter_application/features/salary_count/data/model/request/customize_time_table.dart';
import 'package:starter_application/features/salary_count/data/model/request/delete_time_table_params.dart';
import 'package:starter_application/features/salary_count/data/model/request/get_all_time_table_params.dart';
import 'package:starter_application/features/salary_count/data/model/request/update_time_table_params.dart';
import 'package:starter_application/features/salary_count/domain/entity/time_table_list_entity.dart';
import 'package:starter_application/features/salary_count/domain/usecase/change_selected_time_table_usecase.dart';
import 'package:starter_application/features/salary_count/domain/usecase/create_time_table_usecase.dart';
import 'package:starter_application/features/salary_count/domain/usecase/customize_time_table_usecase.dart';
import 'package:starter_application/features/salary_count/domain/usecase/delete_time_table_usecase.dart';
import 'package:starter_application/features/salary_count/domain/usecase/get_time_table_list_usecase.dart';
import 'package:starter_application/features/salary_count/domain/usecase/update_time_table_usecase.dart';
import '../../../../../core/errors/app_errors.dart';


part 'salary_count_state.dart';

part 'salary_count_cubit.freezed.dart';

class SalaryCountCubit extends Cubit<SalaryCountState> {

  SalaryCountCubit() : super(const SalaryCountState.salaryCountInitState());

  void getAllTimeTable(GetAllTimeTableParams params) async {
    emit(const SalaryCountState.salaryCountLoadingState());
    final result = await getIt<GetTimeTableListUsecase>()(params);
    result.pick(
      onData: (data) => emit(SalaryCountState.getAllTimeTableLoaded(data)),
      onError: (error) {
        // this.getAllTimeTable(params);
        emit(
          SalaryCountState.salaryCountErrorState(
              error, () => this.getAllTimeTable(params)),
        );
      }
    );
  }
  void createTimeTable(CreateTimeTableParams params) async {
    emit(const SalaryCountState.createTimeTableLoading());
    final result = await getIt<CreateTimeTableUsecase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(SalaryCountState.createTimeTableLoaded()),
      onError: (error) => emit(
        SalaryCountState.salaryCountErrorState(
            error, () => this.createTimeTable(params)),
      ),
    );
  }
  void changeSelectedTimeTable(ChangeSelectedTimeTableParams params) async {
    emit(const SalaryCountState.changeTimeTableSelectedLoading());
    final result = await getIt<ChangeSelectedTimeTableUsecase>()(params);
    result.pick(
      onData: (data) {
        emit(SalaryCountState.changeTimeTableSelectedLoaded());
        },
      onError: (error) => emit(
        SalaryCountState.salaryCountErrorState(
            error, () => this.changeSelectedTimeTable(params)),
      ),
    );
  }
  void deleteTimeTable(DeleteTimeTableParams params) async {
    emit(const SalaryCountState.deleteTimeTableLoading());
    final result = await getIt<DeleteTimeTableUsecase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(SalaryCountState.deleteTimeTableLoaded()),
      onError: (error) => emit(
        SalaryCountState.salaryCountErrorState(
            error, () => this.deleteTimeTable(params)),
      ),
    );
  }
  void updateTimeTable(UpdateTimeTableParams params) async {
    emit(const SalaryCountState.updateTimeTableLoading());
    final result = await getIt<UpdateTimeTableUsecase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(SalaryCountState.updateTimeTableLoaded()),
      onError: (error) => emit(
        SalaryCountState.salaryCountErrorState(
            error, () => this.updateTimeTable(params)),
      ),
    );
  }

  void customizeTimeTable(CustomizeTimeTableParams params) async {
    emit(const SalaryCountState.changeTimeTableSelectedLoading());
    final result = await getIt<CustomizeTimeTable>()(params);
    result.pick(
      onData: (data) => emit(SalaryCountState.changeTimeTableSelectedLoaded()),
      onError: (error) => emit(
        SalaryCountState.salaryCountErrorState(
            error, () => this.customizeTimeTable(params)),
      ),
    );
  }

}
