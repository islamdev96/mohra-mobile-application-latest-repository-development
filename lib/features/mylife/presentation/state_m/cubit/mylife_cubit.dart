import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/di/service_locator.dart';
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
import 'package:starter_application/features/mylife/domain/entity/DreamListEntity.dart';
import 'package:starter_application/features/mylife/domain/entity/PositiveListEntity.dart';
import 'package:starter_application/features/mylife/domain/entity/appointment_entity.dart';
import 'package:starter_application/features/mylife/domain/entity/client_entity.dart';
import 'package:starter_application/features/mylife/domain/entity/quote_entity.dart';
import 'package:starter_application/features/mylife/domain/entity/story_entity.dart';
import 'package:starter_application/features/mylife/domain/entity/task_entity.dart';
import 'package:starter_application/features/mylife/domain/usecase/check_appointments.dart';
import 'package:starter_application/features/mylife/domain/usecase/check_task_uescase.dart';
import 'package:starter_application/features/mylife/domain/usecase/check_un_check_dream_usecase.dart';
import 'package:starter_application/features/mylife/domain/usecase/create_appointment_usecase.dart';
import 'package:starter_application/features/mylife/domain/usecase/create_dream_usecase.dart';
import 'package:starter_application/features/mylife/domain/usecase/create_positive_usecase.dart';
import 'package:starter_application/features/mylife/domain/usecase/create_task_usecase.dart';
import 'package:starter_application/features/mylife/domain/usecase/delete_dream_usecase.dart';
import 'package:starter_application/features/mylife/domain/usecase/delete_item_usecase.dart';
import 'package:starter_application/features/mylife/domain/usecase/delete_positive_usecase.dart';
import 'package:starter_application/features/mylife/domain/usecase/get_all_tasks_usecase.dart';
import 'package:starter_application/features/mylife/domain/usecase/get_appointments.dart';
import 'package:starter_application/features/mylife/domain/usecase/get_clients_usecase.dart';
import 'package:starter_application/features/mylife/domain/usecase/get_dreams_usecase.dart';
import 'package:starter_application/features/mylife/domain/usecase/get_positives_usecase.dart';
import 'package:starter_application/features/mylife/domain/usecase/get_quote_usecase.dart';
import 'package:starter_application/features/mylife/domain/usecase/get_stories_uescase.dart';
import 'package:starter_application/features/mylife/domain/usecase/get_story_usecase.dart';
import 'package:starter_application/features/mylife/domain/usecase/update_appointment_usecase.dart';
import 'package:starter_application/features/mylife/domain/usecase/upload_image_usecase.dart';

import '../../../../../core/errors/app_errors.dart';

part 'mylife_cubit.freezed.dart';
part 'mylife_state.dart';

class MylifeCubit extends Cubit<MylifeState> {
  MylifeCubit() : super(const MylifeState.mylifeInitState());

  void getTasks(GetAllTasksRequest params,{bool withLoading = true}) async {
    if(withLoading)
    emit(const MylifeState.mylifeLoadingState());
    final result = await getIt<GetTasksUseCase>().call(params);
    result.pick(
      onData: (data) => emit(MylifeState.taskLoadedSuccess(data)),
      onError: (error) => MylifeState.mylifeErrorState(error, () {
        this.getTasks(params);
      }),
    );
  }

  void getTasksPerDay(GetAllTasksRequest params) async {
    emit(const MylifeState.mylifeLoadingState());
    final result = await getIt<GetTasksUseCase>().call(params);
    result.pick(
      onData: (data) => emit(MylifeState.taskPerDayLoadedSuccess(data)),
      onError: (error) => MylifeState.mylifeErrorState(error, () {
        this.getTasks(params);
      }),
    );
  }

  void getAppointments(GetAppointmentRequest params,{bool withLoading = true}) async {
    if(withLoading)
    emit(const MylifeState.mylifeLoadingState());

    final result = await getIt<GetAppointmentsUseCase>().call(params);
    result.pick(
      onData: (data) => emit(MylifeState.appointmentLoadedState(data)),
      onError: (error) => MylifeState.mylifeErrorState(error, () {
        this.getAppointments(params);
      }),
    );
  }

