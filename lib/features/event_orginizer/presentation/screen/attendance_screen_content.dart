import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/event_orginizer/presentation/state_m/cubit/event_orginizer_cubit.dart';
import 'package:starter_application/features/health/presentation/state_m/provider/health_count_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';
import '../../../../core/common/app_colors.dart';
import '../../../../core/ui/widgets/custom_network_image_widget.dart';
import '../../../Event Organizer/pages/attendance/cancel_action.dart';
import '../../../Event Organizer/pages/attendance/check_action.dart';
import '../../../mylife/presentation/logic/date_time_helper.dart';
import '../screen/../state_m/provider/attendance_screen_notifier.dart';

class AttendanceScreenContent extends StatelessWidget {
  late AttendanceScreenNotifier sn;
  @override
  Widget build(BuildContext context) {
    sn = Provider.of<AttendanceScreenNotifier>(context);
    sn.context = context;
    return ProgressHUD(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: BlocConsumer<EventOrginizerCubit,EventOrginizerState>(
          bloc: sn.eventOrginizerCubit,
          listener: (context , state){
            if(state is GetTicketDetailsDone){
              sn.onTicketDetailsLoaded(state.eventTicketEntity);
            }
            if (state is ManualCheckTicket){
              ProgressHUD.of(context)!.show();
            }
            if ( state is ManualCheckTicketDone){
              ProgressHUD.of(context)!.dismiss();
              sn.onCheckedDone();
            }
          },
          builder: (context,state){
            return state.maybeMap(
              eventOrginizerLoadingState: (s)=>WaitingWidget(),
              eventOrginizerInitState:  (s)=>WaitingWidget(),
              eventOrginizerErrorState: (s)=> ErrorScreenWidget(error: s.error, callback: (){}),
              orElse: ()=>buildData(),
              getTicketDetailsDone: (s)=> buildData(),
            );
          },
        ),
      ),
    );
  }

  buildData(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          // row widget
          child: Row(
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.mansourBackArrowColor2,
                    image: DecorationImage(
                        image: NetworkImage(
                            sn.eventTicketEntity.client!.imageUrl
                        )
                    )
                ),
                child: Icon(Icons.broken_image),
              ),
              const SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children:  [
                  Text(sn.eventTicketEntity.client!.name,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFFF2F4F7)
                      ),
                      child: Text(!sn.eventTicketEntity.scanned ? Translation.current.Check_In :Translation.current.Checked_In,style: TextStyle(fontSize: 15,
                          color: !sn.eventTicketEntity.scanned ?const Color(0xFFB42318): const Color(0xFF027A48)),))

                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text('${sn.eventTicketEntity.event!.title}',style:
          TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text("${sn.eventTicketEntity.event!.cityName}, ${DateTimeHelper.getFormatedDate(sn.eventTickettEntity.date)}",style:
          TextStyle(fontWeight: FontWeight.normal,fontSize: 20,color: Colors.grey),),
        ),
        const SizedBox(height: 20,),
        // Ticket widget

         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 8),
           child: Text(Translation.current.Ticket_Number,style:
        TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey),),
         ),
        const SizedBox(height: 10,),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 8),
           child: Text("${sn.eventTicketEntity.number}",style: TextStyle(fontSize: 18,color: Colors.black,)),
         ),

        const SizedBox(height: 20,),
        // order widget
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 8),
           child: Text(Translation.current.Booking_ID,style:
        TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey),),
         ),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text("#${sn.eventTicketEntity.bookingId}",style: TextStyle(fontSize: 18,color: Colors.black,)),
        ),

        const SizedBox(height: 20,),
        // Price widget
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 8),
           child: Text( Translation.current.price,style:
        TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey),),
         ),
        const SizedBox(height: 10,),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 8),
           child: Text("${sn.eventTicketEntity.price} SAR",style: TextStyle(fontSize: 18,color: Colors.black,)),
         ),

        // const Spacer(),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     // button 1
        //
        //     // button 2
        //     buildButton(),
        //   ],
        // ),
        const SizedBox(height: 40,)
      ],
    );
  }

  buildButton(){
    return sn.eventTicketEntity.scanned? InkWell(
      onTap: (){
       // sn.onCheckTapped();
      },
      child: Container(
        width: 0.9.sw,
        height: 50.0,
        decoration: BoxDecoration(
            color: AppColors.greyBackButton,
            border: Border.all(width: 2.0,color: AppColors.greyBackButton,),
            borderRadius: BorderRadius.circular(15)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text("${sn.eventTicketEntity.scanned ? Translation.current.Checked_In: Translation.current.Check_In}",style: TextStyle(color: Colors.white),),
            const SizedBox(width: 10,),
            const Icon(Icons.check,color: Colors.white,)
          ],
        ),
      ),
    ):InkWell(
      onTap: (){
        sn.onCheckTapped();
      },
      child: Container(
        width: 0.9.sw,
        height: 50.0,
        decoration: BoxDecoration(
            color: const Color(0xFF039855),
            border: Border.all(width: 2.0,color: Colors.green),
            borderRadius: BorderRadius.circular(15)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text(Translation.current.Check_In,style: TextStyle(color: Colors.white),),
            const SizedBox(width: 10,),
            const Icon(Icons.check,color: Colors.white,)
          ],
        ),
      ),
    );
  }
}
