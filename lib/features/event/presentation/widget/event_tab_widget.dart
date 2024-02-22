import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/features/event/domain/entity/event_category_entity.dart';

class EventTabWidget extends StatelessWidget {
  final bool isSelected;
  final EventCategoryEntity eventCategoryEntity;
  final Function(EventCategoryEntity eventCategoryEntity) onSelected;
  const EventTabWidget(
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
        borderRadius: BorderRadius.circular(20.r),
        color: AppColors.mansourDarkOrange3,
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
           AppConfig().isLTR ?  eventCategoryEntity.enName : eventCategoryEntity.arName,
            style: const TextStyle(
              color: AppColors.white_text,
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
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColors.white)),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              AppConfig().isLTR ?  eventCategoryEntity.enName : eventCategoryEntity.arName,
              style: const TextStyle(
                color: AppColors.white_text,
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
