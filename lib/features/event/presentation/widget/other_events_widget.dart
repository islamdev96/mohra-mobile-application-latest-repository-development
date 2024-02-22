import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/features/event/domain/entity/event_entity.dart';
import 'package:starter_application/features/event/presentation/widget/other_event_widget.dart';
import 'package:starter_application/features/event/presentation/widget/other_events_shimmer_widget.dart';

class OtherEventsWidget extends StatelessWidget {
  final List<EventEntity> events;
  final bool isLoading;

  const OtherEventsWidget({
    Key? key,
    required this.events,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60.w),
      child: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return OtherEventWidget(event: events.elementAt(index));
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 40.h,
                );
              },
              itemCount: events.length),
          isLoading
              ? const OtherEventsShimmerWidget(
                  itemsCount: 1,
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
