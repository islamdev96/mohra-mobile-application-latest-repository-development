
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../Event Organizer/data/models/event_status.dart';
import '../../../../Event Organizer/pages/attendance/attendance.dart';
import '../../../../Event Organizer/pages/attendance/cancel_action.dart';

class EventBody extends StatelessWidget {
   EventBody({Key? key}) : super(key: key);

  final List<EventStatus> eventList = [
    EventStatus(avatar: "assets/images/avatar1.png",userName: "Darrell Steward", eventId: "TID-12555456",status: "Not Checked-In"),
    EventStatus(avatar: "assets/images/avatar2.png",userName: "Hanna Jhoanesn",eventId: "TID-12555456",status: "Canceled"),
    EventStatus(avatar: "assets/images/avatar3.png",userName: "Leslie Alexander",eventId: "TID-12555456",status: "Checked-In"),
    EventStatus(avatar: "assets/images/avatar4.png",userName: "Darrell Steward",eventId: "TID-12555456",status: "Checked-In"),
    EventStatus(avatar: "assets/images/avatar5.png",userName: "Brooklyn Simmons",eventId: "TID-12555456",status: "Checked-In")
  ];

   void doNothing(BuildContext context) {}
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: eventList.length,
            itemBuilder: (BuildContext context,int index){
              return InkWell(
                onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Attendance(
                        avatar: eventList[index].avatar,name: eventList[index].userName,status: eventList[index].status,))
                  );
                },
                child: Slidable(
                    key: const ValueKey(1),
                    endActionPane: ActionPane(
                      // A motion is a widget used to control how the pane animates.
                      motion: const ScrollMotion(),
                      // A pane can dismiss the Slidable.
                      dismissible: DismissiblePane(onDismissed: () {}),
                      // All actions are defined in the children parameter.
                      children:  [
                        // A SlidableAction can have an icon and/or a label.
                        InkWell(
                          onTap: (){
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => CancelAction())
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            height: 65,
                            width: 65,
                            child: Center(
                              child: SlidableAction(
                                borderRadius: BorderRadius.circular(10),
                                onPressed: doNothing,
                                backgroundColor: const Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.close,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(5),
                          height: 65,
                          width: 65,
                          child: SlidableAction(
                            borderRadius: BorderRadius.circular(10),
                            onPressed: doNothing,
                            backgroundColor: const Color(0xFF21B7CA),
                            foregroundColor: Colors.white,
                            icon: Icons.compare_arrows_outlined,
                          ),
                        ),
                      ],
                    ),
                    child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius:  BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(color: Colors.grey, spreadRadius: 1)
                          ],
                          color: Colors.white,),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              child: Image.asset(eventList.elementAt(index).avatar!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  Text(eventList.elementAt(index).userName!,style: const
                                  TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  const SizedBox(height: 5,),
                                  Text(eventList.elementAt(index).eventId!,style:
                                  const TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xFFFEF3F2)
                              ),
                              child:   Center(
                                child: Text(eventList[index].status!,
                                  style: TextStyle(color: eventList[index].status=="Canceled"?const Color(0xFFB42318):
                                  eventList[index].status=="Not Checked-In"?const Color(0xFF000000):const Color(0xFF027A48)),),
                              ),
                            ),
                          ],
                        ),),
                ),
              );
            }),
        ],
    );
  }
}
