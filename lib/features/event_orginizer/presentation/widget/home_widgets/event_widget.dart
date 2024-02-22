
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Event Organizer/pages/event_details/event_details.dart';

class EventsWidget extends StatelessWidget {
  const EventsWidget({Key? key,this.id,this.eventImage,this.evenName,this.eventDate,this.recccuring}) : super(key: key);

  final int? id;
  final String? eventImage;
  final String? evenName;
  final String? eventDate;
  final bool? recccuring;

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => EventDetails())
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0,right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      height: 100,
                      width: 110,
                      decoration:  BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(eventImage!),
                        )
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: recccuring==true?const Color(0xFFFFDED3):Colors.white
                        ),
                        child:  Center(
                          child: recccuring==true?const Text("Recccuring",style: TextStyle(color: Color(0xFFCC471A)),):null,
                        ),
                      ),
                       SizedBox(
                         width: .55.sw,
                         child: Text(evenName!,overflow: TextOverflow.ellipsis, softWrap: false,maxLines: 3,style: TextStyle(
                           fontSize: 20,fontWeight: FontWeight.bold
                         ),),
                       ),
                       const SizedBox(height: 10,),
                       SizedBox(
                           width: .55.sw,
                           child: Text(eventDate!)),
                    ],
                  ),

                ],

              ),
              InkWell(
                onTap: (){

                },
                  child: const Center(child: Icon(Icons.arrow_forward_ios_outlined)))
            ],
          ),
        ),
      ),
    );
  }
}
