
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/health/data/model/request/image_params.dart';
import 'package:starter_application/features/mylife/data/model/request/create_positives_params.dart';
import 'package:starter_application/features/mylife/data/model/request/delet_item_request.dart';
import 'package:starter_application/features/mylife/data/model/request/delete_dream_params.dart';
import 'package:starter_application/features/mylife/data/model/request/get_positive_request.dart';
import 'package:starter_application/features/mylife/domain/entity/PositiveListEntity.dart';
import 'package:starter_application/features/mylife/presentation/state_m/cubit/mylife_cubit.dart';
import 'package:starter_application/features/mylife/presentation/widget/my_life_bottomsheet.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class PositivityScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  MylifeCubit myLifeCubit = MylifeCubit();
  late PositiveListEntity positives;
  DateTime now = DateTime.now();
  late String Ptitle;
  late String Pdesc;
  late String uploadImages;
  /// Variables
  List<XFile> _imagesFiles = [];

  /// Getters and Setters
  List<String> get imagesPaths => _imagesFiles.map((e) => e.path).toList();

  /// Methods
  void getPositives({bool isDay = false}) {
    var temp = DateTime.parse(now.toString() + 'Z');

    myLifeCubit.getPositives(isDay ?
        GetPositiveRequest(Date: temp) :GetPositiveRequest());
  }

  void createPositive(image) {
    print('aaaa');
    var temp = DateTime.parse(now.toString() + 'Z');
    myLifeCubit.createPositive(CreatePositivesParams(
        title: Ptitle, description:Pdesc, date: temp.toString(), imageUrl: image));
  }

  void deletePositive(DeleteItemRequest params) {
    myLifeCubit.deletePositive(params);
  }

  void updatePositive(image) {
    print('aaaa');
    var temp = DateTime.parse(now.toString() + 'Z');
    myLifeCubit.createPositive(CreatePositivesParams(
        title: Ptitle, description:Pdesc, date: temp.toString(), imageUrl: image));
  }
  void uploadImage(XFile file) {
    print(file.name);
    print('assas');
    myLifeCubit.uploadImage(ImageParams(image: file)
        );
  }
  void onAddTap() {
    showMyLifeBottomSheet(
      context: context,
      onPress: () {

      },
      OnAdd: (title, des, image) {
        Nav.pop();
        Pdesc=des;
        Ptitle=title;
        notifyListeners();
        uploadImage(image);
        // createPositive(title, des, "image");
      },
      imagesPaths: imagesPaths,
      title: Translation.current.add_positivity,
    );
  }
  void onImagesPicked(List<XFile> imagesFiles) {
    print('aaaaaa');
    if (imagesPaths.isNotEmpty) {
      _imagesFiles.clear();
    }
    _imagesFiles.addAll(imagesFiles);
    notifyListeners();
  }

  void positivesLoaded(PositiveListEntity entity) {
    positives = entity;
    notifyListeners();
  }

  @override
  void closeNotifier() {
    this.dispose();
  }
}

class Positivity {
  String icon;
  String title;
  String content;
  String time;

  Positivity({
    required this.icon,
    required this.title,
    required this.content,
    required this.time,
  });
}
