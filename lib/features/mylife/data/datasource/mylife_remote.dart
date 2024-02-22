import 'package:dartz/dartz.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/constants/enums/http_method.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/net/api_url.dart';
import 'package:starter_application/core/net/create_model_interceptor/live_socores_model_intercepter.dart';
import 'package:starter_application/core/net/create_model_interceptor/null_response_model_interceptor.dart';
import 'package:starter_application/core/net/response_validators/default_response_validator.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/features/health/data/model/request/image_params.dart';
import 'package:starter_application/features/health/data/model/response/image_upload_model.dart';
import 'package:starter_application/features/mylife/data/model/request/check_dream_params.dart';
import 'package:starter_application/features/mylife/data/model/request/check_tast_request.dart';
import 'package:starter_application/features/mylife/data/model/request/create_appointment_params.dart';
import 'package:starter_application/features/mylife/data/model/request/create_dream_params.dart';
import 'package:starter_application/features/mylife/data/model/request/create_positives_params.dart';
import 'package:starter_application/features/mylife/data/model/request/create_task_request.dart';
import 'package:starter_application/features/mylife/data/model/request/delet_item_request.dart';
import 'package:starter_application/features/mylife/data/model/request/delete_dream_params.dart';
import 'package:starter_application/features/mylife/data/model/request/get_all_tasks_request.dart';
import 'package:starter_application/features/mylife/data/model/request/get_appointment_request.dart';
import 'package:starter_application/features/mylife/data/model/request/get_positive_request.dart';
import 'package:starter_application/features/mylife/data/model/request/get_stories_request.dart';
import 'package:starter_application/features/mylife/data/model/request/get_story_params.dart';
import 'package:starter_application/features/mylife/data/model/request/update_appointment_params.dart';
import 'package:starter_application/features/mylife/data/model/response/appintment_model.dart';
import 'package:starter_application/features/mylife/data/model/response/client_model.dart';
import 'package:starter_application/features/mylife/data/model/response/get_dream_list_response.dart';
import 'package:starter_application/features/mylife/data/model/response/get_positive_response.dart';
import 'package:starter_application/features/mylife/data/model/response/quote_model.dart';
import 'package:starter_application/features/mylife/data/model/response/story_model.dart';
import 'package:starter_application/features/mylife/data/model/response/tasks_model.dart';

import 'imylife_remote.dart';

