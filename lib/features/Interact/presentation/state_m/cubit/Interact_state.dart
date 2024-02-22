part of 'Interact_cubit.dart';

@freezed
class InteractState with _$InteractState {
  const factory InteractState.interactInitState() = InteractInitState;

  const factory InteractState.interactLoadingState() = InteractLoadingState;

  const factory InteractState.interactErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = InteractErrorState;
  const factory InteractState.interactCreatedState(
      InteractionsEntity likeEntity) = InteractCreatedState;

  const factory InteractState.interactDeletedState() = InteractDeletedState;

  const factory InteractState.interactListLoaded(GetInteractionListEntity getInteractionListEntity) = InteractListLoaded;
}
