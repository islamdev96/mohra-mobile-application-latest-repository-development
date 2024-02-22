import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/health/data/model/request/image_params.dart';
import 'package:starter_application/features/health/domain/entity/image_urls_entity.dart';
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
import 'package:starter_application/features/mylife/data/model/response/client_model.dart';
import 'package:starter_application/features/mylife/data/model/response/story_model.dart';
import 'package:starter_application/features/mylife/domain/entity/DreamListEntity.dart';
import 'package:starter_application/features/mylife/domain/entity/PositiveListEntity.dart';
import 'package:starter_application/features/mylife/domain/entity/appointment_entity.dart';
import 'package:starter_application/features/mylife/domain/entity/client_entity.dart';
import 'package:starter_application/features/mylife/domain/entity/quote_entity.dart';
import 'package:starter_application/features/mylife/domain/entity/story_entity.dart';
import 'package:starter_application/features/mylife/domain/entity/story_entity.dart';
import 'package:starter_application/features/mylife/domain/entity/task_entity.dart';

import '../../../../core/repositories/repository.dart';

abstract class IMylifeRepository extends Repository {
  Future<Result<AppErrors, TaskEntity>> getAllTasks(GetAllTasksRequest param);

  Future<Result<AppErrors, AppointmentEntity>> getAllAppointments(
      GetAppointmentRequest param);
  Future<Result<AppErrors, StoryEntity>> getStories(GetStoryRequest param);
  Future<Result<AppErrors, TaskItemEntity>> createTask(CreateTaskRequest param);

  Future<Result<AppErrors, AppointmentItemEntity>> createAppointment(
      CreateAppointmentRequest param);

  Future<Result<AppErrors, EmptyResponse>> checkTask(CheckTasksRequest param);
  Future<Result<AppErrors, EmptyResponse>> deleteItem(DeleteItemRequest param);
  Future<Result<AppErrors, EmptyResponse>> checkAppointment(
      CheckTasksRequest param);
  Future<Result<AppErrors, ImageUrlsEntity>> uploadImage(ImageParams params);

  Future<Result<AppErrors, DreamListEntity>> getAllDreams(NoParams param);

  Future<Result<AppErrors, PositiveListEntity>> getAllPositives(
      GetPositiveRequest param);

  Future<Result<AppErrors, ClientEntity>> getAllClients();

  Future<Result<AppErrors, DreamEntity>> createDream(CreateDreamParams param);

  Future<Result<AppErrors, PositiveEntity>> createPositive(
      CreatePositivesParams param);
  Future<Result<AppErrors, PositiveEntity>> updatePositive(
      CreatePositivesParams param);
  Future<Result<AppErrors, EmptyResponse>> deletePositive(
      DeleteItemRequest param);
  Future<Result<AppErrors, QuoteEntity>> getQuote(NoParams param);
  Future<Result<AppErrors, EmptyResponse>> checkUnCheckDream(CheckDreamParams param);
  Future<Result<AppErrors, EmptyResponse>> deleteDream(DeleteDreamParams param);
  Future<Result<AppErrors, StoryItemEntity>> getStory(GetStoryParams params);

  Future<Result<AppErrors, EmptyResponse>> updateAppointment(
      UpdateAppointmentRequest param);

}
