part of 'help_cubit.dart';

@freezed
class HelpState with _$HelpState {
  const factory HelpState.helpInitState() = HelpInitState;

  const factory HelpState.helpLoadingState() = HelpLoadingState;

  const factory HelpState.helpErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = HelpErrorState;
  const factory HelpState.faqListLoaded(FaqListEntity entity) = FaqListLoadedState;
  const factory HelpState.getAboutUsLoaded(AboutUsEntity entity) = GetAboutUsLoaded;
  const factory HelpState.reasonsListLoaded(ReasonsListEntity entity) = ReasonsListLoadedState;

  const factory HelpState.createContactUsTicketLoading() = CreateContactUsTicketLoading;
  const factory HelpState.createContactUsTicketLoaded() = CreateContactUsTicketLoaded;

}