  void getAppointmentsPerDay(GetAppointmentRequest params,{bool withLoading = true}) async {
    if(withLoading)
    emit(const MylifeState.mylifeLoadingState());

    final result = await getIt<GetAppointmentsUseCase>().call(params);
    result.pick(
      onData: (data) => emit(MylifeState.appointmentLoadedPerDayState(data)),
      onError: (error) => MylifeState.mylifeErrorState(error, () {
        this.getAppointments(params);
      }),
    );
  }

  void getPositives(GetPositiveRequest params,{bool withLoading = true}) async {
    if(withLoading)
    emit(const MylifeState.mylifeLoadingState());

    final result = await getIt<GetPositivesUseCase>().call(params);
    result.pick(
      onData: (data) => emit(MylifeState.positivesListLoaded(data)),
      onError: (error) => MylifeState.mylifeErrorState(error, () {
        this.getPositives(params);
      }),
    );
  }

  void getClients(NoParams params) async {
    emit(const MylifeState.mylifeLoadingState());

    final result = await getIt<GetClientsUseCase>().call(params);
    result.pick(
      onData: (data) => emit(MylifeState.clientLoadedState(data)),
      onError: (error) => MylifeState.mylifeErrorState(error, () {
        this.getClients(params);
      }),
    );
  }

  void createTask(CreateTaskRequest params) async {
    emit(const MylifeState.mylifeLoadingState());
    final result = await getIt<CreateTaskUseCase>().call(params);
    result.pick(
      onData: (data) => emit(MylifeState.createTaskSuccess(data)),
      onError: (error) => MylifeState.mylifeErrorState(error, () {
        this.createTask(params);
      }),
    );
  }

