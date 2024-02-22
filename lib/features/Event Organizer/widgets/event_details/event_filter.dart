

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/event_orginizer/presentation/state_m/provider/event_organizer_details_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';
class EventFilter extends StatefulWidget {
  final  EventOrganizerDetailsScreenNotifier sn;
   EventFilter({Key? key,required this.sn}) : super(key: key);

  @override
  State<EventFilter> createState() => _HomeFilterState();
}

class _HomeFilterState extends State<EventFilter> {


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: InkWell(
            onTap: (){
             Nav.pop();
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0,left: 15,right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  Text(Translation.current.Filter_attendees,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  Icon(Icons.close)
                ],
              ),
            ),
          ),
        ),
        // location
        Positioned(
            left: 0,
            right: 0,
            top: 80,
            bottom: 0,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Status
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            width: 1.sw,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Translation.current.CheckIn_Status,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                const SizedBox(height: 10,),
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: [
                                    ChoiceChip(
                                      labelPadding: const EdgeInsets.all(2.0),
                                      label: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        height: 40,
                                        width: 150,
                                        child: Center(
                                          child: Text(
                                            Translation.current.all,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          side: const BorderSide(
                                              width: 2,
                                              color: Color(0xFFFFEEE9)
                                          )
                                      ),
                                      selected:widget.sn.isScanned == null,
                                      selectedColor: const Color(0xFFFFEEE9),
                                      onSelected: (value) {
                                        setState(() {
                                          if( widget.sn.isScanned != null){
                                            widget.sn.isScanned = null;
                                          }
                                        });
                                      },
                                      // backgroundColor: color,
                                      elevation: 1,
                                      backgroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                    ),
                                    ChoiceChip(
                                      labelPadding: const EdgeInsets.all(2.0),
                                      label: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        height: 40,
                                        width: 150,
                                        child: Center(
                                          child: Text(
                                            Translation.current.Checked_In,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          side: const BorderSide(
                                              width: 2,
                                              color: Color(0xFFFFEEE9)
                                          )
                                      ),
                                      selected:widget.sn.isScanned == true,
                                      selectedColor: const Color(0xFFFFEEE9),
                                      onSelected: (value) {
                                        setState(() {
                                          widget.sn.isScanned == true ? widget.sn.isScanned = null : widget.sn.isScanned = true;
                                        });
                                      },
                                      // backgroundColor: color,
                                      elevation: 1,
                                      backgroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                    ),
                                    ChoiceChip(
                                      labelPadding: const EdgeInsets.all(2.0),
                                      label: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        height: 40,
                                        width: 150,
                                        child: Center(
                                          child: Text(
                                            Translation.current.Not_Checked_In,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          side: const BorderSide(
                                              width: 2,
                                              color: Color(0xFFFFEEE9)
                                          )
                                      ),
                                      selected:widget.sn.isScanned == false,
                                      selectedColor: const Color(0xFFFFEEE9),
                                      onSelected: (value) {
                                        setState(() {
                                          widget.sn.isScanned == false ? widget.sn.isScanned = null : widget.sn.isScanned = false;
                                        });
                                      },
                                      // backgroundColor: color,
                                      elevation: 1,
                                      backgroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        // ticket
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            width: 1.sw,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Translation.current.Ticket_Type,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                const SizedBox(height: 10,),
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: [
                                    ChoiceChip(
                                      labelPadding: const EdgeInsets.all(2.0),
                                      label: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        height: 40,
                                        width: 150,
                                        child: Center(
                                          child: Text(
                                            Translation.current.silver_ticket,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          side: const BorderSide(
                                              width: 2,
                                              color: Color(0xFFFFEEE9)
                                          )
                                      ),
                                      selected:widget.sn.ticketTypes == 0,
                                      selectedColor: const Color(0xFFFFEEE9),
                                      onSelected: (value) {
                                        setState(() {
                                          widget.sn.ticketTypes == 0 ? widget.sn.ticketTypes = null : widget.sn.ticketTypes = 0;
                                        });
                                      },
                                      // backgroundColor: color,
                                      elevation: 1,
                                      backgroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                    ),
                                    ChoiceChip(
                                      labelPadding: const EdgeInsets.all(2.0),
                                      label: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        height: 40,
                                        width: 150,
                                        child: Center(
                                          child: Text(
                                            Translation.current.gold_ticket,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          side: const BorderSide(
                                              width: 2,
                                              color: Color(0xFFFFEEE9)
                                          )
                                      ),
                                      selected:widget.sn.ticketTypes == 1,
                                      selectedColor: const Color(0xFFFFEEE9),
                                      onSelected: (value) {
                                        setState(() {
                                          widget.sn.ticketTypes == 1 ? widget.sn.ticketTypes = null : widget.sn.ticketTypes = 1;
                                        });
                                      },
                                      // backgroundColor: color,
                                      elevation: 1,
                                      backgroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                    ),
                                    ChoiceChip(
                                      labelPadding: const EdgeInsets.all(2.0),
                                      label: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        height: 40,
                                        width: 150,
                                        child: Center(
                                          child: Text(
                                            Translation.current.platinum_ticket,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          side: const BorderSide(
                                              width: 2,
                                              color: Color(0xFFFFEEE9)
                                          )
                                      ),
                                      selected:widget.sn.ticketTypes == 2,
                                      selectedColor: const Color(0xFFFFEEE9),
                                      onSelected: (value) {
                                        setState(() {
                                          widget.sn.ticketTypes == 2 ? widget.sn.ticketTypes = null : widget.sn.ticketTypes = 2;
                                        });
                                      },
                                      // backgroundColor: color,
                                      elevation: 1,
                                      backgroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                    ),
                                    ChoiceChip(
                                      labelPadding: const EdgeInsets.all(2.0),
                                      label: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        height: 40,
                                        width: 150,
                                        child: Center(
                                          child: Text(
                                            Translation.current.vip_ticket,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          side: const BorderSide(
                                              width: 2,
                                              color: Color(0xFFFFEEE9)
                                          )
                                      ),
                                      selected:widget.sn.ticketTypes == 3,
                                      selectedColor: const Color(0xFFFFEEE9),
                                      onSelected: (value) {
                                        setState(() {
                                          widget.sn.ticketTypes == 3 ? widget.sn.ticketTypes = null : widget.sn.ticketTypes = 3;
                                        });
                                      },
                                      // backgroundColor: color,
                                      elevation: 1,
                                      backgroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                    ),
                                    ChoiceChip(
                                      labelPadding: const EdgeInsets.all(2.0),
                                      label: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        height: 40,
                                        width: 150,
                                        child: Center(
                                          child: Text(
                                            Translation.current.free_ticket,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          side: const BorderSide(
                                              width: 2,
                                              color: Color(0xFFFFEEE9)
                                          )
                                      ),
                                      selected:widget.sn.ticketTypes == 4,
                                      selectedColor: const Color(0xFFFFEEE9),
                                      onSelected: (value) {
                                        setState(() {
                                          widget.sn.ticketTypes == 4 ? widget.sn.ticketTypes = null : widget.sn.ticketTypes = 4;
                                        });
                                      },
                                      // backgroundColor: color,
                                      elevation: 1,
                                      backgroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        // city list filter
                      ],
                    ),
                  ),
                ),
                // button
                InkWell(
                  onTap: (){
                    widget.sn.getEventTickets();
                    Nav.pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.all(15),
                    height: 50,
                    decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFFF5921)
                    ),
                    child: Center(
                      child: Text(Translation.current.view_details,style: TextStyle(fontSize: 16,color: Colors.white),),
                    ),
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
