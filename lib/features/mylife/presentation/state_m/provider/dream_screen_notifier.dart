import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_error_snackbar.dart';
import 'package:starter_application/features/mylife/data/model/request/check_dream_params.dart';
import 'package:starter_application/features/mylife/data/model/request/create_dream_params.dart';
import 'package:starter_application/features/mylife/data/model/request/delet_item_request.dart';
import 'package:starter_application/features/mylife/data/model/request/delete_dream_params.dart';
import 'package:starter_application/features/mylife/data/model/response/get_dream_list_response.dart';
import 'package:starter_application/features/mylife/domain/entity/DreamListEntity.dart';
import 'package:starter_application/features/mylife/presentation/state_m/cubit/mylife_cubit.dart';
import 'package:starter_application/features/mylife/presentation/widget/dreams/add_dream.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class DreamScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final mylifeCubit = MylifeCubit();
  late DreamListEntity _dreamListEntity;
  late XFile file;
  int totalAchievedDreams = 0;
  int totalInProgressDreams = 0;
  List<Color> dreamColorList = [];

  List<String> dreamIcons = [
    'assets/images/svg/dream_icons/dream-icon-1.png',
    'assets/images/svg/dream_icons/dream-icon-2.png',
    'assets/images/svg/dream_icons/dream-icon-3.png',
    'assets/images/svg/dream_icons/dream-icon-5.png',
    'assets/images/svg/dream_icons/dream-icon-7.png',
    'assets/images/svg/dream_icons/dream-icon-8.png',
    'assets/images/svg/dream_icons/dream-icon-9.png',
    'assets/images/svg/dream_icons/dream-icon-10.png',
    'assets/images/svg/dream_icons/dream-icon-11.png',
    'assets/images/svg/dream_icons/dream-icon-12.png',
    'assets/images/svg/dream_icons/dream-icon-13.png',
    'assets/images/svg/dream_icons/dream-icon-14.png',
    'assets/images/svg/dream_icons/dream-icon-15.png',
    'assets/images/svg/dream_icons/dream-icon-16.png',
    'assets/images/svg/dream_icons/dream-icon-17.png',
    'assets/images/svg/dream_icons/dream-icon-18.png',
    'assets/images/svg/dream_icons/dream-icon-19.png',
    'assets/images/svg/dream_icons/dream-icon-20.png',
    'assets/images/svg/dream_icons/dream-icon-21.png',
    'assets/images/svg/dream_icons/dream-icon-22.png',
    'assets/images/svg/dream_icons/dream-icon-23.png',
    'assets/images/svg/dream_icons/dream-icon-24.png',
    'assets/images/svg/dream_icons/dream-icon-25.png',
    'assets/images/svg/dream_icons/dream-icon-26.png',
    'assets/images/svg/dream_icons/dream-icon-27.png',
    'assets/images/svg/dream_icons/dream-icon-28.png',
    'assets/images/svg/dream_icons/dream-icon-29.png',
    'assets/images/svg/dream_icons/dream-icon-30.png',
    'assets/images/svg/dream_icons/dream-icon-31.png',
    'assets/images/svg/dream_icons/dream-icon-32.png',
    'assets/images/svg/dream_icons/dream-icon-33.png',
    'assets/images/svg/dream_icons/dream-icon-34.png',
    'assets/images/svg/dream_icons/dream-icon-35.png',
    'assets/images/svg/dream_icons/dream-icon-62.png',
    'assets/images/svg/dream_icons/dream-icon-68.png',
  ];

  List<StepEntity> dreamSteps = [];
  List<StepModel> steps = [];
  TextEditingController stepTextFiledController = TextEditingController();
  TextEditingController dreamTitleTextFieldController = TextEditingController();
  int selectedIconDream = -1;
  bool userSelectIcon = false;
  Color addDreamColor = AppColors.mansourDarkBlueColor5;

  /// Getters and Setters

  DreamListEntity get dreamListEntity => _dreamListEntity;

  void onAddTap() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.2,
          expand: false,
          builder: (_, coontroller) {
            return AddDreamBottomSheet(
              sn: this,
              imageList: dreamIcons,
            );
          },
        );
      },
      isScrollControlled: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            40.r,
          ),
        ),
      ),
      constraints: BoxConstraints(
        maxHeight: 1.sh,
      ),
    );
  }

  bool canSaveDream() {
    if (dreamTitleTextFieldController.value.text.isNotEmpty) return true;
    return false;
  }

  bool addedIcon() {
    if (selectedIconDream != -1) return true;
    return false;
  }

  getDreamList() {
    mylifeCubit.getAllDreams(NoParams());
  }

  onDreamListLoaded(DreamListEntity dreamListEntity) {
    _dreamListEntity = dreamListEntity;
    generateUiData();
    notifyListeners();
  }

  generateUiData() {
    totalAchievedDreams = 0;
    totalInProgressDreams = 0;
    _dreamListEntity.items.forEach((element) {
      if (element.isAchieved) {
        totalAchievedDreams++;
      } else {
        totalInProgressDreams++;
      }
    });
    dreamColorList = List.generate(
        _dreamListEntity.items.length,
        (index) => Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(1.0));
  }

  onDreamCreated(DreamEntity dreamEntity) {
    _dreamListEntity.items.add(dreamEntity);
    notifyListeners();
  }

  onSavePress() async {
    if (canSaveDream()) {
      CreateDreamParams params = CreateDreamParams(
        title: dreamTitleTextFieldController.value.text,
        steps: steps,
        imageUrl: dreamIcons[selectedIconDream],
      );

      mylifeCubit.createDream(params);
      notifyListeners();
    } else {
      showErrorSnackBar(message: Translation.current.dream_dream_icon_required);
    }
  }

  onDreamCreatedSuccessfully() {
    dreamTitleTextFieldController.clear();
    steps.clear();
    selectedIconDream = -1;
    getDreamList();
  }

  checkStep(int id) {
    List<int> ids = [];
    ids.add(id);
    mylifeCubit.checkDream(CheckDreamParams(
      list: ids,
      type: 1,
    ));
  }

  unCheckStep(int id) {
    List<int> ids = [];
    ids.add(id);
    mylifeCubit.checkDream(CheckDreamParams(
      list: ids,
      type: 0,
    ));
  }

  deleteDream(int id) {
    mylifeCubit.deleteDream(DeleteDreamParams(
      id: id,
    ));
  }

  deletePositive(int id) {
    mylifeCubit.deletePositive(DeleteItemRequest(
      id: id,
      type: 0,
    ));
  }

  @override
  void closeNotifier() {
    this.dispose();
  }
}
