
import 'package:flutter/material.dart';
import 'package:starter_application/features/event_orginizer/presentation/state_m/provider/event_organizer_screen_notifier.dart';

import 'home_filter.dart';

class EventAndSettingsWidgets extends StatelessWidget {
  EventAndSettingsWidgets({Key? key}) : super(key: key);

  List<String> itemList = ['Latest event','Name: A-Z','Price: high to high','Price: high to low','Attendes: high to low','Attendes: low to high'
  ,'Event Date: old to new','Event Date: new to old'];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // events items
          Row(
            children: [
              Image.asset("assets/icons/events.png",width: 40,height: 40,),
              const SizedBox(width: 10,),
              const Text("10 events",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18),)
            ],
          ),
          // settings & sort widgets
          Row(
            children: [
              InkWell(
                onTap: (){
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
                    ),
                      context: context,
                      builder: (BuildContext context){
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:  [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Sort event by",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
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
                              // list of items
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: itemList.length,
                                  itemBuilder: (BuildContext context, index){
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: (Text(itemList.elementAt(index),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.normal),)),
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
                    children:  const [
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text("Sort"),
                      ),
                      SizedBox(width: 10,),
                      Icon(Icons.keyboard_arrow_down,size: 20,),
                      SizedBox(width: 10,),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 0,),
              const SizedBox(width: 0,),
              InkWell(
                onTap: (){
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => Container(
                      height: MediaQuery.of(context).size.height * 0.95,
                      decoration:  const BoxDecoration(
                        color: Colors.white,
                        borderRadius:  BorderRadius.only(
                          topLeft:  Radius.circular(25.0),
                          topRight:  Radius.circular(25.0),
                        ),
                      ),
                      child:  HomeFilter(sn: EventOrganizerScreenNotifier(),),
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
          // setting widget

        ],
      ),
    );
  }
}
