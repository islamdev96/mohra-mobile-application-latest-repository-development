part of 'personality_cubit.dart';

@freezed
class PersonalityState with _$PersonalityState {
  const factory PersonalityState.personalityInitState() = PersonalityInitState;

  const factory PersonalityState.personalityLoadingState() =
      PersonalityLoadingState;

  const factory PersonalityState.personalityErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = PersonalityErrorState;

  const factory PersonalityState.getQuestion() = GetQuestion;

  const factory PersonalityState.questionLoaded(
      PersonalityQuestionListEntity personalityQuestionListEntity
      ) = QuestionLoaded;

  const factory PersonalityState.avatarLoaded(
      AvatarListEntity avatarListEntity
      ) = AvatarLoaded;

  const factory PersonalityState.hasAvatarChecked(
      HasAvatarEntity hasAvatarEntity
      ) = HasAvatarChecked;

  const factory PersonalityState.saveAnswers() = SaveAnswers;
  const factory PersonalityState.answersSavedDone() = AnswersSavedDone;

  const factory PersonalityState.updateProfile(
      ) = UpdateProfile;

  const factory PersonalityState.updateProfileDone(
      UpdateProfileEntity updateProfileEntity
      ) = UpdateProfileDone;

}
