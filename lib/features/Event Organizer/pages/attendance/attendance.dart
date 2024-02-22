
import 'package:flutter/material.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';

import 'cancel_action.dart';
import 'check_action.dart';
class Attendance extends StatelessWidget {
  const Attendance({Key? key,this.avatar,this.name,this.status}) : super(key: key);

  final String? avatar;
  final String? name;
  final String? status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 38.0,left: 10),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children:  [
                InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child:  Icon(AppConstants.getIconBack())),
                /*Image.asset("assets/icons/search_icon.png",height: 40,width: 40,),
                        const SizedBox(width: 10,),
                        InkWell(
                            onTap: (){},
                            child: Image.asset("assets/icons/side_bar_icon.png",height: 40,width: 40,))*/
              ],
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
                   Image.asset(avatar!,height: 80,width: 80,),
                   const SizedBox(width: 10,),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children:  [
                        Text(name!,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFFF2F4F7)
                          ),
                            child: Text(status!,style: TextStyle(fontSize: 15,
                                color: status=="Canceled"?const Color(0xFFB42318):
                                status=="Not Checked-In"?const Color(0xFF000000):const Color(0xFF027A48)),))
                     ],
                   )
                 ],
             ),
              ),
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

              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // button 1
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => CancelAction())
                      );
                    },
                    child: Container(
                      width: 150,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD92D20),
                        border: Border.all(width: 2.0,color: Colors.transparent),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Cancel",style: TextStyle(color: Colors.white),),
                          const SizedBox(width: 10,),
                          const Icon(Icons.close,color: Colors.white,)
                        ],
                      ),
                    ),
                  ),
                  // button 2
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const CheckAction())
                      );
                    },
                    child: Container(
                      width: 150,
                      height: 50.0,
                      decoration: BoxDecoration(
                          color: const Color(0xFF039855),
                          border: Border.all(width: 2.0,color: Colors.green),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Check-In",style: TextStyle(color: Colors.white),),
                          const SizedBox(width: 10,),
                          const Icon(Icons.check,color: Colors.white,)
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10,)
            ],
          ),
    ));
  }
}
