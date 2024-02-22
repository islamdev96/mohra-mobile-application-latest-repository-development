import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/empty_error_widget.dart';
import 'package:starter_application/core/ui/widgets/pagination_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/event/domain/entity/event_entity.dart';
import 'package:starter_application/features/event/presentation/screen/events_by_category_screen.dart';
import 'package:starter_application/features/event/presentation/state_m/cubit/event_cubit.dart';
import 'package:starter_application/features/event/presentation/state_m/provider/event_categories_screen_notifier.dart';
import 'package:starter_application/features/event/presentation/widget/all_events_shimmer_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_ads_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_categories_shimmer_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_tabs_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_title_widget.dart';
import 'package:starter_application/features/event/presentation/widget/other_events_shimmer_widget.dart';
import 'package:starter_application/features/event/presentation/widget/popular_event_shimmer_widget.dart';
import 'package:starter_application/features/event/presentation/widget/search_events_widget.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../domain/entity/event_category_entity.dart';
import '../screen/../state_m/provider/event_home_screen_notifier.dart';

class EventHomeScreenContent extends StatefulWidget {
  @override
  State<EventHomeScreenContent> createState() => _EventHomeScreenContentState();
}

class _EventHomeScreenContentState extends State<EventHomeScreenContent>
    with TickerProviderStateMixin {
  late EventHomeScreenNotifier sn;

  //todo refactoring change bloc builders to bloc listeners of events
  @override
  Widget build(BuildContext context) {
    sn = Provider.of<EventHomeScreenNotifier>(context);
    sn.context = context;
    return sn.isSearchScreen ? _buildSearchScreen() : _buildHomeScreen();
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

  Widget _buildHomeScreen() {
    return SizedBox(
      height: 1.sh,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 30.h,
          ),
          _buildResultWidget(
            isLoading: sn.allEvents.isEmpty && sn.isAllEventsLoading,
            isEmpty: sn.allEvents.isEmpty,
            loadingWidget: AllEventsShimmerWidget(
              height: 0.2.sh,
              width: 0.8.sw,
            ),
            appErrors: sn.allEventsAppErrors,
            successWidget: EventsAdsWidget(
              isLoading: sn.isAllEventsLoading,
              scrollController: sn.allEventsScrollController,
              height: 0.23.sh,
              events: sn.allEvents,
            ),
          ),
          BlocConsumer<EventCubit, EventState>(
            bloc: sn.categoriesCubit,
            listener: (context, state) {
              state.mapOrNull(
                eventCategoriesLoadedState: (value) {
                  sn.isCategoriesFetched = true;
                  sn.isCategoriesError = false;
                  if (value.eventCategoriesEntity.items.isNotEmpty) {
                    sn.chosenCategory = EventCategoryEntity(
                        name: "",
                        isActive: false,
                        enName: "All Events",
                        arName: "الكل",
                        id: -1);
                    sn.categories.add(EventCategoryEntity(
                        name: "",
                        isActive: false,
                        enName: "All Events",
                        arName: "الكل",
                        id: -1));
                    sn.categories.addAll(value.eventCategoriesEntity.items);

                    sn.categoriesTabController = TabController(
                      vsync: this,
                      length: sn.categories.length,
                    );
                  }
                },
                eventErrorState: (value) {
                  sn.isCategoriesError = true;
                },
              );
            },
            builder: (context, state) {
              return state.maybeMap(
                eventInitState: (value) => const EventCategoriesShimmerWidget(),
                eventLoadingState: (value) =>
                    const EventCategoriesShimmerWidget(),
                eventCategoriesLoadedState: (value) {
                  return Column(
                    children: [
                      EventTitleWidget(
                          title: Translation.of(context).popular_events),
                      value.eventCategoriesEntity.items.isEmpty
                          ? _buildEmptyWidget()
                          : EventTabsWidget(
                              categories: sn.categories,
                              selectedTabId: sn.chosenCategory.id!,
                              onTabSelected: (eventCategoryEntity) {
                                sn.chosenCategory = eventCategoryEntity;
                              },
                            )
                    ],
                  );
                },
                eventErrorState: (value) {
                  return SizedBox(
                    height: 0.2.sh,
                    child: Center(
                      child: ErrorScreenWidget(
                          error: value.error, callback: value.callback),
                    ),
                  );
                },
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
          SizedBox(
            height: 40.h,
          ),
          Expanded(
            child: sn.isCategoriesError
                ? const SizedBox.shrink()
                : !sn.isCategoriesFetched
                    ? Column(
                        children: [
                          const PopularEventShimmerWidget(),
                          const OtherEventsShimmerWidget(),
                        ],
                      )
                    : sn.categoriesTabController != null
                        ? TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: sn.categories
                                .map((e) => EventsByCategoryScreen(
                                    eventCategoryEntity: e,
                                    otherEventsScrollController:
                                        sn.otherEventsScrollController,
                                    myLocation: sn.myLocation))
                                .toList(),
                            controller: sn.categoriesTabController,
                          )
                        : const SizedBox.shrink(),
          ),
          SizedBox(
            height: 30.h,
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
      return SizedBox(
        height: 0.3.sh,
        child: ErrorScreenWidget(
          error: appErrors,
          callback: () {
            sn.getData(context);
          },
        ),
      );
    if (isEmpty) return _buildEmptyWidget();
    return successWidget;
  }

  Widget _buildSearchScreen() {
    return BlocConsumer<EventCubit, EventState>(
      bloc: sn.searchCubit,
      builder: (context, state) => state.maybeMap(
        eventInitState: (value) => WaitingWidget(),
        eventLoadingState: (value) => WaitingWidget(),
        eventsLoadedState: (value) => _buildPaginationWrap(),
        eventErrorState: (value) => ErrorScreenWidget(
          error: value.error,
          callback: sn.searchEvents,
        ),
        orElse: () => const SizedBox.shrink(),
      ),
      listener: (context, state) => state.mapOrNull(
        eventsLoadedState: (value) {
          sn.searches = value.eventsEntity.items;
        },
      ),
    );
  }

  Widget _buildPaginationWrap() {
    return PaginationWidget<EventEntity>(
      refreshController: sn.refreshController,
      getItems: (unit) {
        return sn.returnSearchesData(unit);
      },
      items: sn.searches,
      onDataFetched: (items, nextUnit) => sn.onDataFetched(items, nextUnit),
      child: SearchEventsWidget(
        searches: sn.searches,
      ),
    );
  }
}
