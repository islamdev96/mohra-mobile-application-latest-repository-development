
import 'package:flutter/material.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/features/event_orginizer/presentation/state_m/provider/event_organizer_details_screen_notifier.dart';

import '../../../../core/navigation/nav.dart';
import '../../../event/presentation/screen/ticket_qrCode_screen.dart';
import '../../widgets/event_details/details_widget.dart';
import '../../widgets/event_details/event_body.dart';
import '../ticket_manual/manual_check_in.dart';
import '../ticket_search/ticket_search.dart';

class EventDetails extends StatefulWidget {
   const EventDetails({Key? key}) : super(key: key);

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {

  late SnackBar snackBar;
  late SnackBar snackBar2;
  @override
  Widget build(BuildContext context) {
     snackBar = SnackBar(
      backgroundColor: const Color(0xFF039855),
      elevation: 0,
      content: Row(
        children: [
          Image.asset("assets/images/circle_check.png",height: 28,width: 28,),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Checked-In!\nTap here to open ticket details !', style: TextStyle(color: Colors.white)),
          ),
          const Spacer(),
          const Icon(Icons.close,color: Colors.white,)
        ],
      ),
    );

     snackBar2 = SnackBar(
       backgroundColor: const Color(0xFFD92D20),
       elevation: 0,
       content: Row(
         children: [
           Image.asset("assets/images/error.png",height: 28,width: 28,),
           const Padding(
             padding: EdgeInsets.only(left: 8.0),
             child: Text('Cannot Read Ticket!\nTap to checkin manually!', style: TextStyle(color: Colors.white)),
           ),
           const Spacer(),
           const Icon(Icons.close,color: Colors.white,)
         ],
       ),
     );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        flexibleSpace: SafeArea(
          child:  Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:  [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                        child:  Icon(AppConstants.getIconBack())),
                    const Center(child: Text('Attendance',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),)),
                  ],
                ),

                InkWell(
                  onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => TicketSearch())
                    );
                  },
                    child: Image.asset("assets/icons/search_icon.png",height: 25,width: 25,)),
              ],
            ),
          ),
        ),
      ),
    body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: const Padding(
                      padding:  EdgeInsets.all(8.0),
                      child:  Text("PMP Certification Training \nin Al Khobar Saudi Arabia",style:
                      TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0,bottom: 10),
                    child: Text("Riyadh, 5 August 10:00 - 16:00",style:
                    TextStyle(fontWeight: FontWeight.normal,fontSize: 20,color: Colors.grey),),
                  ),
                  // progress
                   ProgressAndSettingsWidgets(sn: EventOrganizerDetailsScreenNotifier(),),
                  const SizedBox(height: 10,),
                  EventBody(),
                ],
              ),
            ),
          ),
         Positioned(
           left: 0,
             right: 0,
             bottom: 0,
             child:  InkWell(
               onTap: _scan,
               child: Stack(
                 children: [
                   Align(
                     alignment: Alignment.bottomCenter,
                     child: Container(
                       decoration: const BoxDecoration(
                         color: Color(0xFFFF5921),
                       ),
                       child: Center(child: Image.asset("assets/images/scanner.png",height: 100,width: 50,)),
                     ),
                   )
                 ],
               ),
             ))
        ],
      ),
    );
  }

  Future _scan() async {
    Nav.to(TicketQrCodeScreen.routeName);
    /*String barcode = await scanner.scan();
    if (barcode == null) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ManualCheckIn())
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar2);
      print('nothing return.');
    } else {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const EventDetails())
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print("bar============"+barcode);
    }*/
  }
}
