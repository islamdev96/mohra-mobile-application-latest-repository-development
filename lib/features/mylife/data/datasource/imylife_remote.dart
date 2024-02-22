import 'package:dartz/dartz.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
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
import '../../../../core/datasources/remote_data_source.dart';

abstract class IMylifeRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, TaskModel>> getTasks(GetAllTasksRequest param);

  Future<Either<AppErrors, TaskItem>> createTask(CreateTaskRequest param);

  Future<Either<AppErrors, AppointmentModel>> getAppointments(
      GetAppointmentRequest param);

  Future<Either<AppErrors, EmptyResponse>> checkTask(CheckTasksRequest param);

  Future<Either<AppErrors, DreamsListModel>> getAllDreams(NoParams param);

  Future<Either<AppErrors, PositiveListModel>> getAllPositive(
      GetPositiveRequest param);

  Future<Either<AppErrors, DreamModel>> createDream(CreateDreamParams params);

  Future<Either<AppErrors, PositiveModel>> createPositive(
      CreatePositivesParams params);

  Future<Either<AppErrors, EmptyResponse>> deletePositive(
      DeleteItemRequest param);

  Future<Either<AppErrors, PositiveModel>> updatePositive(
      CreatePositivesParams params);

  Future<Either<AppErrors, AppointmentItem>> createAppointment(
      CreateAppointmentRequest params);

  Future<Either<AppErrors, EmptyResponse>> checkAppointment(
      CheckTasksRequest param);

  Future<Either<AppErrors, ClientModel>> getClients();

  Future<Either<AppErrors, ImageUrlsModel>> uploadImage(ImageParams params);

  Future<Either<AppErrors, StoryModel>> getStories(GetStoryRequest param);

  Future<Either<AppErrors, QuoteModel>> getQuote();
  Future<Either<AppErrors, EmptyResponse>> deleteItem(
      DeleteItemRequest param);

  Future<Either<AppErrors, EmptyResponse>> deleteDream(
      DeleteDreamParams param);

  Future<Either<AppErrors, EmptyResponse>> checkUnCheckDream(CheckDreamParams param);
  Future<Either<AppErrors, StoryItem>> getStory(GetStoryParams params);

  Future<Either<AppErrors, EmptyResponse>> updateAppointment(
        UpdateAppointmentRequest params);
}
