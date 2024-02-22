
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/event_orginizer/presentation/state_m/provider/event_organizer_details_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

import 'event_filter.dart';

class ProgressAndSettingsWidgets extends StatefulWidget {
   EventOrganizerDetailsScreenNotifier sn;
   ProgressAndSettingsWidgets({Key? key,required this.sn}) : super(key: key);

  @override
  State<ProgressAndSettingsWidgets> createState() => _ProgressAndSettingsWidgetsState();
}

class _ProgressAndSettingsWidgetsState extends State<ProgressAndSettingsWidgets> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // events items
          InkWell(
            onTap: (){
              showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
                  ),
                  context: context,
                  builder: (BuildContext context){
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:  [
                                 Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(Translation.current.Attendees_Info,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                ),
                                InkWell(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset("assets/icons/cancel.png",width: 24,height: 20,),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // item1
                              InkWell(
                                onTap: (){},
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap:(){},
                                      child: Container(
                                        height: size.width * 0.45,
                                        width: size.width * 0.45,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: Colors.orange
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 20,),
                                              Image.asset("assets/icons/info1.png",height: 20,width: 20,),
                                              if(widget.sn.getTicketReportResponseEntity != null)
                                              const SizedBox(height: 10,),
                                               Text(widget.sn.getTicketReportResponseEntity!.allTicketCount.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                              const SizedBox(height: 20,),
                                               Text(Translation.current.Total_Ticket),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20,),
                                    InkWell(
                                      onTap: (){},
                                      child: Container(
                                        height: size.width * 0.45,
                                        width: size.width * 0.45,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.green
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 20,),
                                              Image.asset("assets/icons/info3.png",height: 20,width: 20,),
                                              const SizedBox(height: 10,),
                                              if(widget.sn.getTicketReportResponseEntity != null)
                                               Text(widget.sn.getTicketReportResponseEntity!.ticketScannedCount.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                              const SizedBox(height: 20,),
                                               Text(Translation.current.Checked_In),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20,),
                              //item2
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: size.width * 0.45,
                                    width: size.width * 0.45,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: const Color(0xFFEAECF0)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 20,),
                                          Image.asset("assets/icons/info2.png",height: 20,width: 20,),
                                          const SizedBox(height: 10,),
                                          if(widget.sn.getTicketReportResponseEntity != null)
                                           Text(widget.sn.getTicketReportResponseEntity!.totalTicketCount.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                          const SizedBox(height: 20,),
                                           Text(Translation.current.Not_Checked_In),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  Container(
                                    height: size.width * 0.45,
                                    width: size.width * 0.45,
                                    // decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.circular(10),
                                        // color: Colors.red
                                    // ),
                                    // child: Padding(
                                    //   padding: const EdgeInsets.all(15.0),
                                    //   child: Column(
                                    //     crossAxisAlignment: CrossAxisAlignment.start,
                                    //     children: [
                                    //       const SizedBox(height: 20,),
                                    //       Image.asset("assets/icons/info4.png",height: 20,width: 20,),
                                    //       const SizedBox(height: 10,),
                                    //       const Text("12",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                    //       const SizedBox(height: 20,),
                                    //       const Text("Canceled"),
                                    //     ],
                                    //   ),
                                    // ),
                                  )
                                ],
                              )
                            ],
                          )

                        ],
                      ),
                    );
                  });
            },
            child: Row(
              children: [
                CircularProgressIndicator(
                  value: widget.sn.getProgress(),
                  color: Colors.green, //<-- SEE HERE
                  backgroundColor: Colors.grey, //<-- SEE HERE
                ),
                const SizedBox(width: 10,),
                if(widget.sn.getTicketReportResponseEntity != null)
                 Text(widget.sn.getTicketReportResponseEntity!.ticketScannedCount.toString()+ "/" +widget.sn.getTicketReportResponseEntity!.allTicketCount.toString()+" "+Translation.current.Checked_In,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18),)
              ],
            ),
          ),
          // settings & sort widgets
          Row(
            children: [
              InkWell(
                onTap: (){
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
                                  itemCount: widget.sn.itemList.length,
                                  itemBuilder:
                                      (BuildContext context, index) {
                                    return GestureDetector(
                                      onTap:(){
                                        widget.sn.sortEventsList(widget.sn.itemList[index]);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: (Text(
                                            widget.sn.itemTrList.elementAt(index),
                                            style:  TextStyle(
                                                fontSize: 20,
                                                color: (widget.sn.itemList.elementAt(index) == widget.sn.keySorting) ? AppColors.mansourBackArrowColor2 : AppColors.black,
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
                    borderRadius:  BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(color: Colors.grey, spreadRadius: 1)
                    ],
                    color: Colors.white,
                  ),
                  child: Row(
                    children:   [
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(Translation.current.sort),
                      ),
                      SizedBox(width: 10,),
                      Icon(Icons.keyboard_arrow_down,size: 20,),
                      SizedBox(width: 10,),
                    ],
                  ),
                ),
              ),
              //
              // filter button
              InkWell(
                onTap: (){
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      decoration:  const BoxDecoration(
                        color: Colors.white,
                        borderRadius:  BorderRadius.only(
                          topLeft:  Radius.circular(25.0),
                          topRight:  Radius.circular(25.0),
                        ),
                      ),
                      child:  EventFilter(sn: widget.sn,),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius:  BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, spreadRadius: 1)
                      ],
                      color: Colors.white
                  ),
                  child:  Builder(
                      builder: (context) {
                        return Image.asset("assets/icons/settings.png",width: 20,height: 20,);
                      }
                  ),
                ),
              )
            ],
          ),

        ],
      ),
    );
  }
}
