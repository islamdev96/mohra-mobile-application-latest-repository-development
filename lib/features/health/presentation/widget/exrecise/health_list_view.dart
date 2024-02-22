import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/features/health/presentation/widget/health_item_card.dart';

class HealthItem {
  final String name;
  final String description;
  final String image;

  HealthItem({
    required this.name,
    required this.description,
    required this.image,
  });
}

class HealthListView extends StatelessWidget {
  final double itemHeight;
  final String title;
  final String? icon;
  final List<HealthItem> items;
  final Color? titleColor;
  final Color Function(int index)? indecatorColor;
  final Function(int index)? onTap;

  HealthListView({
    Key? key,
    required this.itemHeight,
    required this.title,
    required this.items,
    this.onTap,
    this.icon,
    this.titleColor,
    this.indecatorColor,
  }) : super(key: key);

  final double space = 50.h;
  final double indecatorWidth = 50.h;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null)
              SizedBox(
                height: 70.h,
                width: 70.h,
                child: SvgPicture.asset(
                  icon!,
                ),
              ),
            if (icon != null) Gaps.hGap32,
            Text(
              title,
              style: TextStyle(
                color: titleColor ?? Colors.black,
                fontSize: 50.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        Gaps.vGap32,
        _buildList(),
      ],
    );
  }

  Widget _buildList() {
    return Row(
      children: [
        /// Indecators column
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < items.length; i++)
              Column(
                children: [
                  _buildIndecator(
                    i,
                    hideTopLine: i == 0,
                    hideBottomLline: i == items.length - 1,
                  ),
                  if (i != items.length - 1) _buildIndecatorLine(),
                ],
              ),
          ],
        ),
        Gaps.hGap32,

        /// Cards column
        Expanded(
          child: Column(
            children: [
              for (int i = 0; i < items.length; i++)
                Column(
                  children: [
                    _buildHealthItemCard(i),
                    if (i != items.length - 1)
                      SizedBox(
                        height: space,
                      ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIndecator(
    int index, {
    bool hideTopLine = false,
    bool hideBottomLline = false,
  }) {
    return SizedBox(
      width: indecatorWidth,
      height: itemHeight,
      child: Column(
        children: [
          if (hideTopLine) const Spacer(),
          if (!hideTopLine)
            Expanded(
              child: Container(
                width: 5.w,
                color: AppColors.mansourWhiteBackgrounColor_4,
              ),
            ),
          Container(
            height: indecatorWidth,
            width: indecatorWidth,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.mansourLightGreyColor,
            ),
            child: Center(
              child: Container(
                height: indecatorWidth * 0.75,
                width: indecatorWidth * 0.75,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: indecatorColor?.call(index) ??
                      AppColors.mansourDarkGreenColor,
                ),
              ),
            ),
          ),
          if (hideBottomLline) const Spacer(),
          if (!hideBottomLline)
            Expanded(
              child: Container(
                width: 5.w,
                color: AppColors.mansourWhiteBackgrounColor_4,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildIndecatorLine() {
    return Container(
      width: indecatorWidth,
      height: space,
      child: Column(
        children: [
          SizedBox(
            width: indecatorWidth,
          ),
          Expanded(
            child: Container(
              width: 5.w,
              color: AppColors.mansourWhiteBackgrounColor_4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthItemCard(int index) {
    final item = items[index];
    return HealthItemCard(
      height: itemHeight,
      name: item.name,
      description: item.description,
      image: item.image,
      onTap:onTap == null ? null : () => onTap!.call(index),
    );
  }
}
