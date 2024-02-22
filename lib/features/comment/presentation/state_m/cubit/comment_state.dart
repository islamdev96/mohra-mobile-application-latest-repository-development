part of 'comment_cubit.dart';

@freezed
class CommentState with _$CommentState {
  const factory CommentState.commentInitState() = CommentInitState;

  const factory CommentState.commentLoadingState() = CommentLoadingState;

  const factory CommentState.commentErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = CommentErrorState;

  const factory CommentState.commentsLoadedState(
      CommentsEntity commentsEntity) = CommentsLoadedState;
  const factory CommentState.commentCreatedState(CommentEntity commentEntity) =
      CommentCreatedState;
}
