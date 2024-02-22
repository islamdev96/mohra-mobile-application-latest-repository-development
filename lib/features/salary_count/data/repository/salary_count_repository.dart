import 'package:injectable/injectable.dart';
import 'package:starter_application/core/common/extensions/either_error_model_extension.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/salary_count/data/model/request/change_order_request.dart';
import 'package:starter_application/features/salary_count/data/model/request/change_selected_time_table_params.dart';
import 'package:starter_application/features/salary_count/data/model/request/create_time_table_params.dart';
import 'package:starter_application/features/salary_count/data/model/request/customize_time_table.dart';
import 'package:starter_application/features/salary_count/data/model/request/delete_time_table_params.dart';
import 'package:starter_application/features/salary_count/data/model/request/get_all_time_table_params.dart';
import 'package:starter_application/features/salary_count/data/model/request/update_time_table_params.dart';
import 'package:starter_application/features/salary_count/domain/entity/time_table_list_entity.dart';
import '../datasource/../../domain/repository/isalary_count_repository.dart';
import '../datasource/isalary_count_remote.dart';

@Singleton(as: ISalaryCountRepository)
class SalaryCountRepository extends ISalaryCountRepository {
  final ISalaryCountRemoteSource iSalaryCountRemoteSource;

  SalaryCountRepository(this.iSalaryCountRemoteSource);

  @override
  Future<Result<AppErrors, EmptyResponse>> changeSelectedTimeTable(ChangeSelectedTimeTableParams params)async {
    final remote = await iSalaryCountRemoteSource.changeSelectedTimeTable(params);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> createTimeTable(CreateTimeTableParams params)async {
    final remote = await iSalaryCountRemoteSource.createTimeTable(params);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, TimeTableListEntity>> getAllTimeTable(GetAllTimeTableParams params)async {
    final remote = await iSalaryCountRemoteSource.getAllTimeTable(params);
    return remote.result<TimeTableListEntity>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> deleteTimeTable(DeleteTimeTableParams params) async {
    final remote = await iSalaryCountRemoteSource.deleteTimeTable(params);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> updateTimeTable(UpdateTimeTableParams params) async {
    final remote = await iSalaryCountRemoteSource.updateTimeTable(params);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> changeTimeTableOrder(ChangeTimeTableOrderRequest params) async {
    final remote = await iSalaryCountRemoteSource.changeTimeTableOrder(params);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> customizeTimeTable(CustomizeTimeTableParams params) async {
    final remote = await iSalaryCountRemoteSource.customizeTimeTable(params);
    return remote.result<EmptyResponse>();
  }
  
}
