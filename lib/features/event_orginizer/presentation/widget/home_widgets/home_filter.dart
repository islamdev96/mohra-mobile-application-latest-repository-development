
import 'package:flutter/material.dart';
class HomeFilter extends StatefulWidget {
  const HomeFilter({Key? key}) : super(key: key);

  @override
  State<HomeFilter> createState() => _HomeFilterState();
}

class _HomeFilterState extends State<HomeFilter> {

  late int defaultChoiceIndexLocation;
  late int defaultChoiceIndexTicket;
  late int defaultChoiceIndexCity;
  late int defaultChoiceIndexEventCategory;
  late int defaultChoiceIndexEventDate;
  late int defaultChoiceIndex;

  final List<String> _locationList = ['Local', 'Online'];
  final List<String> _ticketList = ['Free', 'Paid'];
  final List<String> _cityList = ['Abhā','Al-Jawf','Al-Khubar','Al-Qaṭīf','ʿArʿar','Jiddah','Mecca'];
  final List<String> _eventCategoryList = ['Activity', 'Music', 'Confrence','Sport','Atraction','Jiddah','Mecca'];
  final List<String> _eventList = ['Single Date', 'Multi Day'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    defaultChoiceIndex = 0;
    defaultChoiceIndexLocation = 0;
    defaultChoiceIndexTicket = 0;
    defaultChoiceIndexCity = 0;
    defaultChoiceIndexEventCategory = 0;
    defaultChoiceIndexEventDate = 0;
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
                  Text("Event Filter",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
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
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Location",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 10,
                              children: List.generate(_locationList.length, (index) {
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
                                        _locationList[index],
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
                                  selected: defaultChoiceIndexLocation == index,
                                  selectedColor: const Color(0xFFFFEEE9),
                                  onSelected: (value) {
                                    setState(() {
                                      defaultChoiceIndexLocation = value ? index : defaultChoiceIndexLocation;
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
                  // ticket
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Ticket Type",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 10,
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
                                      horizontal: 4),
                                );
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // city list filter
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
                              runSpacing: 6.0,
                              spacing: 15,
                              children: List.generate(_cityList.length, (index) {
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
                                        _cityList[index],
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
                                  selected: defaultChoiceIndexCity == index,
                                  selectedColor: const Color(0xFFFFEEE9),
                                  onSelected: (value) {
                                    setState(() {
                                      defaultChoiceIndexCity = value ? index : defaultChoiceIndexCity;
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
                  // event category list filter
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
                              children: List.generate(_eventCategoryList.length, (index) {
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
                                        _eventCategoryList[index],
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
                                  selected: defaultChoiceIndexEventCategory == index,
                                  selectedColor: const Color(0xFFFFEEE9),
                                  onSelected: (value) {
                                    setState(() {
                                      defaultChoiceIndexEventCategory = value ? index : defaultChoiceIndexEventCategory;
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
                  // event date
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
                              children: List.generate(_eventList.length, (index) {
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
                                        _eventList[index],
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
                                  selected: defaultChoiceIndexEventDate == index,
                                  selectedColor: const Color(0xFFFFEEE9),
                                  onSelected: (value) {
                                    setState(() {
                                      defaultChoiceIndexEventDate = value ? index : defaultChoiceIndexEventDate;
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
                  Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.all(15),
                    height: 50,
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFFF5921)
                    ),
                    child: Center(
                      child: Text("View Event (2)",style: TextStyle(fontSize: 16,color: Colors.white),),
                    ),
                  ),
                  SizedBox(height: 10,)
                ],
              ),
            ))
      ],
    );
  }
}
