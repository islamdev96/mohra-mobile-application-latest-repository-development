
import 'package:flutter/material.dart';

import '../../data/models/search_ticket.dart';
class TicketSearch extends StatefulWidget {

  TicketSearch({Key? key}) : super(key: key);

  @override
  State<TicketSearch> createState() => _EventSearchState();
}

class _EventSearchState extends State<TicketSearch> {
  static List<TicketModel> searchList = [
    TicketModel(avatar: "assets/icons/ticket.png",
        title: "122535665",
        subTile: "Eleanor Pena"),
    TicketModel(avatar: "assets/icons/ticket.png",
        title: "612535665",
        subTile: "Arlene McCoy"),
    TicketModel(avatar: "assets/icons/ticket.png",
        title: "122535665",
        subTile: "Guy Hawkins"),
    TicketModel(avatar: "assets/icons/ticket.png",
        title: "122535665",
        subTile: "Darrell Steward"),
    TicketModel(avatar: "assets/icons/ticket.png",
        title: "7722535665",
        subTile: "Cody Fisher"),
  ];

  TicketModel? event;

  final _form = GlobalKey<FormState>();

  late bool load;

  List<TicketModel> newList = List.from(searchList);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load = false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
            color: Colors.black
        ),
        title: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _form,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "type to search",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (val) {
              setState(() {
                newList = searchList.where((element) => element.title!.toLowerCase().contains(val.toLowerCase())).toList();
                load = true;
                if(val.isEmpty){
                  load = false;
                }
              });
            },
          ),
        ),
      ),
      body: load==true?ListView.builder(
        itemCount: newList.length,
        itemBuilder: (context, index) {
          event = newList[index];
          return Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: AssetImage(newList[index].avatar!))
                ),
              ),
              const SizedBox(width: 10,),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(newList[index].title!,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    const SizedBox(height: 10,),
                    Text(newList[index].subTile!)
                  ]
              )
            ],
          );
        },
      ):const Center(child: CircularProgressIndicator.adaptive()),
    );
  }

/*ListTile(
  title: Text(event!.title!),
  subtitle: Text(event!.subTile!),
  trailing: Text('${event!.subTile} yo'),
  )*/
}