  void uploadImage(ImageParams params) async {
    emit(const MylifeState.mylifeLoadingState());
    final result = await getIt<UploadImageUsecase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(MylifeState.imageUploaded(data)),
      onError: (error) => emit(
        MylifeState.mylifeErrorState(error, () => this.uploadImage(params)),
      ),
    );
  }

  void createAppointment(CreateAppointmentRequest params) async {
    emit(const MylifeState.mylifeLoadingState());
    final result = await getIt<CreateAppointmentUseCase>().call(params);
    result.pick(
      onData: (data) => emit(MylifeState.createAppointmentSuccess(data)),
      onError: (error) => MylifeState.mylifeErrorState(error, () {
        this.createAppointment(params);
      }),
    );
  }

  void checkTask(CheckTasksRequest params) async {
    emit(const MylifeState.mylifeLoadingState());
    final result = await getIt<CheckTaskUseCase>().call(params);
    result.pick(
      onData: (data) => emit(const MylifeState.checkTaskSuccess()),
      onError: (error) => MylifeState.mylifeErrorState(error, () {
        this.checkTask(params);
      }),
    );
  }

  void deleteItem(DeleteItemRequest params) async {
    emit(const MylifeState.mylifeLoadingState());
    final result = await getIt<DeleteItemUseCase>().call(params);
    result.pick(
      onData: (data) => emit(const MylifeState.deleteItemSuccess()),
      onError: (error) => MylifeState.mylifeErrorState(error, () {
        this.deleteItem(params);
      }),
    );
  }

  void checkAppointment(CheckTasksRequest params) async {
    emit(const MylifeState.mylifeLoadingState());
    final result = await getIt<CheckAppointmentUseCase>().call(params);
    result.pick(
      onData: (data) => emit(const MylifeState.checkTaskSuccess()),
      onError: (error) => MylifeState.mylifeErrorState(error, () {
        this.checkAppointment(params);
      }),
    );
  }

  void getAllDreams(NoParams params,{bool withLoading = true}) async {
    if(withLoading)
    emit(const MylifeState.mylifeLoadingState());
    final result = await getIt<GetDreamsUseCase>().call(params);
    result.pick(
      onData: (data) => emit(MylifeState.dreamListLoaded(data)),
      onError: (error) => MylifeState.mylifeErrorState(error, () {
        this.getAllDreams(params);
      }),
    );
  }

  void createDream(CreateDreamParams params) async {
    emit(const MylifeState.createDream());
    final result = await getIt<CreateDreamUsecase>()(params);
    result.pick(
      onData: (data) => emit(MylifeState.dreamCreated(data)),
      onError: (error) => emit(
        MylifeState.mylifeErrorState(error, () => this.createDream(params)),
      ),
    );
  }

  void createPositive(CreatePositivesParams params) async {
    emit(const MylifeState.createDream());
    final result = await getIt<CreatePositiveUsecase>()(params);
    result.pick(
      onData: (data) => emit(MylifeState.positiveCreated(data)),
      onError: (error) => emit(
        MylifeState.mylifeErrorState(error, () => this.createPositive(params)),
      ),
    );
  }

  void getQuote(NoParams params,{bool withLoading = true}) async {
    if(withLoading)
    emit(const MylifeState.mylifeLoadingState());
    final result = await getIt<GetQuoteUseCase>().call(params);
    print("pooo${result.data}");
    result.pick(
      onData: (data) => emit(MylifeState.qouteLoadedSuccess(data)),
      onError: (error) => MylifeState.mylifeErrorState(error, () {
        this.getQuote(params);
      }),
    );
  }

  void getStories(GetStoryRequest params,{bool withLoading = true}) async {
    if(withLoading)
    emit(const MylifeState.mylifeLoadingState());

    final result = await getIt<GetStoriesUseCase>().call(params);
    result.pick(
      onData: (data) => emit(MylifeState.storiesLoadedState(data)),
      onError: (error) => MylifeState.mylifeErrorState(error, () {
        this.getStories(params);
      }),
    );
  }

  void checkDream(CheckDreamParams params) async {
    // emit(const MylifeState.mylifeLoadingState());
    final result = await getIt<CheckDreamUsecase>().call(params);
    result.pick(
      onData: (data) => emit(const MylifeState.checkDreamSuccess()),
      onError: (error) => MylifeState.mylifeErrorState(error, () {
        this.checkDream(params);
      }),
    );
  }

  void deleteDream(DeleteDreamParams params) async {
    // emit(const MylifeState.mylifeLoadingState());
    final result = await getIt<DeleteDreamUsecase>().call(params);
    result.pick(
      onData: (data) => emit(const MylifeState.deleteDreamSuccess()),
      onError: (error) => MylifeState.mylifeErrorState(error, () {
        this.deleteDream(params);
      }),
    );
  }

  void deletePositive(DeleteItemRequest params) async {
    emit(const MylifeState.mylifeLoadingState());
    final result = await getIt<DeletePositiveUsecase>().call(params);
    result.pick(
      onData: (data) {
        var temp = DateTime.parse(DateTime.now().toString() + 'Z');
        emit(const MylifeState.deleteDreamSuccess());
        getPositives(GetPositiveRequest(Date: temp));
        },
      onError: (error) => MylifeState.mylifeErrorState(error, () {
        this.deletePositive(params);
      }),
    );
  }


  void getStory(GetStoryParams params) async {
    emit(const MylifeState.mylifeLoadingState());

    final result = await getIt<GetStoryUseCase>().call(params);
    result.pick(
      onData: (data) => emit(MylifeState.storyLoaded(data)),
      onError: (error) => MylifeState.mylifeErrorState(error, () {
        this.getStory(params);
      }),
    );
  }

  void updateAppointment(UpdateAppointmentRequest params) async {
    emit(const MylifeState.updateAppointmentLoading());

    final result = await getIt<UpdateAppointmentUseCase>().call(params);
    result.pick(
      onData: (data) => emit(MylifeState.updateAppointmentSuccess()),
      onError: (error) => MylifeState.mylifeErrorState(error, () {
        this.updateAppointment(params);
      }),
    );
  }

}
