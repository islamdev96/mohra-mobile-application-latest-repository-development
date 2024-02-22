import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/interfaces/on_refresh_data.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/features/like/presentation/state_m/cubit/like_cubit.dart';

// ignore: unused_import
import 'package:starter_application/features/messages/presentation/widgets/show_dilog.dart';
import 'package:starter_application/features/mylife/data/model/request/check_dream_params.dart';
import 'package:starter_application/features/mylife/data/model/request/check_tast_request.dart';
import 'package:starter_application/features/mylife/data/model/request/get_all_tasks_request.dart';
import 'package:starter_application/features/mylife/data/model/request/get_appointment_request.dart';
import 'package:starter_application/features/mylife/data/model/request/get_positive_request.dart';
import 'package:starter_application/features/mylife/data/model/request/get_stories_request.dart';
import 'package:starter_application/features/mylife/domain/entity/DreamListEntity.dart';
import 'package:starter_application/features/mylife/domain/entity/PositiveListEntity.dart';
import 'package:starter_application/features/mylife/domain/entity/appointment_entity.dart';
import 'package:starter_application/features/mylife/domain/entity/story_entity.dart';
import 'package:starter_application/features/mylife/domain/entity/task_entity.dart';
import 'package:starter_application/features/mylife/presentation/screen/appointment_screen.dart';
import 'package:starter_application/features/mylife/presentation/screen/dream_screen.dart';
import 'package:starter_application/features/mylife/presentation/screen/my_life_video_screen.dart';
import 'package:starter_application/features/mylife/presentation/screen/mylife_audio_screen.dart';
import 'package:starter_application/features/mylife/presentation/screen/positivity_screen.dart';
import 'package:starter_application/features/mylife/presentation/screen/single_story_screen.dart';
import 'package:starter_application/features/mylife/presentation/screen/todo_screen.dart';
import 'package:starter_application/features/mylife/presentation/state_m/cubit/mylife_cubit.dart';
import 'package:starter_application/features/mylife/presentation/widget/my_life_dilog.dart';
import 'package:starter_application/generated/l10n.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';

