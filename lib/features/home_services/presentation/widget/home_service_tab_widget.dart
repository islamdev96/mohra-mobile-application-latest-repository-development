import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/features/event/domain/entity/event_category_entity.dart';

class HomeServicesTabWidget extends StatelessWidget {
  final bool isSelected;
  final EventCategoryEntity eventCategoryEntity;
  final Function(EventCategoryEntity eventCategoryEntity) onSelected;
  const HomeServicesTabWidget(
      {Key? key,
      required this.isSelected,
      required this.onSelected,
      required this.eventCategoryEntity})
      : super(key: key);

  Widget _buildSelectedTab() {
    return Container(
      constraints: BoxConstraints(
        minWidth: 180.w,
      ),
      decoration: BoxDecoration(
        border: isSelected ? Border.all(width: 0) : Border.all(color: AppColors.black),
        borderRadius: BorderRadius.circular(20.r),
        color: AppColors.mansourDarkOrange3,
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 60.w),
          child: Text(
           AppConfig().isLTR ?  eventCategoryEntity.enName : eventCategoryEntity.arName,
            style:  TextStyle(
              color: isSelected ? AppColors.white_text : AppColors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUnSelectedTab() {
    return GestureDetector(
      onTap: () {
        onSelected(eventCategoryEntity);
      },
      child: Container(
        constraints: BoxConstraints(
          minWidth: 180.w,
        ),
        decoration: BoxDecoration(
          border: isSelected ? Border.all(width: 0) : Border.all(color: AppColors.black),
          borderRadius: BorderRadius.circular(20.r),
          color: AppColors.mansourLightGreyColor_4,
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 60.w),
            child: Text(
              AppConfig().isLTR ?  eventCategoryEntity.enName : eventCategoryEntity.arName,
              style:  TextStyle(
                color: isSelected ? AppColors.white_text : AppColors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isSelected ? _buildSelectedTab() : _buildUnSelectedTab();
  }
}
