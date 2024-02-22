import 'package:flutter/material.dart';
import 'package:starter_application/features/health/presentation/logic/sub_nut_model_ui.dart';

class NutritionModelUi {
  double value;
  double totalValue;
  String title;
  bool showPercent;
  late List<SubNutritionModelUi> list;

  NutritionModelUi({
    required this.value,
    required this.totalValue,
    required this.title,
    required this.showPercent,
  });
}
