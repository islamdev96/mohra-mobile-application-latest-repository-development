import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventCard extends StatelessWidget {
  final String eventType,minute,player;

  EventCard({
   required this.eventType,
   required this.minute,
   required this.player,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.9.sw,
      padding: EdgeInsets.symmetric(horizontal: 0.03.sw, vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width:0.8.sw/3,
            child: Text(
              eventType ,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600]),
            ),
          ),
          Container(
            width:0.8.sw/3,
            child: Text(
              player,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600]),
            ),
          ),
          Container(
            width:0.8.sw/3,
            child: Text(
              minute,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }
}
