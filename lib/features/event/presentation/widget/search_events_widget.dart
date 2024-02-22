import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/features/event/domain/entity/event_entity.dart';
import 'package:starter_application/features/event/presentation/widget/other_event_widget.dart';

class SearchEventsWidget extends StatelessWidget {
  final List<EventEntity> searches;
  const SearchEventsWidget({Key? key, required this.searches})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.w),
                child: OtherEventWidget(event: searches.elementAt(index)),
              ),
          separatorBuilder: (context, index) => SizedBox(
                height: 30.h,
              ),
          itemCount: searches.length),
    );
  }
}
