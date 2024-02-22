
import 'package:flutter/material.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';

import '../event_details/event_details.dart';
class CancelDone extends StatelessWidget {
  const CancelDone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const EventDetails())
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 38.0,left: 10),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children:   [
                  Icon(AppConstants.getIconBack()),
                  /*Image.asset("assets/icons/search_icon.png",height: 40,width: 40,),
                          const SizedBox(width: 10,),
                          InkWell(
                              onTap: (){},
                              child: Image.asset("assets/icons/side_bar_icon.png",height: 40,width: 40,))*/
                ],
              ),
            ),
          ),
        ),
        flexibleSpace: InkWell(
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const EventDetails())
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 38.0,left: 10),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children:   [
                  Icon(AppConstants.getIconBack()),
                  /*Image.asset("assets/icons/search_icon.png",height: 40,width: 40,),
                          const SizedBox(width: 10,),
                          InkWell(
                              onTap: (){},
                              child: Image.asset("assets/icons/side_bar_icon.png",height: 40,width: 40,))*/
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              // row widget
              child: Row(
                children: [
                  Image.asset("assets/images/avatar1.png",height: 80,width: 80,),
                  const SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      const Text("Darell Steward",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xFFFEF3F2)
                          ),
                          child: const Text("Cancelled: 06:07 PM",style: TextStyle(fontSize: 15,color: Colors.redAccent),))
                    ],
                  )
                ],
              ),
            ),
            // cancel border

            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius:  BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(color: Colors.red, spreadRadius: 1)
                ],
                color: Colors.white,),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Cancellation reason: Customer can’t \ncome to the event",style:
                        TextStyle(fontSize: 18,fontWeight:
                        FontWeight.normal,color: Colors.red,letterSpacing: .6),),
                      ],
                    ),
                  ),
                ],
              ),),

            const SizedBox(height: 10,),
            const Text("PMP Certification Training \nin Al Khobar Saudi Arabia",style:
            TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            const Text("5 August 10:00 - 16:00",style: TextStyle(fontSize: 18,color: Colors.grey,)),

            const SizedBox(height: 20,),
            // Ticket widget
            const Text("Ticket Number",style:
            TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey),),
            const SizedBox(height: 10,),
            const Text("5 August 10:00 - 16:00",style: TextStyle(fontSize: 18,color: Colors.black,)),

            const SizedBox(height: 20,),
            // order widget
            const Text("Order ID",style:
            TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey),),
            const SizedBox(height: 10,),
            const Text("#1558",style: TextStyle(fontSize: 18,color: Colors.black,)),

            const SizedBox(height: 20,),
            // Ticket/Seat widget
            const Text("Ticket/Seat",style:
            TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey),),
            const SizedBox(height: 10,),
            const Text("General, A1",style: TextStyle(fontSize: 18,color: Colors.black,)),

            const SizedBox(height: 20,),
            // Price widget
            const Text("Price",style:
            TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey),),
            const SizedBox(height: 10,),
            const Text("560.00 SAR",style: TextStyle(fontSize: 18,color: Colors.black,)),

          ],
        ),
      ),
    );
  }
}
