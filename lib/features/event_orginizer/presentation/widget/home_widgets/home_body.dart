
import 'package:flutter/material.dart';

import '../../../../Event Organizer/data/models/events_model.dart';
import 'event_widget.dart';


class HomeBody extends StatelessWidget {

  HomeBody({Key? key}) : super(key: key);

  List<EventsModel> eventsList = [
    EventsModel(id: 1,eventImage: "assets/images/img_1.png",eventName: "PMP Certification Training",eventDate: "Riyadh, 5 August 10:00 - 16:00",recccuring: false),
    EventsModel(id: 2,eventImage: "assets/images/img_2.png",eventName: "GN-S Berkeley Sr Ct ",eventDate: "Riyadh, 5 August 10:00 - 16:00",recccuring: true),
    EventsModel(id: 3,eventImage: "assets/images/img_3.png",eventName: "HDM-Berkeley Srs Sangaree ",eventDate: "Riyadh, 5 Nov - 01 Dec 2022",recccuring: false),
    EventsModel(id: 4,eventImage: "assets/images/img_4.png",eventName: "Transp-S Berkeley Sr Ct",eventDate: "Riyadh, 5 Nov - 01 Dec 2022",recccuring: false),
    EventsModel(id: 5,eventImage: "assets/images/img_5.png",eventName: "HDM-Moncks Corner Sr Ct ",eventDate: "Riyadh, 5 August 10:00 - 16:00",recccuring: false),
    EventsModel(id: 6,eventImage: "assets/images/img_6.png",eventName: "Transp-S Berkeley Sr Ct",eventDate: "Riyadh, 5 August 10:00 - 16:00",recccuring: false),
    EventsModel(id: 7,eventImage: "assets/images/img_2.png",eventName: "GN-Moncks Corner Sr Ct ",eventDate: "Riyadh, 5 August 10:00 - 16:00",recccuring: false)
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: eventsList.length,
        itemBuilder: (context, index) {
          return  Padding(
            padding: const EdgeInsets.only(top: 20.0,bottom: 0),
            child: EventsWidget(
              id: eventsList.elementAt(index).id,
              eventImage: eventsList.elementAt(index).eventImage,
              evenName: eventsList.elementAt(index).eventName,
              eventDate: eventsList.elementAt(index).eventDate,
              recccuring: eventsList.elementAt(index).recccuring,
            ),
          );
        },
    );
  }
}
