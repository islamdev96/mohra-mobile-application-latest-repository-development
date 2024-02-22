import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/features/event/domain/entity/event_category_entity.dart';
import 'package:starter_application/features/event/presentation/widget/event_tab_widget.dart';

import 'home_service_tab_widget.dart';

class HomeServicesTabsWidget extends StatelessWidget {
  final List<EventCategoryEntity> categories;
  final int selectedTabId;
  final Function(EventCategoryEntity eventCategoryEntity) onTabSelected;
  const HomeServicesTabsWidget(
      {Key? key,
      required this.selectedTabId,
      required this.onTabSelected,
      required this.categories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.w,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
                padding: EdgeInsetsDirectional.only(
                    start: index == 0 ? 60.w : 0,
                    end: index == categories.length - 1 ? 60.w : 0),
                child:  HomeServicesTabWidget(
                  isSelected: selectedTabId == categories.elementAt(index).id,
                  eventCategoryEntity: categories.elementAt(index),
                  onSelected: onTabSelected,
                ));
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 50.w,
            );
          },
          itemCount: categories.length),
    );
  }
}
