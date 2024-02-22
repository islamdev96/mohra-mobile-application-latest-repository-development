
import 'package:flutter/material.dart';
class AppDrawer extends StatelessWidget {
  AppDrawer({Key? key}) : super(key: key);

  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: scaffoldKey,
      child: Container(
        padding: const EdgeInsetsDirectional.only(top: 20.0),
        margin:  const EdgeInsetsDirectional.only(top: 10.0),
        color: Colors.white,
        constraints: const BoxConstraints(maxHeight: 250.0, minHeight: 90.0),
        child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset("assets/icons/cancel.png",width: 24,height: 24,)
                        ],
                      ),
                    ),
                  ),
                  const Center(
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage("assets/images/avatar.png"),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  const Center(child: Text("Zahir Mays",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color:const Color(0xFFFFDED3)
                        ),
                        child:   Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/icons/user.png',height: 20,width: 20,),
                              const SizedBox(width: 10,),
                              const Text("Event Staff",style: TextStyle(color: Color(0xFFCC471A)),
                        ),
                            ],
                          ),
                      ),
                      ),

                    ],
                  ),
                  const Text("E-Z Event Organiser Company",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  const Text("zahir@mail.com",style: TextStyle(color: Colors.grey),),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Image.asset("assets/icons/logout.png",height: 20,width: 20,),
                            ),
                            const SizedBox(width: 20,),
                            const Text("Logout"),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                             Text("Apps Version: 1.3"),
                          ],
                        )
                      ],
                    ),
                  )
                ],
          ),
      ),
    );
  }
}
