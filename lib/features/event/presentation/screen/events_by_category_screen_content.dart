import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/empty_error_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_title_widget.dart';
import 'package:starter_application/features/event/presentation/widget/other_events_shimmer_widget.dart';
import 'package:starter_application/features/event/presentation/widget/other_events_widget.dart';
import 'package:starter_application/features/event/presentation/widget/popular_event_shimmer_widget.dart';
import 'package:starter_application/features/event/presentation/widget/popular_events_widget.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/events_by_category_screen_notifier.dart';

class EventsByCategoryScreenContent extends StatefulWidget {
  @override
  State<EventsByCategoryScreenContent> createState() =>
      _EventsByCategoryScreenContentState();
}

class _EventsByCategoryScreenContentState
    extends State<EventsByCategoryScreenContent> {
  late EventsByCategoryScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<EventsByCategoryScreenNotifier>(context);
    sn.context = context;
    return SingleChildScrollView(
      controller: sn.otherEventsScrollController,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildResultWidget(
            isEmpty: sn.popularEvents.isEmpty,
            isLoading: sn.popularEvents.isEmpty && sn.isPopularEventsLoading,
            loadingWidget: const PopularEventShimmerWidget(),
            appErrors: sn.popularEventsAppErrors,
            successWidget: PopularEventsWidget(
                isLoading: sn.isPopularEventsLoading,
                scrollController: sn.popularEventsScrollController,
                events: sn.popularEvents),
          ),
          _buildResultWidget(
            isEmpty: false,
            isLoading: sn.otherEvents.isEmpty && sn.isOtherEventsLoading,
            loadingWidget: const OtherEventsShimmerWidget(),
            appErrors: sn.otherEventsAppErrors,
            successWidget: Column(
              children: [
                EventTitleWidget(
                    title: Translation.of(context).other_events_might_like),
                sn.otherEvents.isEmpty
                    ? _buildEmptyWidget()
                    : OtherEventsWidget(
                        events: sn.otherEvents,
                        isLoading: sn.isOtherEventsLoading,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultWidget({
    required bool isLoading,
    required bool isEmpty,
    required Widget loadingWidget,
    required AppErrors? appErrors,
    required Widget successWidget,
  }) {
    if (isLoading) return loadingWidget;
    if (appErrors != null)
      return ErrorScreenWidget(error: appErrors, callback: () {});
    if (isEmpty) return _buildEmptyWidget();
    return successWidget;
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
