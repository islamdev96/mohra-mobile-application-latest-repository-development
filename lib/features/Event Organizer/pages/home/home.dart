//
// import 'package:flutter/material.dart';
//
// import '../../widgets/home_widgets/event_and_settings_widget.dart';
// import '../../widgets/home_widgets/home_body.dart';
// import '../../widgets/home_widgets/side_bar.dart';
// import '../event_search/event_search.dart';
//
// class EventOrganizerHome extends StatefulWidget {
//   static const routeName = "/EventOrganizerHome";
//
//   const EventOrganizerHome({Key? key}) : super(key: key);
//
//   @override
//   State<EventOrganizerHome> createState() => _EventOrganizerHomeState();
// }
//
// class _EventOrganizerHomeState extends State<EventOrganizerHome> {
//   var scaffoldKey = GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       drawer: AppDrawer(),
//         // app bar
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           automaticallyImplyLeading: false,
//           toolbarHeight: 80,
//           flexibleSpace: SafeArea(
//             child:  Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   const Text('Events',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black),),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       InkWell(
//                         onTap: (){
//                           Navigator.of(context).push(
//                               MaterialPageRoute(builder: (context) => EventSearch())
//                           );
//                         },
//                           child: Image.asset("assets/icons/search_icon.png",height: 25,width: 25,)),
//                       const SizedBox(width: 10,),
//                       InkWell(
//                         onTap: ()=> scaffoldKey.currentState!.openDrawer(),
//                           child: Image.asset("assets/icons/side_bar_icon.png",height: 25,width: 25,))
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//         // body
//         body: SingleChildScrollView(
//           child: Column(
//             children:  [
//               EventAndSettingsWidgets(),
//               HomeBody(),
//               SizedBox(height: 20,)
//             ],
//           ),
//         ),
//     );
//   }
// }
