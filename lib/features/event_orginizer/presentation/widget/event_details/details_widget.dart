
import 'package:flutter/material.dart';

import 'event_filter.dart';

class ProgressAndSettingsWidgets extends StatefulWidget {
  const ProgressAndSettingsWidgets({Key? key}) : super(key: key);

  @override
  State<ProgressAndSettingsWidgets> createState() => _ProgressAndSettingsWidgetsState();
}

class _ProgressAndSettingsWidgetsState extends State<ProgressAndSettingsWidgets> {

  List<String> itemsList = ['Name: A-Z','Name: Z-A','Price: high to high','Price: high to low',];

  @override
  Widget build(BuildContext context) {
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
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:  [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Attendees Info",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
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
                                        height: 180,
                                        width: 200,
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
                                              const SizedBox(height: 10,),
                                              const Text("12",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                              const SizedBox(height: 20,),
                                              const Text("Total Ticket"),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20,),
                                    InkWell(
                                      onTap: (){},
                                      child: Container(
                                        height: 180,
                                        width: 200,
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
                                              const Text("12",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                              const SizedBox(height: 20,),
                                              const Text("Checked-In"),
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
                                    height: 180,
                                    width: 200,
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
                                          const Text("12",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                          const SizedBox(height: 20,),
                                          const Text("Not Checked-In"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  Container(
                                    height: 180,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.red
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 20,),
                                          Image.asset("assets/icons/info4.png",height: 20,width: 20,),
                                          const SizedBox(height: 10,),
                                          const Text("12",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                          const SizedBox(height: 20,),
                                          const Text("Canceled"),
                                        ],
                                      ),
                                    ),
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
                Image.asset("assets/icons/progress.png",width: 40,height: 40),
                const SizedBox(width: 10,),
                const Text("6/12 Checked-In",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18),)
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
                                  itemCount: itemsList.length,
                                  itemBuilder: (BuildContext context, index){
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: (Text(itemsList.elementAt(index),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.normal),)),
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
                      child: const EventFilter(),
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
          // setting widget

        ],
      ),
    );
  }
}
