import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/constants/enums/http_method.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/net/api_url.dart';
import 'package:starter_application/core/net/response_validators/default_response_validator.dart';
import 'package:starter_application/features/salary_count/data/model/request/change_order_request.dart';
import 'package:starter_application/features/salary_count/data/model/request/change_selected_time_table_params.dart';
import 'package:starter_application/features/salary_count/data/model/request/create_time_table_params.dart';
import 'package:starter_application/features/salary_count/data/model/request/customize_time_table.dart';
import 'package:starter_application/features/salary_count/data/model/request/delete_time_table_params.dart';
import 'package:starter_application/features/salary_count/data/model/request/get_all_time_table_params.dart';
import 'package:starter_application/features/salary_count/data/model/request/update_time_table_params.dart';
import 'package:starter_application/features/salary_count/data/model/response/time_table_list_response.dart';


import 'isalary_count_remote.dart';

@Singleton(as: ISalaryCountRemoteSource)
class SalaryCountRemoteSource extends ISalaryCountRemoteSource {
  @override
  Future<Either<AppErrors, TimeTableListModel>> getAllTimeTable(GetAllTimeTableParams params) {
    return request(
      converter: (json) {
        return TimeTableListModel.fromJson(json);
      },
      method: HttpMethod.GET,
      url: APIUrls.getAllTimeTable,
      responseValidator: DefaultResponseValidator(),
      queryParameters: params.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> changeSelectedTimeTable(ChangeSelectedTimeTableParams params) {
    return request(
      converter: (json) {
        return EmptyResponse.fromMap(json);
      },
      method: HttpMethod.PUT,
      url: APIUrls.changeSelectedTimeTable,
      responseValidator: DefaultResponseValidator(),
      body: params.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> createTimeTable(CreateTimeTableParams params) {
    return request(
      converter: (json) {
        return EmptyResponse.fromMap(json);
      },
      method: HttpMethod.POST,
      url: APIUrls.createTimeTable,
      responseValidator: DefaultResponseValidator(),
      body: params.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> deleteTimeTable(DeleteTimeTableParams params) {
    return request(
      converter: (json) {
        return EmptyResponse.fromMap(json);
      },
      method: HttpMethod.DELETE,
      url: APIUrls.deleteTimeTable,
      responseValidator: DefaultResponseValidator(),
      queryParameters: params.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> updateTimeTable(UpdateTimeTableParams params) {
    return request(
      converter: (json) {
        return EmptyResponse.fromMap(json);
      },
      method: HttpMethod.PUT,
      url: APIUrls.updateTimeTable,
      responseValidator: DefaultResponseValidator(),
      body: params.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> changeTimeTableOrder(ChangeTimeTableOrderRequest params) {
    return request(
      converter: (json) {
        return EmptyResponse.fromMap(json);
      },
      method: HttpMethod.PUT,
      url: APIUrls.changeOrder,
      responseValidator: DefaultResponseValidator(),
      body: params.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> customizeTimeTable(CustomizeTimeTableParams params) {
    return request(
      converter: (json) {
        return EmptyResponse.fromMap(json);
      },
      method: HttpMethod.GET,
      url: APIUrls.getQuestions,
      responseValidator: DefaultResponseValidator(),
      body: params.toMap(),
    );
  }
  
}