@Singleton(as: IMylifeRemoteSource)
class MylifeRemoteSource extends IMylifeRemoteSource {
  @override
  Future<Either<AppErrors, TaskModel>> getTasks(GetAllTasksRequest param) {
    return request(
      converter: (json) => TaskModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.getAllTodoTasks,
      cancelToken: param.cancelToken,
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, AppointmentModel>> getAppointments(
      GetAppointmentRequest param) {
    return request(
      converter: (json) => AppointmentModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.getAllAppointments,
      cancelToken: param.cancelToken,
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, ImageUrlsModel>> uploadImage(ImageParams params) {
    return requestUploadFile(
        converter: (json) => ImageUrlsModel.fromMap(json),
        url: APIUrls.uploadImageMahmoud,
        fileKey: 'input',
        filePath: params.image.path,
        data: {},
        responseValidator: DefaultResponseValidator(),
        mediaType: MediaType('image', 'png'));
  }

  @override
  Future<Either<AppErrors, PositiveListModel>> getAllPositive(
      GetPositiveRequest param) {
    return request(
      converter: (json) => PositiveListModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.getAllPositives,
      cancelToken: param.cancelToken,
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, ClientModel>> getClients() {
    return request(
      converter: (json) => ClientModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.getClients,
    );
  }

  @override
  Future<Either<AppErrors, TaskItem>> createTask(CreateTaskRequest param) {
    return request(
      converter: (json) => TaskItem.fromMap(json),
      method: HttpMethod.POST,
      url: APIUrls.createTask,
      cancelToken: param.cancelToken,
      body: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, AppointmentItem>> createAppointment(
      CreateAppointmentRequest param) {
    return request(
      converter: (json) => AppointmentItem.fromMap(json),
      method: HttpMethod.POST,
      url: APIUrls.createAppointments,
      cancelToken: param.cancelToken,
      body: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> checkTask(CheckTasksRequest param) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      url: param.type ==0 ? APIUrls.checkTask : APIUrls.checkDream,
      createModelInterceptor: LiveSocoresModelIntercepter(),
      body: param.toMap(),
    );
  }
  @override
  Future<Either<AppErrors, EmptyResponse>> deleteItem(DeleteItemRequest param) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.DELETE,
      url:param.type==1? APIUrls.deleteAppointment:APIUrls.deleteToDo,
      createModelInterceptor: NullResponseModelInterceptor(),
      queryParameters: param.toMap(),
    );
  }
  @override
  Future<Either<AppErrors, EmptyResponse>> checkAppointment(
      CheckTasksRequest param) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      url: APIUrls.checkAppointment,
      createModelInterceptor: LiveSocoresModelIntercepter(),
      body: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, StoryModel>> getStories(GetStoryRequest param) {
    return request(
      converter: (json) => StoryModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.getAllStories,
      cancelToken: param.cancelToken,
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, QuoteModel>> getQuote() {
    return request(
      converter: (json) => QuoteModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.getQuote,
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, DreamsListModel>> getAllDreams(NoParams param) {
    return request(
      converter: (json) => DreamsListModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.getAllDreams,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjMiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiY2xpZW50IiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoiY2xpZW50QGJpYWxhaC5jb20iLCJBc3BOZXQuSWRlbnRpdHkuU2VjdXJpdHlTdGFtcCI6IjVmYTE4YzVjLWZhZWItOTEzNy00NzhlLTNhMDFjYzk1MzBjYyIsImh0dHA6Ly93d3cuYXNwbmV0Ym9pbGVycGxhdGUuY29tL2lkZW50aXR5L2NsYWltcy90ZW5hbnRJZCI6IjEiLCJzdWIiOiIzIiwianRpIjoiOGI2MDE3OWYtYzNhMi00YjlhLWExMWYtYTY5YTNmNGQ0N2UzIiwiaWF0IjoxNjQ4Mjg4MjI0LCJuYmYiOjE2NDgyODgyMjQsImV4cCI6MTY1MDg4MDIyNCwiaXNzIjoiTW9ocmEiLCJhdWQiOiJNb2hyYSJ9.uV5Ab1RaLI2FMqER2Akxl_EeRtEzbsBmFX4tlx73tiE',
      },
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, DreamModel>> createDream(CreateDreamParams params) {
    return request(
      converter: (json) => DreamModel.fromMap(json),
      method: HttpMethod.POST,
      url: APIUrls.createDream,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjMiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiY2xpZW50IiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoiY2xpZW50QGJpYWxhaC5jb20iLCJBc3BOZXQuSWRlbnRpdHkuU2VjdXJpdHlTdGFtcCI6IjVmYTE4YzVjLWZhZWItOTEzNy00NzhlLTNhMDFjYzk1MzBjYyIsImh0dHA6Ly93d3cuYXNwbmV0Ym9pbGVycGxhdGUuY29tL2lkZW50aXR5L2NsYWltcy90ZW5hbnRJZCI6IjEiLCJzdWIiOiIzIiwianRpIjoiOGI2MDE3OWYtYzNhMi00YjlhLWExMWYtYTY5YTNmNGQ0N2UzIiwiaWF0IjoxNjQ4Mjg4MjI0LCJuYmYiOjE2NDgyODgyMjQsImV4cCI6MTY1MDg4MDIyNCwiaXNzIjoiTW9ocmEiLCJhdWQiOiJNb2hyYSJ9.uV5Ab1RaLI2FMqER2Akxl_EeRtEzbsBmFX4tlx73tiE',
      },
      responseValidator: DefaultResponseValidator(),
      body: params.toMap(),
      isFormData: true,
    );
  }

  @override
  Future<Either<AppErrors, PositiveModel>> createPositive(
      CreatePositivesParams params) {
    return request(
      converter: (json) => PositiveModel.fromMap(json),
      method: HttpMethod.POST,
      url: APIUrls.createPositive,
      responseValidator: DefaultResponseValidator(),
      body: params.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> deleteDream(DeleteDreamParams param) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.DELETE,
      url: APIUrls.deleteDream,
      createModelInterceptor: LiveSocoresModelIntercepter(),
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> checkUnCheckDream(CheckDreamParams param) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      url: param.type ==0 ? APIUrls.unCheckDream : APIUrls.checkDream,
      createModelInterceptor: LiveSocoresModelIntercepter(),
      body: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, StoryItem>> getStory(GetStoryParams params) {
    return request(
      converter: (json) => StoryItem.fromMap(json),
      method: HttpMethod.GET,
      url:  APIUrls.getStory,
      queryParameters: params.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> updateAppointment(UpdateAppointmentRequest params) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.PUT,
      url:  APIUrls.updateAppointment,
      body: params.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> deletePositive(
      DeleteItemRequest param) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.DELETE,
      url: APIUrls.deletePositive,
      responseValidator: DefaultResponseValidator(),
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, PositiveModel>> updatePositive(
      CreatePositivesParams params) {
    return request(
      converter: (json) => PositiveModel.fromMap(json),
      method: HttpMethod.DELETE,
      url: APIUrls.updatePositive,
      responseValidator: DefaultResponseValidator(),
      body: params.toMap(),
    );
  }

}
