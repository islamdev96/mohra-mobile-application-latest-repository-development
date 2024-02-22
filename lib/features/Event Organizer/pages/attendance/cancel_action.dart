import 'package:flutter/material.dart';
import 'package:flutter_radio_group/flutter_radio_group.dart';

import 'cancel_done.dart';
class CancelAction extends StatefulWidget {
   CancelAction({Key? key}) : super(key: key);

  @override
  State<CancelAction> createState() => _CancelActionState();
}


var _listHorizontal = ["Attende asking for it", "Attende medical issue", "Reason #3", "Reason #4", "Reason #5"];
var _indexHorizontal = 0;

class _CancelActionState extends State<CancelAction> {
  late int? selectedValue;

   @override
   void initState() {
     super.initState();
     selectedValue = 1;
   }

   
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cancel',style: TextStyle(color: Colors.black),),
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              const SizedBox(height: 20,),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Please tell us why you want do you want to cancel this",
                  style: TextStyle(
                fontSize: 20,fontWeight: FontWeight.bold
                 ),),
              ),
              // list of group items
              FlutterRadioGroup(
                  titles: _listHorizontal,
                  labelStyle: const TextStyle(color: Colors.white38,fontSize: 20,fontWeight: FontWeight.bold),
                  labelVisible: true,
                  label: "This is label radio",
                  activeColor: Colors.grey,
                  titleStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  defaultSelected: _indexHorizontal,
                  orientation: RGOrientation.VERTICAL,
                  onChanged: (index) {
                    setState(() {
                      _indexHorizontal = index!;
                    });
                  }),
             /* ListTile(
                leading: ElegantRadioButton<int>(
                  groupValue: selectedValue,
                  value: 1,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },

                  fillColor: MaterialStateProperty.all(Colors.grey),
                ),
                title: const Text('Attende asking for it'),
              ),
              ListTile(
                leading: ElegantRadioButton<int>(
                  groupValue: selectedValue,
                  value: 2,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  fillColor: MaterialStateProperty.all(Colors.grey),
                ),
                title: const Text('Attende medical issue'),
              ),
              ListTile(
                leading: ElegantRadioButton<int>(
                  groupValue: selectedValue,
                  value: 3,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  fillColor: MaterialStateProperty.all(Colors.grey),
                ),
                title: const Text('Reason #3'),
              ),
              ListTile(
                leading: ElegantRadioButton<int>(
                  groupValue: selectedValue,
                  value: 4,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  fillColor: MaterialStateProperty.all(Colors.grey),
                ),
                title: const Text('Reason #4'),
              ),
              ListTile(
                leading: ElegantRadioButton<int>(
                  groupValue: selectedValue,
                  value: 5,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },splashRadius: 5.0,
                  fillColor: MaterialStateProperty.all(Colors.grey),
                ),
                title: const Text('Reason #5'),
              ),*/
              const Spacer(),
              InkWell(
                onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const CancelDone())
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  height: 50.0,
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFD92D20),
                  ),
                  child: const Center(
                    child: Text("Confirm Cancellations",style: TextStyle(color: Colors.white),),
                  ),
                ),
              )
        ],
            ));
  }
}
