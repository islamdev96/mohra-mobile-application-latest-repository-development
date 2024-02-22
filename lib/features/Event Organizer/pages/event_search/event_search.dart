
import 'package:flutter/material.dart';

import '../../data/models/related_event_model.dart';
import '../../data/models/search_model.dart';
class EventSearch extends StatefulWidget {

  EventSearch({Key? key}) : super(key: key);

  @override
  State<EventSearch> createState() => _EventSearchState();
}

class _EventSearchState extends State<EventSearch> {
  static List<SearchModel> searchList = [
    SearchModel(avatar: "assets/images/search1.png",
        title: "Music Challenge Events",
        subTile: "Riyadh, 5 Nov - 01 Dec 2022"),
    SearchModel(avatar: "assets/images/search2.png",
        title: "Music Challenge EEvent",
        subTile: "Riyadh, 5 Nov - 01 Dec 2022"),
    SearchModel(avatar: "assets/images/search3.png",
        title: "Aniversary Music Event",
        subTile: "Riyadh, 5 Nov - 01 Dec 2022"),
    SearchModel(avatar: "assets/images/search4.png",
        title: "Aniversary Music Event",
        subTile: "Riyadh, 5 Nov - 01 Dec 2022"),
    SearchModel(avatar: "assets/images/search1.png",
        title: "dall",
        subTile: "Riyadh, 5 Nov - 01 Dec 2022"),
    SearchModel(avatar: "assets/images/search1.png",
        title: "Arslan event",
        subTile: "Riyadh, 5 Nov - 01 Dec 2022"),
  ];

  static List<RelatedEvents> relatedList = [
    RelatedEvents(avatar: "assets/images/search1.png",
        title: "Related 1 Music Challenge",
        subTile: "Riyadh, 5 Nov - 01 Dec 2022"),
    RelatedEvents(avatar: "assets/images/search2.png",
        title: "Related 2 Music Challenge",
        subTile: "Riyadh, 5 Nov - 01 Dec 2022"),
    RelatedEvents(avatar: "assets/images/search3.png",
        title: "Related 3 Aniversary Music",
        subTile: "Riyadh, 5 Nov - 01 Dec 2022"),
    RelatedEvents(avatar: "assets/images/search4.png",
        title: "Related 4 Aniversary",
        subTile: "Riyadh, 5 Nov - 01 Dec 2022"),
    RelatedEvents(avatar: "assets/images/search1.png",
        title: "dall",
        subTile: "Related 5 Riyadh, 5 Nov - 01 Dec 2022"),
    RelatedEvents(avatar: "assets/images/search1.png",
        title: "Arslan event",
        subTile: "Riyadh, 5 Nov - 01 Dec 2022"),
  ];

  SearchModel? event;
  RelatedEvents? eventRelated;

  final _form = GlobalKey<FormState>();

  late bool load;

  List<SearchModel> newList = List.from(searchList);
  List<RelatedEvents> relatedNewList = List.from(relatedList);
  late int listLength = 0;
  @override
  void initState() {
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
      body: load==true?SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text("All Event ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: newList.length,
              itemBuilder: (context, index) {
                event = newList[index];
                listLength = newList.length;
                return Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      height: 60,
                      width: 60,
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
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("View All ($listLength)",style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 15),),
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text("Related Event",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
            ),
            const SizedBox(height: 10,),
            (event!=null)?ListView.builder(
              shrinkWrap: true,
              itemCount: relatedList.length,
              itemBuilder: (context, index) {
                eventRelated = relatedNewList[index];
                return Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: AssetImage(relatedNewList[index].avatar!))
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(relatedNewList[index].title!,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                          const SizedBox(height: 10,),
                          Text(relatedNewList[index].subTile!)
                        ]
                    )
                  ],
                );
              },
            ):const Center(
              child: Text("No Data"),
            ),
          ],
        ),
      ):const Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}
