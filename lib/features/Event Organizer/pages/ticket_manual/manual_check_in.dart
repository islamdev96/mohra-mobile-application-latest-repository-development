
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';

import '../event_details/event_details.dart';
class ManualCheckIn extends StatefulWidget {
  ManualCheckIn({Key? key}) : super(key: key);

  @override
  State<ManualCheckIn> createState() => _ManualCheckInState();
}

class _ManualCheckInState extends State<ManualCheckIn> {
  TextEditingController controller = TextEditingController();

  final _form = GlobalKey<FormState>();
  bool isValid = false;
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
            padding: const EdgeInsets.only(top: 10.0,left: 10),
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
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        title: const Text("Manual Check-in",style: TextStyle(color: Colors.black),),
      ),
        body:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                const Text("Enter ticket number"),
                const SizedBox(height: 10,),
                Form(
                  key: _form,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (val){
                      setState(() {
                        if(val != "123-456-789"){
                          isValid=false;
                        }else{
                          isValid = true;
                        }
                      });
                    },
                    validator: (val){
                      if(isValid==false){
                        return "Ticket number not found";
                      }else if(isValid==true){
                        return "Ticket Valid";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: '___-___-___',
                      errorStyle: TextStyle(
                        color: isValid==true?Colors.green:Colors.red
                      ),
                      errorBorder:  const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red,width: 1)
                      ),
                      suffixIcon: Icon(isValid?Icons.check:Icons.info_outlined,color: isValid==true?Colors.green:Colors.red),
                      focusedErrorBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: isValid==true?Colors.green:Colors.red,width: 1)
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder:  const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red
                        )
                      )
                    ),
                  ),
                ),
                // ticket
                (isValid==true)?Row(
                  children: [
                    const SizedBox(height: 20,),
                    Center(child: Image.asset("assets/icons/ticket.png",height: 20,width: 20,)),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                           SizedBox(height: 10,),
                           Text("1255-1255-5466",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                           SizedBox(height: 5,),
                           Text("Darell Steward",style: TextStyle(color: Colors.grey),),
                        ],
                      ),
                    )
                  ],
                ):const Text('')
              ],
            ),
        ),
        );
  }
}
