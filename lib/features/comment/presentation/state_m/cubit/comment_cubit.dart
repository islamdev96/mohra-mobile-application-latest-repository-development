import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/comment/data/model/request/comment_request.dart';
import 'package:starter_application/features/comment/data/model/request/get_comments_request.dart';
import 'package:starter_application/features/comment/domain/entity/comment_entity.dart';
import 'package:starter_application/features/comment/domain/entity/comments_entity.dart';
import 'package:starter_application/features/comment/domain/usecase/comment_usecase.dart';
import 'package:starter_application/features/comment/domain/usecase/get_comments_usecase.dart';

import '../../../../../core/errors/app_errors.dart';

part 'comment_cubit.freezed.dart';
part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit() : super(const CommentState.commentInitState());

  getComments(GetCommentsRequest params) async {
    emit(const CommentState.commentLoadingState());
    final result = await getIt<GetCommentsUseCase>().call(params);

    result.pick(
      onData: (data) => emit(CommentState.commentsLoadedState(data)),
      onError: (error) => emit(CommentState.commentErrorState(error, () {
        getComments(params);
      })),
    );
  }

  getMoreComments(GetCommentsRequest params) async {
    final result = await getIt<GetCommentsUseCase>().call(params);

    result.pick(
      onData: (data) => emit(CommentState.commentsLoadedState(data)),
      onError: (error) => emit(CommentState.commentErrorState(error, () {
        getComments(params);
      })),
    );
  }

  comment(CommentRequest params) async {
    emit(const CommentState.commentLoadingState());
    final result = await getIt<CommentUseCase>().call(params);

    result.pick(
      onData: (data) => emit(CommentState.commentCreatedState(data)),
      onError: (error) => emit(CommentState.commentErrorState(error, () {
        comment(params);
      })),
    );
  }
}
