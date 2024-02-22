import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:starter_application/features/religion/data/model/request/azkar_param.dart';
import 'package:starter_application/features/religion/domain/entity/azkar_entity.dart';
import 'package:starter_application/features/religion/presentation/state_m/cubit/religion_cubit.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class AzkarScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final azkarCubit = ReligionCubit();
  late AzkarEntity azkar;
  int pageNumber = 0;
  List<AzkarItemEntity> azkars = [];
  CancelToken cancelToken = CancelToken();

  /// Getters and Setters

  /// Methods
  getAzkar(String id) {
    if (!cancelToken.isCancelled) cancelToken.cancel();
    cancelToken = CancelToken();
    azkarCubit.getAzkarByCategory(
      AzkarParam(
        categoryId: id,
        cancelToken: cancelToken,
      ),
    );
  }

  azkarLoaded(AzkarEntity azkarEntity) {
    azkars.clear();
    pageNumber = 0;
    notifyListeners();
    azkar = azkarEntity;
    for (var azkar in azkar.result.items!) {
      azkars.add(azkar);
    }
    notifyListeners();
  }

  onNextTap() {
    if (azkars.length - 1 > pageNumber) {
      pageNumber++;
      print(pageNumber);
      notifyListeners();
    }
  }

  onBackTap() {
    if (pageNumber > 0) {
      pageNumber--;
      print(pageNumber);
      notifyListeners();
    }
  }

  @override
  void closeNotifier() {
    azkarCubit.close();
    this.dispose();
  }

  void onLastReadTap() {}
}
