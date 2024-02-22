part of 'moment_cubit.dart';

@freezed
class MomentState with _$MomentState {
  const factory MomentState.momentInitState() = MomentInitState;

  const factory MomentState.momentLoadingState() = MomentLoadingState;

  const factory MomentState.momentErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = MomentErrorState;

  const factory MomentState.momentsLoadedSuccess(MomentEntity momentEntity) =
      MomentsLoadedSuccess;
  const factory MomentState.pointsLoadedSuccess(PointsEntity pointsEntity) =
      PointsLoadedSuccess;
  const factory MomentState.createPostLoaded() =
      CreatePostLoaded;
  const factory MomentState.editPostLoaded() =
      EditPostLoaded;
  const factory MomentState.findPlaceLoaded(FindPlaceResultListEntity results) =
      FindPlaceLoaded;
  const factory MomentState.deletePostSuccess() =
  DeletePostSuccess;
  const factory MomentState.reportPostSuccess() =
  ReportPostSuccess;
    
}
