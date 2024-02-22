import 'package:flutter/material.dart';
import 'package:starter_application/core/params/no_params.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';
import '../../../domain/entity/faq_entity.dart';
import '../cubit/help_cubit.dart';

class FaqScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  bool _customTileExpanded=false;
  late FaqListEntity faqListEntity ;

  final helpCubit=HelpCubit();
  bool get customTileExpanded => _customTileExpanded;

  set customTileExpanded(bool value) {
    _customTileExpanded = value;
    notifyListeners();
  }

  getAllFaqsList(){
    print("FAQ");
    helpCubit.getAllFaqs(NoParams());
  }
  onFaqListLoaded(FaqListEntity entity){
    faqListEntity=entity;
    notifyListeners();
  }

  /// Getters and Setters

  /// Methods



  @override
  void closeNotifier() {
    this.dispose();
  }
}
