import 'package:dartz/dartz.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/features/salary_count/data/model/request/change_order_request.dart';
import 'package:starter_application/features/salary_count/data/model/request/change_selected_time_table_params.dart';
import 'package:starter_application/features/salary_count/data/model/request/create_time_table_params.dart';
import 'package:starter_application/features/salary_count/data/model/request/customize_time_table.dart';
import 'package:starter_application/features/salary_count/data/model/request/delete_time_table_params.dart';
import 'package:starter_application/features/salary_count/data/model/request/get_all_time_table_params.dart';
import 'package:starter_application/features/salary_count/data/model/request/update_time_table_params.dart';
import 'package:starter_application/features/salary_count/data/model/response/time_table_list_response.dart';
import '../../../../core/datasources/remote_data_source.dart';

abstract class ISalaryCountRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, TimeTableListModel>> getAllTimeTable(GetAllTimeTableParams params);
  Future<Either<AppErrors, EmptyResponse>> createTimeTable(CreateTimeTableParams params);
  Future<Either<AppErrors, EmptyResponse>> changeSelectedTimeTable(ChangeSelectedTimeTableParams params);
  Future<Either<AppErrors, EmptyResponse>> updateTimeTable(UpdateTimeTableParams params);
  Future<Either<AppErrors, EmptyResponse>> deleteTimeTable(DeleteTimeTableParams params);
  Future<Either<AppErrors, EmptyResponse>> changeTimeTableOrder(ChangeTimeTableOrderRequest params);
  Future<Either<AppErrors, EmptyResponse>> customizeTimeTable(CustomizeTimeTableParams params);
}
