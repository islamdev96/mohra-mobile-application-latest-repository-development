
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        flexibleSpace: SafeArea(
          child:  Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('Events',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/search_icon.png",height: 40,width: 40,),
                    const SizedBox(width: 10,),
                    Image.asset("assets/icons/side_bar_icon.png",height: 40,width: 40,)
                  ],
                )
              ],
            ),
          ),
        ),
    );
  }
}
