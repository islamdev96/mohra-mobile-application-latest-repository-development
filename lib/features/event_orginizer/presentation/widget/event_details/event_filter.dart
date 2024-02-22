

import 'package:flutter/material.dart';
class EventFilter extends StatefulWidget {
  const EventFilter({Key? key}) : super(key: key);

  @override
  State<EventFilter> createState() => _HomeFilterState();
}

class _HomeFilterState extends State<EventFilter> {

  late int defaultChoiceIndexCheckIn;
  late int defaultChoiceIndexTicket;
  late int defaultChoiceIndexSeat;

  final List<String> _checkInStatusList = ['All', 'Checked-In','Not Checked-In','Cancelled'];
  final List<String> _ticketList = ['Basic', 'Premium','VIP'];
  final List<String> _seatPositionList = ['Seat #1', 'Seat #2','Seat #3'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    defaultChoiceIndexTicket = 0;
    defaultChoiceIndexCheckIn = 0;
    defaultChoiceIndexSeat = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0,left: 15,right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Filter attendees",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // check In Status List filter
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("City",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              runAlignment: WrapAlignment.start,
                              runSpacing: 10.0,
                              spacing: 15,
                              children: List.generate(_checkInStatusList.length, (index) {
                                return ChoiceChip(
                                  labelPadding: const EdgeInsets.all(2.0),
                                  label: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    height: 40,
                                    width: 100,
                                    child: Center(
                                      child: Text(
                                        _checkInStatusList[index],
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
                                  selected: defaultChoiceIndexCheckIn == index,
                                  selectedColor: const Color(0xFFFFEEE9),
                                  onSelected: (value) {
                                    setState(() {
                                      defaultChoiceIndexCheckIn = value ? index : defaultChoiceIndexCheckIn;
                                    });
                                  },
                                  // backgroundColor: color,
                                  elevation: 1,
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                );
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // ticket List filter
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("Event Category",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              runAlignment: WrapAlignment.start,
                              runSpacing: 6.0,
                              spacing: 15,
                              children: List.generate(_ticketList.length, (index) {
                                return ChoiceChip(
                                  labelPadding: const EdgeInsets.all(2.0),
                                  label: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    height: 40,
                                    width: 70,
                                    child: Center(
                                      child: Text(
                                        _ticketList[index],
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
                                  selected: defaultChoiceIndexTicket == index,
                                  selectedColor: const Color(0xFFFFEEE9),
                                  onSelected: (value) {
                                    setState(() {
                                      defaultChoiceIndexTicket = value ? index : defaultChoiceIndexTicket;
                                    });
                                  },
                                  // backgroundColor: color,
                                  elevation: 1,
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                );
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // seat Position List filter
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:  EdgeInsets.only(left: 2.0),
                          child:  Text("Event Date",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 10,
                              children: List.generate(_seatPositionList.length, (index) {
                                return ChoiceChip(
                                  labelPadding: const EdgeInsets.all(2.0),
                                  label: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    height: 40,
                                    width: 90,
                                    child: Center(
                                      child: Text(
                                        _seatPositionList[index],
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
                                  selected: defaultChoiceIndexSeat == index,
                                  selectedColor: const Color(0xFFFFEEE9),
                                  onSelected: (value) {
                                    setState(() {
                                      defaultChoiceIndexSeat = value ? index : defaultChoiceIndexSeat;
                                    });
                                  },
                                  // backgroundColor: color,
                                  elevation: 1,
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4),
                                );
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // button
                  SizedBox(height: 20,),
                  Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.all(15),
                    height: 50,
                    decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFFF5921)
                    ),
                    child: const Center(
                      child: Text("View Event (2)",style: TextStyle(fontSize: 16,color: Colors.white),),
                    ),
                  ),
                  const SizedBox(height: 10,)
                ],
              ),
            ))
      ],
    );
  }
}
