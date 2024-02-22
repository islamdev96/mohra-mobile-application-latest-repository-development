/*
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/features/health/presentation/widget/health_item_card.dart';

class ExreciseLibrary extends StatelessWidget {
  final Function(int index) onTap;
  const ExreciseLibrary({
    Key? key, required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: AppConstants.screenPadding,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _buildCard(index);
        },
        separatorBuilder: (context, index) {
          return Gaps.vGap32;
        },
        itemCount: 5);
  }

*/
/*  Widget _buildCard(int index) {
    return HealthItemCard(
      height: 300.h,
      name: "Full Body Challenge",
      description: "200 kcal | 20 minute",
      image: "assets/images/png/temp/exrcise.png",
      onTap: ()=> onTap(index),
    );
  }*//*

}
*/