class MyLifeHomeScreenScreenNotifier extends ScreenNotifier
    with OnRefreshDataMixin {
  /// Fields
  late BuildContext context;
  String selectedSort = Translation.current.all;
  DateTime selectDay = DateTime.now();
  bool isFirst = false;
  int _selectedDay = DateTime.now().day;
  int selectedIndex = 0;
  bool isStory = false;
  bool appointmentVisi = true;
  bool toDoVisi = true;
  bool dreamsVisi = true;
  bool storyVisi = true;
  bool positivityVisi = true;
  bool noDataVisi = false;
  MylifeCubit myLifeCubit = MylifeCubit();
  final likeCubit = LikeCubit();
  DateTime now = DateTime.now();
  List<AppointmentItemEntity> appointments2 = [];
  List<TaskItemEntity> tasks = [];
  List<DreamEntity> dreams2 = [];
  List<PositiveEntity> positives = [];
  List<StoryItemEntity> stories2 = [];
  int totalAchievedDreams = 0;
  int totalInProgressDreams = 0;
  List<Color> dreamColorList = [];
  String quote = "";
  List<Story> stories = [
    Story("assets/images/png/temp/story1.jpg",
        "5 Tips To Supercharge Your Motivation", false, false),
    Story("assets/images/png/temp/story1.jpg",
        "5 Tips To Supercharge Your Motivation", true, false),
    Story("assets/images/png/temp/story2.jpg",
        "Burning Desire Golden Key Or Red Herring", false, true),
  ];
  List<String> storySort = [
    Translation.current.all,
    Translation.current.appointment,
    Translation.current.to_do_list,
    Translation.current.my_dream,
    Translation.current.positivity
  ];
  List<Appointment> appointments = [];
  List<ToDO> toDoList = [];
  List<Dream> dreams = [];

  AnimateIconController animateIconController = AnimateIconController();
  bool isAddOpened = false;
  double opacity = 0;

  int typeOfSelected = -1;
  int indexOfSelected = -1;
  bool isOneSelect = false;
  List<int> selectedIds = [];
  List<int> selectedIndexes = [];

  /// Getters and Setters
  int get selectedDay => this._selectedDay;

  String get selectedSortType => this.selectedSort;

  get math => null;

  set selectedSortType(String value) {
    this.selectedSort = value;
    notifyListeners();
  }

  /// Methods
  void getHomeItems() {
    var temp = DateTime.parse(now.toString() + 'Z');
    myLifeCubit.getAppointments(GetAppointmentRequest(
        toDate: temp, fromDate: temp.subtract(const Duration(days: 7))));
    myLifeCubit.getAllDreams(NoParams());
    myLifeCubit.getTasks(GetAllTasksRequest(
        toDate: temp, fromDate: temp.subtract(const Duration(days: 7))));
    print("temp$temp");
    myLifeCubit.getPositives(GetPositiveRequest(Date: temp));
    myLifeCubit.getStories(GetStoryRequest());
    myLifeCubit.getQuote(NoParams());
  }

  bool openAdd() {
    isAddOpened = true;

    if (animateIconController.isStart()) {
      animateIconController.animateToEnd();
    }
    opacity = 1;
    notifyListeners();
    return true;
  }

  bool closeAdd() {
    isAddOpened = false;

    if (animateIconController.isEnd()) {
      animateIconController.animateToStart();
    }
    opacity = 0;
    notifyListeners();
    return true;
  }




  void getHomeItemsByDate(temp,{bool withLoading = true,StateMyLife state = StateMyLife.All}) {
    print('this is date');
    print(temp);
    var date = DateTime.parse(now.toString() + 'Z');
    if (state == StateMyLife.All) {
      myLifeCubit.getAppointments(GetAppointmentRequest(
          fromDate: DateTime.now(), toDate: DateTime.now().add(const Duration(days: 7))),
          withLoading: withLoading);
      myLifeCubit.getAllDreams(NoParams(), withLoading: withLoading);
      myLifeCubit.getTasks(
          GetAllTasksRequest(fromDate: DateTime.now(), toDate: DateTime.now().add(const Duration(days: 7))),
          withLoading: withLoading);
      myLifeCubit.getPositives(
          GetPositiveRequest(Date: date), withLoading: withLoading);
      myLifeCubit.getStories(GetStoryRequest(), withLoading: withLoading);
      myLifeCubit.getQuote(NoParams(), withLoading: withLoading);
    }else if(state == StateMyLife.Appointments){
      myLifeCubit.getAppointments(GetAppointmentRequest(
          fromDate: DateTime.now(), toDate: DateTime.now()),
          withLoading: withLoading);
    }else if(state == StateMyLife.Dreams){
      myLifeCubit.getAllDreams(NoParams(), withLoading: withLoading);
    }else if(state == StateMyLife.Positives){
      myLifeCubit.getPositives(
          GetPositiveRequest(Date: date), withLoading: withLoading);
    }else if(state == StateMyLife.Quote){
      myLifeCubit.getQuote(NoParams(), withLoading: withLoading);
    }else if(state == StateMyLife.Stories){
      myLifeCubit.getStories(GetStoryRequest(), withLoading: withLoading);
    }else if(state == StateMyLife.Tasks){
      myLifeCubit.getTasks(
          GetAllTasksRequest(fromDate: DateTime.now(), toDate: DateTime.now()),
          withLoading: withLoading);
    }
  }

  onSelectType(String index) {
    selectedSort = index;

    notifyListeners();
  }

  void tasksLoadSuccess(TaskEntity taskEntity) {
    tasks = taskEntity.items!;
    notifyListeners();
  }

  void appointmentsLoadSuccess(AppointmentEntity appointmentEntity) {
    appointments2 = appointmentEntity.items!;
    notifyListeners();
  }

  void dreamsLoadSuccess(DreamListEntity dreamListEntity) {
    dreams2.clear();
    dreamListEntity.items.forEach((element) {
      if(element.achievedStepsCount != element.totalStepsCount)
        dreams2.add(element);
    });
    // dreams2 = dreamListEntity.items;
    notifyListeners();
  }

  void positivesLoadSuccess(PositiveListEntity positiveListEntity) {
    positives = positiveListEntity.items;
    notifyListeners();
  }

  void storiesLoadSuccess(StoryEntity storyEntity) {
    stories2 = storyEntity.items!;
    notifyListeners();
  }

  void onTabAddFloat({
    required List<Widget> items,
    required double itemRadius,
    required double centerRadius,
  }) {
    onAddButtonTap(
      centerRadius: centerRadius,
      itemRadius: itemRadius,
      items: items,
    );
  }

  // generateUiData() {
  //   totalAchievedDreams = 0;
  //   totalInProgressDreams = 0;
  //   dreams2.forEach((element) {
  //     if (element.isAchieved) {
  //       totalAchievedDreams++;
  //     } else {
  //       totalInProgressDreams++;
  //     }
  //   });
  //   dreamColorList = List.generate(
  //       dreams2.length,
  //       (index) => Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
  //           .withOpacity(1.0));
  // }

  void onAddButtonTap({
    required List<Widget> items,
    required double itemRadius,
    required double centerRadius,
  }) {
    showMyLifeDialog(
      context,
      centerRadius: centerRadius,
      itemRadius: itemRadius,
      items: items,
    );
  }

  Color getColorPriority(int id) {
    switch (id) {
      case 0:
        return AppColors.mansourLightBlueDream;
      case 1:
        return AppColors.mansourYellow2;
    }
    return AppColors.mansourLightRed;
  }

  onDayChange(
    int day,
    int dayIndex,
  ) {
    _selectedDay = day;
    notifyListeners();
  }

  void goToPositivityScreen() {

    Nav.to(PositivityScreen.routeName).then((value) {
      // myLifeCubit.getPositives(GetPositiveRequest());
      getHomeItemsByDate(DateTime.now());
      closeAdd();
    });
  }

  void goToDreamScreen() {
    Nav.to(DreamScreen.routeName).then((value) {
      // myLifeCubit.getAllDreams(NoParams());
      getHomeItemsByDate(DateTime.now());

      closeAdd();
    });
  }

  void goToVideoScreen() {
    Nav.to(MyLifeVideoScreen.routeName);
  }

  void goToAudioScreen() {
    Nav.to(MylifeAudioScreen.routeName);
  }

  void goToAppointmentScreen() {
    Nav.to(AppointmentScreen.routeName).then((value) {
      // myLifeCubit.getAppointments(GetAppointmentRequest(
      //     fromDate: DateTime.now(), toDate: DateTime.now()));
      getHomeItemsByDate(DateTime.now());

      closeAdd();
    });
  }

  void goToDoScreen() {
    Nav.to(TodoScreen.routeName).then((value) {
      // myLifeCubit.getTasks(
      //     GetAllTasksRequest(fromDate: DateTime.now(), toDate: DateTime.now()));
      getHomeItemsByDate(DateTime.now());

      closeAdd();
    });
  }

  void goToSingleStoryScreen() {
    Nav.to(SingleStoryScreen.routeName);
  }

  void selectStory() {
    isStory = !isStory;
    notifyListeners();
  }

  void quoteLoaded(res) {
    quote = res;
    notifyListeners();
  }

  void sort(index) {
    if (index == 1) {
      noDataVisi = true;
      appointmentVisi = true;
      toDoVisi = false;
      dreamsVisi = false;
      storyVisi = false;
      positivityVisi = false;
    } else if (index == 2) {
      noDataVisi = true;
      appointmentVisi = false;
      toDoVisi = true;
      dreamsVisi = false;
      storyVisi = false;
      positivityVisi = false;
    } else if (index == 3) {
      noDataVisi = true;
      appointmentVisi = false;
      toDoVisi = false;
      dreamsVisi = true;
      storyVisi = false;
      positivityVisi = false;
    } else if (index == 4) {
      noDataVisi = true;
      appointmentVisi = false;
      toDoVisi = false;
      dreamsVisi = false;
      storyVisi = false;
      positivityVisi = true;
    } else {
      noDataVisi = false;
      appointmentVisi = true;
      toDoVisi = true;
      dreamsVisi = true;
      storyVisi = true;
      positivityVisi = true;
    }
    notifyListeners();
  }

  onCardTapped({required int type, required int index}) {
    print('asadsdsddsdada');
    if (type == 0) {
      if(typeOfSelected == -1 || typeOfSelected == 0){
        typeOfSelected = type;

      }
      else{
        clearUnSelectData();
        typeOfSelected = type;
        selectedIndexes.clear();
        selectedIds.clear();
      }
      if (!appointments2[index].isSelected) {
        if (!appointments2[index].isDone!) {
          if (!selectedIndexes.contains(index)) {
            selectedIndexes.add(index);
            selectedIds.add(appointments2[index].id!);
          }
          appointments2[index].isSelected = true;
        }
      }
      else {
        appointments2[index].isSelected = false;
        selectedIndexes.remove(index);
        selectedIds.remove(appointments2[index].id!);
      }
      if (selectedIndexes.isNotEmpty) {
        isOneSelect = true;
      }
      else {
        isOneSelect = false;
      }
      print(appointments2[index].isSelected);
    }
    else if (type == 1) {
      if(typeOfSelected == -1 || typeOfSelected == 1){
        typeOfSelected = type;

      }
      else{
        clearUnSelectData();
        typeOfSelected = type;
        selectedIndexes.clear();
        selectedIds.clear();
      }
      if (!tasks[index].isSelected) {
        if (!tasks[index].isAchieved) {
          if (!selectedIndexes.contains(index)) {
            selectedIndexes.add(index);
            selectedIds.add(tasks[index].id!);
          }
          tasks[index].isSelected = true;
        }
      }
      else {
        tasks[index].isSelected = false;
        selectedIndexes.remove(index);
        selectedIds.remove(tasks[index].id!);
      }
      if (selectedIndexes.isNotEmpty) {
        isOneSelect = true;
      }
      else {
        isOneSelect = false;
      }
      print(tasks[index].isSelected);
    }
    print(' sdsdsdsdsdsds ');
    print(selectedIds);
    print(selectedIndexes);
    notifyListeners();
  }


  onTapWhenSelected(){
    print('aaaaa');
    if(typeOfSelected == 0){
      for (int i = 0; i < selectedIndexes.length; i++) {
        appointments2[selectedIndexes[i]].isSelected = false;
        appointments2[selectedIndexes[i]].isDone = true;
        notifyListeners();
      }
      selectedIndexes.clear();
      isOneSelect = false;
      myLifeCubit.checkAppointment(CheckTasksRequest(list: selectedIds));

    }
    if(typeOfSelected == 1){
      for (int i = 0; i < selectedIndexes.length; i++) {
        tasks[selectedIndexes[i]].isSelected = false;
        tasks[selectedIndexes[i]].isAchieved = true;
        notifyListeners();
      }
      selectedIndexes.clear();
      isOneSelect = false;
      myLifeCubit.checkTask(CheckTasksRequest(list: selectedIds));
    }
  }

  clearUnSelectData(){
    if(typeOfSelected == 0){
      for (int i = 0; i < selectedIndexes.length; i++) {
        appointments2[selectedIndexes[i]].isSelected = false;
        appointments2[selectedIndexes[i]].isDone = false;
        notifyListeners();
      }
    }
    else if (typeOfSelected == 1){
      for (int i = 0; i < selectedIndexes.length; i++) {
        tasks[selectedIndexes[i]].isSelected = false;
        tasks[selectedIndexes[i]].isAchieved = false;
        notifyListeners();
      }
    }
    else if (typeOfSelected == 2){

    }
  }

  checkStep(int id) {
    List<int> ids = [];
    ids.add(id);
    myLifeCubit.checkDream(CheckDreamParams(
      list: ids,
      type: 1,
    ));
  }

  unCheckStep(int id) {
    List<int> ids = [];
    ids.add(id);
    myLifeCubit.checkDream(CheckDreamParams(
      list: ids,
      type: 0,
    ));
  }

  @override
  Future<void> onRefresh() {
    isFirst = true;
    notifyListeners();
    getHomeItemsByDate(DateTime.now());
    return refreshSubCompleter.future;
  }

  @override
  void closeNotifier() {
    this.dispose();
  }
}

class Story {
  final String name;
  final String image;
  final bool isAudio;
  final bool isVideo;

  Story(this.image, this.name, this.isAudio, this.isVideo);
}
enum StateMyLife {All,Dreams,Appointments,Positives,Stories,Quote,Tasks}
class Appointment {
  bool check;
  String timeStart;
  String timeEnd;
  String title;
  String persons;
  String image;
  Color color;

  Appointment({
    required this.check,
    required this.timeStart,
    required this.timeEnd,
    required this.title,
    required this.persons,
    required this.color,
    required this.image,
  });
}

class ToDO {
  bool check;
  String time;
  String title;
  Color color;

  ToDO({
    required this.check,
    required this.title,
    required this.color,
    required this.time,
  });
}

class Dream {
  String icon;
  String title;
  String subTitle;
  List<Color> color;
  Color background;
  bool isExpanded;

  Dream({
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.color,
    required this.background,
    this.isExpanded = false,
  });
}
