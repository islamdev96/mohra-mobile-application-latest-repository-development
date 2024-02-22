import 'package:flutter/cupertino.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/datasources/shared_preference.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_error_snackbar.dart';
import 'package:starter_application/features/health/data/model/request/answer_params.dart';
import 'package:starter_application/features/health/domain/entity/question_entity.dart';
import 'package:starter_application/features/health/presentation/screen/calculating_health_result_screen.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/home/presentation/screen/app_main_screen.dart';
import 'package:starter_application/features/home/presentation/screen/home_screen/home_screen.dart';

class EatingHabitsScreenNotifier extends ScreenNotifier {
  /// Variables
  /// For Now id = index
  final healthCubit = HealthCubit();

  late QuestionsEntity questionsEntity;
  late int questionNumbers;
  List<int> _answersIds = [];
  List<int> apiAnswersIds = [];
  int _currentPage = 0;


  List<EatingQuestion> questions = [];

  /// Methods
  void addAnswer(int qId, int Aid) {
    if (_answersIds.length > currentPage) {
      _answersIds[currentPage] = Aid;
      apiAnswersIds.add(questionsEntity.result[qId].choices[Aid].id);
    } else {
      _answersIds.insert(currentPage, Aid);
      apiAnswersIds.add(questionsEntity.result[qId].choices[Aid].id);
    }
    notifyListeners();
  }


  /// Getters and Setters
  List<int> get answersId => this._answersIds;
  get currentPage => this._currentPage;

  bool isLastPage(int pageIndex) => pageIndex == (questionNumbers - 1);

  /// User can complete if he answered all the questions
  bool get canComplete => _answersIds.length == questionNumbers;
  set currentPage(value) {
    this._currentPage = value;
    notifyListeners();
  }

  void onContinueTap(PageController controller) async{
    if (canContinue(currentPage)) {
      if (!isLastPage(currentPage))
        controller.animateToPage(
          currentPage + 1,
          duration: const Duration(
            milliseconds: 600,
          ),
          curve: Curves.ease,
        );
      else {
        //todo: save answer in api and in local storage
        AnswerParams params = AnswerParams();
        params.choices = apiAnswersIds;
        healthCubit.answerQuestion(params);

      }
    } else {
      showErrorSnackBar(message: "Please answer the question");
    }
  }

  onAnswerQuestionDone() async{
    var sp = await SpUtil.getInstance();
    sp.putBool(AppConstants.HEALTH_QUESTION_ANSWER_DONE, true);
    Nav.toAndPopUntil(CalculatingHealthResultScreen.routeName,AppMainScreen.routeName);
  }

  bool canContinue(int page) {
    return getSelectedChoiceId(page) != null;
  }
  int? getSelectedChoiceId(int page) {
    return _answersIds.length > page ? _answersIds[page] : null;
  }


  getAllQuestion(){
    healthCubit.getAllQuesions(NoParams());
  }

  onQuestionLoaded(QuestionsEntity questionsEntity){
    this.questionsEntity = questionsEntity;
    questionNumbers=questionsEntity.result.length;
    generateUiData();
    notifyListeners();
  }

  generateUiData(){
    questionsEntity.result.forEach((element) {
      EatingQuestion eatingQuestion = EatingQuestion(
        element.question,
      );
      List<String> tempChoices = [];
      List<int> tempIds = [];
      element.choices.forEach((element) {
        tempChoices.add(element.content!);
        tempIds.add(element.id);
      });
      eatingQuestion.choices = tempChoices;
      eatingQuestion.ids = tempIds;
      questions.add(eatingQuestion);
    });
  }


  @override
  void closeNotifier() {}

  List<int> get answersIds => _answersIds;


}

class EatingQuestion {
    String title;
    late List<String> choices;
    late List<int> ids;

  EatingQuestion(this.title);
}

