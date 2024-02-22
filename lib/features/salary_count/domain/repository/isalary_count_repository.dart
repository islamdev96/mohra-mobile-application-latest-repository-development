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

import '../../../../core/repositories/repository.dart';

abstract class ISalaryCountRepository extends Repository {
  Future<Result<AppErrors, TimeTableListEntity>> getAllTimeTable(GetAllTimeTableParams params);
  Future<Result<AppErrors, EmptyResponse>> createTimeTable(CreateTimeTableParams params);
  Future<Result<AppErrors, EmptyResponse>> changeSelectedTimeTable(ChangeSelectedTimeTableParams params);
  Future<Result<AppErrors, EmptyResponse>> updateTimeTable(UpdateTimeTableParams params);
  Future<Result<AppErrors, EmptyResponse>> deleteTimeTable(DeleteTimeTableParams params);
  Future<Result<AppErrors, EmptyResponse>> changeTimeTableOrder(ChangeTimeTableOrderRequest params);
  Future<Result<AppErrors, EmptyResponse>> customizeTimeTable(CustomizeTimeTableParams params);


}

