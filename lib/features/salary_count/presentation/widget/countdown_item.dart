import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/features/salary_count/domain/entity/time_table_list_entity.dart';
import '../../../../core/common/app_colors.dart';
import '../../../../core/common/date_utils.dart';
import '../../../../generated/l10n.dart';
import 'row_item_widget.dart';

class CountdownItem extends StatefulWidget {

  final TimeTableItemEntity tableItemEntity ;
  final bool isBorder;

  CountdownItem({
    required this.tableItemEntity,
    required this.isBorder,
  });

  @override
  State<CountdownItem> createState() => _CountdownItemState();
}

class _CountdownItemState extends State<CountdownItem>{

  Timer? countdownTimer;
  late Duration myDuration;

  @override
  void initState() {
    super.initState();
    setupTime();
  }

  setupTime()  {
    DateTime tsdate = widget.tableItemEntity.date;
    Duration diff = DateUtility.differenceBetweenTwoDays(tsdate,DateTime.now());
    myDuration = diff;
    setState(() {
      startTimer();
    });

  }
  void startTimer() {
    print(" setupTime run");
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());

  }
// Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }
// Step 5
  void resetTimer(int duration) {
    stopTimer();
    setState(() => myDuration = Duration(days: duration));
  }
// Step 6
  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      }
      else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String days= '' , hours= '',minutes= '',seconds = '';
    String strDigits(int n) => n.toString().padLeft(2, '0');
    if(myDuration.inDays < 0){
      days = '00';
    }else{
      days = strDigits(myDuration.inDays);
    }
    if(myDuration.inHours.remainder(24) < 0){
      hours = '00';
    }else{
      hours = strDigits(myDuration.inHours.remainder(24));
    }
    if(myDuration.inMinutes.remainder(60) < 0){
      minutes = '00';
    }else{
      minutes = strDigits(myDuration.inMinutes.remainder(60));
    }
    if(myDuration.inSeconds.remainder(60) < 0){
      seconds = '00';
    }else{
     seconds = strDigits(myDuration.inSeconds.remainder(60));
    }



    return Container(
      margin: const EdgeInsetsDirectional.only(top: 15.0),
      height: 0.13.sh,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.mansourWhiteBackgrounColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: widget.isBorder  ? AppColors.mansourDarkOrange3 : AppColors.mansourWhiteBackgrounColor.withOpacity(0.2))
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: GestureDetector(
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.more_vert,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RowItemWidget(v1:days,v2:Translation.current.days2,v3: ":",boxColor:AppColors.mansourLightOrangeCountdown,textColor: AppColors.mansourWhiteBackgrounColor),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RowItemWidget(v1:hours,v2:Translation.current.hours2,v3: ":",boxColor:AppColors.mansourLightOrangeCountdown,textColor: AppColors.mansourWhiteBackgrounColor),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RowItemWidget(v1:minutes,v2:Translation.current.minutes2,v3: ":",boxColor:AppColors.mansourLightOrangeCountdown,textColor: AppColors.mansourWhiteBackgrounColor),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RowItemWidget(v1:seconds,v2:Translation.current.seconds,v3: "",boxColor:AppColors.mansourLightOrangeCountdown,textColor: AppColors.mansourWhiteBackgrounColor),
              ),
              Container(
                width: 0.25.sw,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        constraints: const BoxConstraints(minWidth: 10, maxWidth: 100),
                        child: Text(widget.tableItemEntity.title ?? '',style: const TextStyle(color: AppColors.black,fontSize: 12.0,),textAlign: TextAlign.center,)),
                    Text('${widget.tableItemEntity.date.day}-${widget.tableItemEntity.date.month}-${widget.tableItemEntity.date.year}',style: const TextStyle(color: AppColors.black,fontSize: 10.0),)
                  ],),
              )
            ],
          ),
          onTap: (){

          },
        ),
      ),);
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }
}
