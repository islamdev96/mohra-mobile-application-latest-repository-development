import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessagesUtils {
  MessagesUtils._();

  static String? friendsToString(List<String?> names) {
    final noNullNames = names.whereType<String>().toList();
    if (noNullNames.length == 0) return "";
    if (noNullNames.length == 1) return noNullNames.first;
    if (noNullNames.length == 2)
      return "${noNullNames.first} & ${noNullNames[1]}";
    if (noNullNames.length > 2)
      return "${noNullNames.first} & ${noNullNames[1]} & ${noNullNames.length - 2} others";
  }

  static List<Widget>? friendsImages(List<String?> images) {
    final noNullImages = images.whereType<String>().toList();
    List<Widget> imagesList = [];
    if (noNullImages.length == 0) return [];
    if (noNullImages.length == 1)
      imagesList.add(_buildPile(
        120.r,
        Image.asset(
          images[0]!,
          fit: BoxFit.cover,
        ),
      ));
    if (noNullImages.length == 2)
      imagesList.add(_buildPile(
        120.r,
        Image.asset(
          images[1]!,
          fit: BoxFit.cover,
        ),
      ));
    if (noNullImages.length == 3)
      imagesList.add(_buildPile(
        120.r,
        Image.asset(
          images[2]!,
          fit: BoxFit.cover,
        ),
      ));
    return imagesList;
  }

  static Widget _buildPile(double radius, Widget child) {
    return Container(
      height: radius,
      width: radius,
      color: Colors.white,
      child: Center(
        child: ClipOval(
          child: Container(
            height: radius * 0.9,
            width: radius * 0.9,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
