import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/widgets/no_data_widget.dart';
import 'package:starter_application/core/ui/widgets/pagination_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/Event%20Organizer/widgets/home_widgets/event_widget.dart';
import 'package:starter_application/features/event_orginizer/domain/entity/event_tickets_entity.dart';
import 'package:starter_application/features/event_orginizer/presentation/state_m/cubit/event_orginizer_cubit.dart';
import 'package:starter_application/features/event_orginizer/presentation/widget/event_home_appbar.dart';
import 'package:starter_application/generated/l10n.dart';
import '../../../../core/ui/widgets/custom_network_image_widget.dart';
import '../../../Event Organizer/pages/attendance/attendance.dart';
import '../../../Event Organizer/pages/attendance/cancel_action.dart';
import '../../../Event Organizer/pages/ticket_search/ticket_search.dart';
import '../../../Event Organizer/widgets/event_details/details_widget.dart';
import '../../../Event Organizer/widgets/event_details/event_body.dart';
import '../../../mylife/presentation/logic/date_time_helper.dart';
import '../screen/../state_m/provider/event_organizer_details_screen_notifier.dart';
import 'attendance_screen.dart';

class EventOrganizerDetailsScreenContent extends StatefulWidget {
  @override
  State<EventOrganizerDetailsScreenContent> createState() => _EventOrganizerDetailsScreenContentState();
}

class _EventOrganizerDetailsScreenContentState extends State<EventOrganizerDetailsScreenContent> {
  late EventOrganizerDetailsScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<EventOrganizerDetailsScreenNotifier>(context);
    sn.context = context;
    return Scaffold(
      appBar: EventsDetailsHomeAppBar(
        sn: sn,
        isLeading: sn.isSearch,
        controller: sn.search,
        isHasLeading: true,
        onPress: () {
          sn.change();
          sn.changeSearchBody();
          sn.getEventTickets();
          setState(() {});
        },
        onSearch: () {
          sn.getEventTickets();
          sn.change();
        },
        onSubmitted: (String value) {
          sn.getEventTickets();
          sn.change();
        },
        onClose: () {
          if(sn.isSearchBody||sn.isSearch){
            sn.changeAll();
          }else {
            Nav.pop();
          }
        },),
      bottomNavigationBar:sn.eventItemEntity.eventType != 4 ? InkWell(
        onTap: sn.scan,
        child: Container(
          height: 100,
          decoration: const BoxDecoration(
            color: Color(0xFFFF5921),
          ),
          child: Center(child: Image.asset("assets/images/scanner.png",height: 100,width: 50,)),
        ),
      ) : SizedBox.shrink(),
      body: _buildScreen(context),
    );
  }

  _buildScreen(BuildContext context){
    return Column(
      children:  [
        const SizedBox(height: 20,),
        Padding(
          padding:  EdgeInsets.all(8.0),
          child:  Text(sn.eventItemEntity.title??"",style:
          TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: EdgeInsets.only(left: 10.0,bottom: 10),
          child: Text("${sn.eventItemEntity.cityName??""}, ${DateTimeHelper.getFormatedDate(sn.eventItemEntity.startDate)}",style:
          TextStyle(fontWeight: FontWeight.normal,fontSize: 20,color: Colors.grey),),
        ),
         ProgressAndSettingsWidgets(sn: sn,),
        const SizedBox(height: 10,),
        Expanded(
            child: sn.isLoading
            ? WaitingWidget()
            : PaginationWidget<EventTickettEntity>(
          items: sn.eventTicket,
          getItems: sn.getEventsTicketItems,
          onDataFetched: sn.onEventsTicketItemsFetched,
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
          child: sn.eventTicket.length > 0 ? ListView.builder(
            itemCount: sn.eventTicket.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: (){
                  Nav.to(AttendanceScreen.routeName,arguments: sn.eventTicket[index]);
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius:  BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(color: Colors.grey, spreadRadius: 1)
                    ],
                    color: Colors.white,),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // color: AppColors.mansourBackArrowColor2,
                          image: DecorationImage(
                            image: NetworkImage(
                                sn.eventTicket[index].clientImage !="" ? sn.eventTicket[index].clientImage : sn.eventTicket[index].client?.avatar?.avatarUrl??""
                            )
                          )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            Text(sn.eventTicket.elementAt(index).clientName,style: const
                            TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            const SizedBox(height: 5,),
                            Text("TID-"+sn.eventTicket.elementAt(index).number,style:
                            const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.textLight2),),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: !sn.eventTicket.elementAt(index).scanned ?   const Color(0xFFFEF3F2) : const Color(0xFF027A48).withOpacity(0.2)
                        ),
                        child:   Center(
                          child: Text(!sn.eventTicket.elementAt(index).scanned ? Translation.current.Not_Checked_In :Translation.current.Checked_In,style: TextStyle(fontSize: 12,
                              color: !sn.eventTicket.elementAt(index).scanned ? const Color(0xFFB42318): const Color(0xFF027A48)),),
                        ),
                      ),
                    ],
                  ),),
              );
            },
          ) :  NoDataWidget(),
        )),
      ],
    );
  }
}
