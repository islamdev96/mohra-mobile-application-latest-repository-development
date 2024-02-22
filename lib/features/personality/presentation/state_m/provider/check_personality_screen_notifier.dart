import 'package:flutter/cupertino.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/datasources/shared_preference.dart';
import 'package:starter_application/core/localization/flutter_localization.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/params/screen_params/personality_result_screen_params.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_error_snackbar.dart';
import 'package:starter_application/features/mylife/presentation/logic/date_time_helper.dart';
import 'package:starter_application/features/personality/data/model/request/personalityAnswers.dart';
import 'package:starter_application/features/personality/domain/entity/personality_question_entity.dart';
import 'package:starter_application/features/personality/presentation/screen/personality_details_screen.dart';
import 'package:starter_application/features/personality/presentation/screen/presonality_result_screen.dart';
import 'package:starter_application/features/personality/presentation/state_m/cubit/personality_cubit.dart';
import 'package:starter_application/features/user/data/model/request/update_profile_params.dart';
import 'package:starter_application/features/user/domain/entity/update_profile_entity.dart';
import 'package:starter_application/features/user/presentation/state_m/cubit/user_cubit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:starter_application/generated/l10n.dart';
import 'package:starter_application/main.dart';

class CheckPersonalityScreenNotifier extends ScreenNotifier {
  /// Variables
  /// For Now id = index

  final userCubit = UserCubit();
  final personalityCubit = PersonalityCubit();
  late PersonalityQuestionListEntity personalityQuestionListEntity;
  late SavePersonaliityAnswers savePersonaliityAnswers =
      SavePersonaliityAnswers();
  List<PersonalityQuestion> personalityQuestions = [];
  int _currentPage = 0;
  List<NewAnswerModel> newAnswers = [];

  /// Methods
  /* void addAnswer(int id, PageController controller) {

    if (_answersIds.length > currentPage)
      _answersIds[currentPage] = id;
    else {
      _answersIds.insert(currentPage, id);
      if (!isLastPage(currentPage))
        controller.animateToPage(
          currentPage + 1,
          duration: const Duration(
            milliseconds: 600,
          ),
          curve: Curves.ease,
        );
    }
    print(_answersIds);
    notifyListeners();
  }*/

  void addAnswerTwo(
      int questionIndex, int choiceIndex, PageController controller) {
    if (newAnswers.isEmpty) {
      NewAnswerModel newAnswerModel = NewAnswerModel();
      newAnswerModel.questionIndex = questionIndex;
      newAnswerModel.choiceIndex = choiceIndex;
      newAnswers.add(newAnswerModel);
      if (!isLastPage(currentPage))
        controller.animateToPage(
          currentPage + 1,
          duration: const Duration(
            milliseconds: 600,
          ),
          curve: Curves.ease,
        );
    } else {
      for (NewAnswerModel newAnswerModel in newAnswers) {
        if (newAnswerModel.questionIndex == questionIndex) {
          newAnswerModel.choiceIndex = choiceIndex;
          print(newAnswers);
          notifyListeners();
          return;
        }
      }
      NewAnswerModel newAnswerModel = NewAnswerModel();
      newAnswerModel.questionIndex = questionIndex;
      newAnswerModel.choiceIndex = choiceIndex;
      newAnswers.add(newAnswerModel);
      if (!isLastPage(currentPage))
        controller.animateToPage(
          currentPage + 1,
          duration: const Duration(
            milliseconds: 600,
          ),
          curve: Curves.ease,
        );
    }
    print(newAnswers);
    notifyListeners();
  }

  void onCompleteTap() {
    if (canCompletNew()) {
      for (int i = 0; i < newAnswers.length; i++) {
        if (personalityQuestionListEntity
                .questions[newAnswers[i].questionIndex!].id !=
            -1) {
          AnswermModelRequest answerModelRequest = AnswermModelRequest(
              questionId: personalityQuestionListEntity
                  .questions[newAnswers[i].questionIndex!].id,
              choiceId: personalityQuestionListEntity
                  .questions[newAnswers[i].questionIndex!]
                  .choices[newAnswers[i].choiceIndex!]
                  .id);
          savePersonaliityAnswers.answers.add(answerModelRequest);
        }
      }
      print(savePersonaliityAnswers.answers);
      savePersonalityQuestion();
    } else {
      showErrorSnackBar(
          message: Translation.current.answer_all_personality_question);
    }
  }

  savePersonalityQuestion() {
    personalityCubit.saveAnswers(savePersonaliityAnswers);
  }

  onAnswersSaved() {
    updateGender();
  }

  updateGender() {
    personalityCubit.updateProfile(UpdateProfileParams(
      name: UserSessionDataModel.name,
      imageUrl: UserSessionDataModel.imageUrl,
      gender: getGenderQuestion(),
      date:
          DateTimeHelper.getStringDateInEnglish(UserSessionDataModel.birthday),
      coverImage: UserSessionDataModel.coverPhoto,
      email: UserSessionDataModel.emailAddress,
      surName: UserSessionDataModel.surname,
      phoneNumber: UserSessionDataModel.phoneNumber,
    ));
  }

