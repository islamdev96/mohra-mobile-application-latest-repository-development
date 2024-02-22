import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/ui/widgets/empty_error_widget.dart';
import 'package:starter_application/features/event/domain/entity/event_entity.dart';
import 'package:starter_application/features/event/presentation/widget/popular_event_shimmer_widget.dart';
import 'package:starter_application/features/event/presentation/widget/popular_event_widget.dart';
import 'package:starter_application/generated/l10n.dart';

class PopularEventsWidget extends StatelessWidget {
  final List<EventEntity> events;
  final ScrollController scrollController;
  final bool isLoading;
  PopularEventsWidget(
      {Key? key,
      required this.events,
      required this.scrollController,
      required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.3.sh,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Row(
          children: [
            ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: index == 0 ? 60.w : 0,
                        end: index == events.length - 1 ? 60.w : 0),
                    child: PopularEventWidget(event: events.elementAt(index)),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 50.w,
                  );
                },
                itemCount: events.length),
            isLoading
                ? SizedBox(
                    width: 0.7.sw, child: const PopularEventShimmerWidget())
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return SizedBox(
      height: 0.2.sh,
      child: Center(
        child: EmptyErrorScreenWidget(
          message: Translation.current.no_data,
          textColor: AppColors.white_text,
        ),
      ),
    );
  }
}
