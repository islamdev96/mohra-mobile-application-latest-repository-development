import 'package:injectable/injectable.dart';
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
import 'package:starter_application/features/mylife/data/model/response/story_model.dart';
import 'package:starter_application/features/mylife/domain/entity/DreamListEntity.dart';
import 'package:starter_application/features/mylife/domain/entity/PositiveListEntity.dart';
import 'package:starter_application/features/mylife/domain/entity/appointment_entity.dart';
import 'package:starter_application/features/mylife/domain/entity/client_entity.dart';
import 'package:starter_application/features/mylife/domain/entity/quote_entity.dart';
import 'package:starter_application/features/mylife/domain/entity/story_entity.dart';
import 'package:starter_application/features/mylife/domain/entity/task_entity.dart';
import '../datasource/../../domain/repository/imylife_repository.dart';
import '../datasource/imylife_remote.dart';
import 'package:starter_application/core/common/extensions/either_error_model_extension.dart';

@Singleton(as: IMylifeRepository)
class MylifeRepository extends IMylifeRepository {
  final IMylifeRemoteSource iMylifeRemoteSource;

  MylifeRepository(this.iMylifeRemoteSource);

  @override
  Future<Result<AppErrors, TaskEntity>> getAllTasks(
      GetAllTasksRequest param) async {
    final remoteResult = await iMylifeRemoteSource.getTasks(param);
    return remoteResult.result<TaskEntity>();
  }

  @override
  Future<Result<AppErrors, AppointmentEntity>> getAllAppointments(
      GetAppointmentRequest param) async {
    final remoteResult = await iMylifeRemoteSource.getAppointments(param);
    return remoteResult.result<AppointmentEntity>();
  }

  @override
  Future<Result<AppErrors, ClientEntity>> getAllClients() async {
    final remoteResult = await iMylifeRemoteSource.getClients();
    return remoteResult.result<ClientEntity>();
  }

  @override
  Future<Result<AppErrors, ImageUrlsEntity>> uploadImage(
      ImageParams params) async {
    final remote = await iMylifeRemoteSource.uploadImage(params);
    return remote.result<ImageUrlsEntity>();
  }

  @override
  Future<Result<AppErrors, TaskItemEntity>> createTask(
      CreateTaskRequest param) async {
    final remoteResult = await iMylifeRemoteSource.createTask(param);
    return remoteResult.result<TaskItemEntity>();
  }

  @override
  Future<Result<AppErrors, AppointmentItemEntity>> createAppointment(
      CreateAppointmentRequest param) async {
    final remoteResult = await iMylifeRemoteSource.createAppointment(param);
    return remoteResult.result<AppointmentItemEntity>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> checkTask(
      CheckTasksRequest param) async {
    final remoteResult = await iMylifeRemoteSource.checkTask(param);
    return remoteResult.result<EmptyResponse>();
  }
  @override
  Future<Result<AppErrors, EmptyResponse>> deleteItem(
      DeleteItemRequest param) async {
    final remoteResult = await iMylifeRemoteSource.deleteItem(param);
    return remoteResult.result<EmptyResponse>();
  }
  @override
  Future<Result<AppErrors, EmptyResponse>> checkAppointment(
      CheckTasksRequest param) async {
    final remoteResult = await iMylifeRemoteSource.checkAppointment(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, DreamListEntity>> getAllDreams(
      NoParams param) async {
    final remoteResult = await iMylifeRemoteSource.getAllDreams(param);
    return remoteResult.result<DreamListEntity>();
  }

  @override
  Future<Result<AppErrors, PositiveListEntity>> getAllPositives(
      GetPositiveRequest param) async {
    final remoteResult = await iMylifeRemoteSource.getAllPositive(param);
    return remoteResult.result<PositiveListEntity>();
  }

  @override
  Future<Result<AppErrors, DreamEntity>> createDream(
      CreateDreamParams param) async {
    final remoteResult = await iMylifeRemoteSource.createDream(param);
    return remoteResult.result<DreamEntity>();
  }

  @override
  Future<Result<AppErrors, PositiveEntity>> createPositive(
      CreatePositivesParams param) async {
    final remoteResult = await iMylifeRemoteSource.createPositive(param);
    return remoteResult.result<PositiveEntity>();
  }

  @override
  Future<Result<AppErrors, QuoteEntity>> getQuote(NoParams param) async {
    final remoteResult = await iMylifeRemoteSource.getQuote();
    return remoteResult.result<QuoteEntity>();
  }

  @override
  Future<Result<AppErrors, StoryEntity>> getStories(
      GetStoryRequest param) async {
    final remoteResult = await iMylifeRemoteSource.getStories(param);
    return remoteResult.result<StoryEntity>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> checkUnCheckDream(CheckDreamParams param) async {
    final remoteResult = await iMylifeRemoteSource.checkUnCheckDream(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> deleteDream(DeleteDreamParams param) async {
    final remoteResult = await iMylifeRemoteSource.deleteDream(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, StoryItemEntity>> getStory(GetStoryParams params) async {
    final remoteResult = await iMylifeRemoteSource.getStory(params);
    return remoteResult.result<StoryItemEntity>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> updateAppointment(UpdateAppointmentRequest param) async {
    final remoteResult = await iMylifeRemoteSource.updateAppointment(param);
    return remoteResult.result<EmptyResponse>();
  }


  @override
  Future<Result<AppErrors, EmptyResponse>> deletePositive(
      DeleteItemRequest param) async {
    final remoteResult = await iMylifeRemoteSource.deletePositive(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, PositiveEntity>> updatePositive(
      CreatePositivesParams param) async {
    final remoteResult = await iMylifeRemoteSource.createPositive(param);
    return remoteResult.result<PositiveEntity>();
  }

}
