import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/moment/data/model/request/create_post_param.dart';
import 'package:starter_application/features/moment/data/model/request/find_place_param.dart';
import 'package:starter_application/features/moment/data/model/request/get_all_moments_request.dart';
import 'package:starter_application/features/moment/data/model/request/get_client_points_request.dart';
import 'package:starter_application/features/moment/domain/entity/find_place_result_list_entity.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';
import 'package:starter_application/features/moment/domain/entity/points_entity.dart';
import 'package:starter_application/features/moment/domain/usecase/create_post_usecase.dart';
import 'package:starter_application/features/moment/domain/usecase/delete_post_usecase.dart';
import 'package:starter_application/features/moment/domain/usecase/edit_post_usecase.dart';
import 'package:starter_application/features/moment/domain/usecase/find_place_usecase.dart';
import 'package:starter_application/features/moment/domain/usecase/get_all_moments_usecase.dart';
import 'package:starter_application/features/moment/domain/usecase/get_points_usecase.dart';
import 'package:starter_application/features/moment/domain/usecase/report_post_usecase.dart';

import '../../../../../core/errors/app_errors.dart';
import '../../../data/model/request/delete_post_param.dart';
import '../../../data/model/request/report_post_param.dart';

part 'moment_cubit.freezed.dart';
part 'moment_state.dart';

class MomentCubit extends Cubit<MomentState> {
  MomentCubit() : super(const MomentState.momentInitState());

  void getMoments(GetMomentsRequest params) async {
    emit(const MomentState.momentLoadingState());

    final result = await getIt<GetMomentsUseCase>().call(params);
    result.pick(
      onData: (data) => emit(MomentState.momentsLoadedSuccess(data)),
      onError: (error) => emit(MomentState.momentErrorState(error, () {
        this.getMoments(params);
      }),),
    );
  }

  void getPoints(GetClientPointsRequest params) async {
    emit(const MomentState.momentLoadingState());

    final result = await getIt<GetPointsUseCase>().call(params);
    result.pick(
      onData: (data) => emit(MomentState.pointsLoadedSuccess(data)),
      onError: (error) => emit(MomentState.momentErrorState(error, () {
        this.getPoints(params);
      }),),
    );
  }

  void createPost(CreateEditPostParam params) async {
    emit(const MomentState.momentLoadingState());

    final result = await getIt<CreatePostUseCase>().call(params);
    result.pick(
      onData: (data) => emit(const MomentState.createPostLoaded()),
      onError: (error) => emit(MomentState.momentErrorState(error, () {
        this.createPost(params);
      }),),
    );
  }
  void editPost(CreateEditPostParam params) async {
    emit(const MomentState.momentLoadingState());

    final result = await getIt<EditPostUseCase>().call(params);
    result.pick(
      onData: (data) => emit(const MomentState.editPostLoaded()),
      onError: (error) =>emit( MomentState.momentErrorState(error, () {
        this.editPost(params);
      }),),
    );
  }

  void findPlace(FindPlaceParam params) async {
    emit(const MomentState.momentLoadingState());

    final result = await getIt<FindPlaceUseCase>().call(params);
    result.pick(
      onData: (data) => emit(MomentState.findPlaceLoaded(data)),
      onError: (error) => emit(MomentState.momentErrorState(error, () {
        this.findPlace(params);
      }),),
    );
  }
  void deletePost(DeletePostParam params) async {
    emit(const MomentState.momentLoadingState());

    final result = await getIt<DeletePostUseCase>().call(params);
    result.pick(
      onData: (data) => emit(const MomentState.deletePostSuccess()),
      onError: (error) =>emit( MomentState.momentErrorState(error, () {
        this.deletePost(params);
      }),),
    );
  }
  void reportPost(ReportPostParam params) async {
    emit(const MomentState.momentLoadingState());

    final result = await getIt<ReportPostUseCase>().call(params);
    result.pick(
      onData: (data) => emit(const MomentState.reportPostSuccess()),
      onError: (error) =>emit( MomentState.momentErrorState(error, () {
        this.reportPost(params);
      }),),
    );
  }


}
