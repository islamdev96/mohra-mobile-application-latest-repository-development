part of 'mylife_cubit.dart';

@freezed
class MylifeState with _$MylifeState {
  const factory MylifeState.mylifeInitState() = MylifeInitState;

  const factory MylifeState.mylifeLoadingState() = MylifeLoadingState;

  const factory MylifeState.checkTaskSuccess() = CheckTaskSuccess;
  const factory MylifeState.deleteItemSuccess() = DeleteItemSuccess;

  const factory MylifeState.taskLoadedSuccess(TaskEntity taskEntity) =
      TaskLoadedSuccess;

  const factory MylifeState.taskPerDayLoadedSuccess(TaskEntity taskEntity) =
  TaskPerDayLoadedSuccess;

  const factory MylifeState.imageUploaded(ImageUrlsEntity images) =
      ImageUploaded;

  const factory MylifeState.appointmentLoadedState(
      AppointmentEntity eventsEntity) = AppointmentLoadedState;

  const factory MylifeState.appointmentLoadedPerDayState(
      AppointmentEntity eventsEntity) = AppointmentLoadedPerDayState;

  const factory MylifeState.storiesLoadedState(StoryEntity storyEntity) =
      StoriesLoadedState;

  const factory MylifeState.clientLoadedState(ClientEntity eventsEntity) =
      ClientLoadedState;

  const factory MylifeState.createTaskSuccess(TaskItemEntity taskEntity) =
      CreateTaskSuccess;

  const factory MylifeState.createAppointmentSuccess(
      AppointmentItemEntity appointmentItem) = CreateAppointmentSuccess;

  const factory MylifeState.mylifeErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = MylifeErrorState;

  const factory MylifeState.dreamListLoaded(
    DreamListEntity dreamListEntity,
  ) = DreamListLoaded;
  const factory MylifeState.positivesListLoaded(
    PositiveListEntity dreamListEntity,
  ) = PositivesListLoaded;
  const factory MylifeState.dreamCreated(
    DreamEntity dreamEntity,
  ) = DreamCreated;

  const factory MylifeState.createDream() = CreateDream;
  const factory MylifeState.positiveCreated(
    PositiveEntity positiveEntity,
  ) = PositiveCreated;

  const factory MylifeState.qouteLoadedSuccess(
    QuoteEntity quoteEntity,
  ) = QouteLoadedSuccess;

  const factory MylifeState.checkDreamSuccess() = CheckDreamSuccess;
  const factory MylifeState.deleteDreamSuccess() = DeleteDreamSuccess;
  const factory MylifeState.storyLoaded(StoryItemEntity s) = StoryLoaded;

  const factory MylifeState.updateAppointmentSuccess() = UpdateAppointmentSuccess;
  const factory MylifeState.updateAppointmentLoading() = UpdateAppointmentLoading;

}
