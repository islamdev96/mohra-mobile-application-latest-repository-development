
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/features/event_orginizer/domain/entity/my_running_events_entity.dart';
import 'package:starter_application/features/event_orginizer/presentation/screen/event_organizer_details_screen.dart';
import 'package:starter_application/features/mylife/presentation/logic/date_time_helper.dart';

import '../../pages/event_details/event_details.dart';

class EventsWidget extends StatelessWidget {
  const EventsWidget({Key? key,this.eventItemEntity}) : super(key: key);
  final EventItemEntity? eventItemEntity;


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: InkWell(
        onTap: (){
          Nav.to(EventOrganizerDetailsScreen.routeName,arguments: eventItemEntity!.toJson());
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: .20.sw,
                      width: .20.sw,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(eventItemEntity?.mainPicture??"",)
                        ),
                      ),
                    ),
                  ),
                  Gaps.hGap32,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: eventItemEntity?.repeat==1 ?const Color(0xFFFFDED3):Colors.white
                        ),
                        child:  eventItemEntity?.repeat==1 ?const Text("Recccuring",style: TextStyle(color: Color(0xFFCC471A)),):null,
                      ),
                       SizedBox(
                         width: .60.sw,
                         child: Text(eventItemEntity?.title??"",overflow: TextOverflow.ellipsis, softWrap: false,maxLines: 3,style: TextStyle(
                           fontSize: 16,fontWeight: FontWeight.w700
                         ),),
                       ),
                       const SizedBox(height: 10,),
                       SizedBox(
                           width: .55.sw,
                           child: Text((eventItemEntity?.cityName?? "") + ", "+DateTimeHelper.getFormatedDate(eventItemEntity?.startDate)!)),
                    ],
                  ),

                ],

              ),
              InkWell(
                onTap: (){
                  Nav.to(EventOrganizerDetailsScreen.routeName,arguments: eventItemEntity!.toJson());
                },
                  child: const Center(child: Icon(Icons.arrow_forward_ios_outlined,size: 15,)))
            ],
          ),
        ),
      ),
    );
  }
}
