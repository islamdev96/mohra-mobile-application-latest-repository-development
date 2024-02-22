part of 'like_cubit.dart';

@freezed
class LikeState with _$LikeState {
  const factory LikeState.likeInitState() = LikeInitState;

  const factory LikeState.likeLoadingState() = LikeLoadingState;

  const factory LikeState.likeErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = LikeErrorState;

  const factory LikeState.likeCreatedState(LikeEntity likeEntity) =
      LikeCreatedState;
  const factory LikeState.unlikeCreatedState(EmptyResponse emptyResponse) =
      UnlikeCreatedState;
}
