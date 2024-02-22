import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/widgets/no_data_widget.dart';
import 'package:starter_application/core/ui/widgets/pagination_widget.dart';
import 'package:starter_application/features/event_orginizer/domain/entity/my_running_events_entity.dart';
import 'package:starter_application/features/event_orginizer/presentation/state_m/cubit/event_orginizer_cubit.dart';
import 'package:starter_application/generated/l10n.dart';
import '../../../../core/ui/widgets/waiting_widget.dart';
import '../../../Event Organizer/widgets/home_widgets/event_and_settings_widget.dart';
import '../../../Event Organizer/widgets/home_widgets/event_widget.dart';
import '../../../Event Organizer/widgets/home_widgets/home_body.dart';
import '../../../Event Organizer/widgets/home_widgets/home_filter.dart';
import '../../../mylife/presentation/logic/date_time_helper.dart';
import '../screen/../state_m/provider/event_organizer_screen_notifier.dart';
import 'event_organizer_details_screen.dart';

class EventOrganizerScreenContent extends StatelessWidget {
  late EventOrganizerScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<EventOrganizerScreenNotifier>(context);
    sn.context = context;
    return buildScreen(context);
  }

  Widget buildScreen(context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // events items
            Padding(
              padding:  EdgeInsets.only(left: 20.0,right: 20,),
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/events.png",
                    width: 25,
                    height: 25,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "${sn.events.length} "+Translation.current.events,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 14),
                  )
                ],
              ),
            ),
            // settings & sort widgets
            Row(
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        context: context,
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                       Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          Translation.current.Sort_event_by,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Nav.pop();
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            "assets/icons/cancel.png",
                                            width: 24,
                                            height: 20,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                // list of items
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: sn.itemList.length,
                                    itemBuilder:
                                        (BuildContext context, index) {
                                      return GestureDetector(
                                        onTap:(){
                                          sn.sortEventsList(sn.itemList[index]);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.all(8.0),
                                            child: (Text(
                                              sn.itemTrList.elementAt(index),
                                              style:  TextStyle(
                                                  fontSize: 20,
                                                  color: (sn.itemList.elementAt(index) == sn.keySorting) ? AppColors.mansourBackArrowColor2 : AppColors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            )),
                                          ),
                                        ),
                                      );
                                    })
                              ],
                            ),
                          );
                        });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, spreadRadius: 1)
                      ],
                      color: Colors.white,
                    ),
                    child: Row(
                      children:  [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(Translation.current.sort),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 0,
                ),
                const SizedBox(
                  width: 0,
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => Container(
                        height: MediaQuery.of(context).size.height * 0.95,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ),
                        ),
                        child:  HomeFilter(sn: sn,),
                      ),
                    );
                    /* Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomeFilter())
              );*/
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(color: Colors.grey, spreadRadius: 1)
                        ],
                        color: Colors.white),
                    child: Builder(builder: (context) {
                      return Image.asset(
                        "assets/icons/settings.png",
                        width: 20,
                        height: 20,
                      );
                    }),
                  ),
                )
              ],
            ),
            // setting widget
          ],
        ),
        Expanded(child: sn.isLoading
            ? WaitingWidget():
        PaginationWidget<EventItemEntity>(
          items: sn.events,
          getItems: sn.getEventsItems,
          onDataFetched: sn.onEventsItemsFetched,
          refreshController: sn.refreshController,
          footer: ClassicFooter(
            loadingText: "",
            noDataText: Translation.of(context).noDataRefresher,
            failedText: Translation.of(context).failedRefresher,
            idleText: "",
            canLoadingText: "",
            loadingIcon: Padding(
              padding: EdgeInsets.only(
                bottom: AppConstants.bottomNavigationBarHeight + 300.h,
              ),
              child: const CircularProgressIndicator.adaptive(),
            ),
            height: AppConstants.bottomNavigationBarHeight + 300.h,
          ),
          child: sn.events.length > 0 ?ListView.builder(
            itemCount: sn.events.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 0),
                child: EventsWidget(
                  eventItemEntity: sn.events[index],
                ),
              );
            },
          ) : NoDataWidget(),
        ))
      ],
    );
  }
}
