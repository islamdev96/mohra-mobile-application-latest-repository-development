import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/like/data/model/request/like_request.dart';
import 'package:starter_application/features/like/domain/entity/like_entity.dart';
import 'package:starter_application/features/like/domain/usecase/like_usecase.dart';
import 'package:starter_application/features/like/domain/usecase/unlike_usecase.dart';

import '../../../../../core/errors/app_errors.dart';

part 'like_cubit.freezed.dart';
part 'like_state.dart';

class LikeCubit extends Cubit<LikeState> {
  LikeCubit() : super(const LikeState.likeInitState());

  like(LikeRequest params) async {
    emit(const LikeState.likeLoadingState());
    final result = await getIt<LikeActionUseCase>().call(params);

    result.pick(
      onData: (data) => emit(LikeState.likeCreatedState(data)),
      onError: (error) => emit(LikeState.likeErrorState(error, () {
        like(params);
      })),
    );
  }

  unlike(LikeRequest params) async {
    emit(const LikeState.likeLoadingState());
    final result = await getIt<UnlikeUseCase>().call(params);

    result.pick(
      onData: (data) => emit(LikeState.unlikeCreatedState(data)),
      onError: (error) => emit(LikeState.likeErrorState(error, () {
        unlike(params);
      })),
    );
  }
}
