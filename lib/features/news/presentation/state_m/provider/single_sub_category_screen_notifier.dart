import 'package:flutter/material.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';
import 'news_home_screen_notifier.dart';

class SingleSubCategoryScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  List<Health> sportNewsList = [
    Health(
        image: "assets/images/png/temp/sportNews1.jpg",
        icon: "assets/images/png/temp/healthnewsIcon1.png",
        title: "Little Things Do Make A Difference"),
    Health(
        image: "assets/images/png/temp/sportNews2.jpg",
        icon: "assets/images/png/temp/healthnewsIcon2.png",
        title: "Little Things Do Make A Difference"),
    Health(
        image: "assets/images/png/temp/sportNews3.jpg",
        icon: "assets/images/png/temp/healthnewsIcon3.png",
        title: "Little Things Do Make A Difference"),
  ];

  /// Getters and Setters

  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }
}