  onGenderUpdated(UpdateProfileEntity profileEntity) async {
    print('aaaaaaaaaa');
    print(getGenderQuestion());
    UserSessionDataModel.updateProfileSP(
        profileEntity.name!,
        profileEntity.surname!,
        profileEntity.fullName!,
        UserSessionDataModel.birthday,
        getGenderQuestion(),
        profileEntity.imageUrl ?? null,
        profileEntity.emailAddress!,
        profileEntity.avatarMonth!);
    final prefs = await SpUtil.getInstance();
    prefs.putBool(AppConstants.HAS_PERSONALITY_AVATAR, true);
    Nav.toAndRemoveAll(PersonalityDetailsScreen.routeName,
        arguments: PersonalityResultScreenParams(
          birthDay: UserSessionDataModel?.birthday != ''
              ? DateTime.parse(UserSessionDataModel.birthday)
              : null,
          gender: getGenderQuestion(),
        ));
  }

  getGenderQuestion() {
    for (int i = 0; i < newAnswers.length; i++) {
      if (personalityQuestionListEntity
              .questions[newAnswers[i].questionIndex!].id ==
          -1) {
        return personalityQuestionListEntity
            .questions[newAnswers[i].questionIndex!]
            .choices[newAnswers[i].choiceIndex!]
            .id;
      }
    }
  }

  getQuestions() {
    personalityCubit.getQuestions(NoParams());
  }

  onQuestionLoaded(PersonalityQuestionListEntity entity) {
    this.personalityQuestionListEntity = entity;
    this.personalityQuestionListEntity.questions.reversed.toList();
    PersonalityQuestionEntity personalityQuestionEntity =
        PersonalityQuestionEntity(
      id: -1,
      type: 0,
      arContent: 'ما هو جنسك؟',
      enContent: 'What is your gender?',
      order: 1,
      content: !isArabic ? 'What is your gender?' : 'ما هو جنسك؟',
      choices: [],
    );
    List<PersonalityChoiceEntity> choices = [];
    PersonalityChoiceEntity male = PersonalityChoiceEntity(
      id: 1,
      arContent: 'ذكر',
      enContent: 'Male',
      imageUrl: 'assets/images/png/Personality_male.png',
    );
    PersonalityChoiceEntity female = PersonalityChoiceEntity(
      id: 2,
      arContent: 'أنثى',
      enContent: 'Female',
      imageUrl: 'assets/images/png/Personality_female.png',
    );
    choices.add(female);
    choices.add(male);
    personalityQuestionEntity.choices = choices;
    this
        .personalityQuestionListEntity
        .questions
        .insert(0, personalityQuestionEntity);
    generateUiData();
    notifyListeners();
  }

  generateUiData() {
    this.personalityQuestionListEntity.questions.forEach((element) {
      List<PersonalityChoice> tempChoices = [];
      element.choices.forEach((element) {
        PersonalityChoice tempChoice = PersonalityChoice(
          element.imageUrl,
          element.enContent,
          element.arContent,
        );
        tempChoices.add(tempChoice);
      });

      PersonalityQuestion tempQuestion = PersonalityQuestion(element.content, 1,
          tempChoices, element.arContent, element.enContent);
      this.personalityQuestions.add(tempQuestion);
    });
  }

  canCompletNew() {
    for (NewAnswerModel newAnswerModel in newAnswers) {
      if (newAnswerModel.questionIndex == 0) {
        return true;
      }
    }
    return false;
  }

  @override
  void closeNotifier() {}

  int get questionNumbers => personalityQuestions.length;

  double get completionPercent =>
      questionNumbers == 0 ? 0 : newAnswers.length / questionNumbers;

  get currentPage => this._currentPage;

  bool isLastPage(int pageIndex) => pageIndex == (questionNumbers - 1);

  set currentPage(value) {
    this._currentPage = value;
    notifyListeners();
  }

  getSelectedChoice(int index) {
    if (newAnswers.isEmpty) {
      return null;
    } else {
      for (NewAnswerModel newAnswerModel in newAnswers) {
        if (newAnswerModel.questionIndex == index) {
          return newAnswerModel.choiceIndex;
        }
      }
      return null;
    }
  }
}

class PersonalityQuestion {
  final String question;
  final String arQuestion;
  final String enQuestion;

  /// Width to height ratio
  final double ratio;
  final List<PersonalityChoice> choices;

  PersonalityQuestion(
    this.question,
    this.ratio,
    this.choices,
    this.arQuestion,
    this.enQuestion,
  );
}

class PersonalityChoice {
  final String image;
  final String enContent;
  final String arContent;

  PersonalityChoice(this.image, this.enContent, this.arContent);
}

class NewAnswerModel {
  int? questionIndex;
  int? choiceIndex;

  @override
  String toString() {
    return 'NewAnswerModel{questionIndex: $questionIndex, choiceIndex: $choiceIndex}';
  }
}
