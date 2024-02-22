import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/di/service_locator.dart';

void showSnackbar(String message, {bool isError = false, BuildContext? context}) async{
  final ctx =context ??  getIt<NavigationService>().appContext;
  if (ctx == null) return;
 Flushbar(
    message: message,
    backgroundColor: isError ? Colors.red[700]! : AppColors.primaryColorLight,
    titleColor: Colors.white,
    duration: const Duration(milliseconds: 3000),
  ).show(ctx);
}

void showSnackbarEvent(String message, {String? title,Widget? icon,bool isError = false, BuildContext? context}) async{
  final ctx =context ??  getIt<NavigationService>().appContext;
  if (ctx == null) return;
  Flushbar flushbar = Flushbar(
    message: message,
    title: title,
    icon: icon,
    backgroundColor: isError ? Colors.red[700]! : AppColors.mansourDarkGreenColor3,
    titleColor: Colors.white,
    onTap: (flushbar) {
      flushbar.dismiss();
    },
    // mainButton: IconButton(icon: Icon(Icons.clear,color: AppColors.white,),onPressed: (){
    //   close();
    // },),
    duration: const Duration(seconds: 30),
  );
  flushbar.show(ctx);


}

class MyFlushbar{

  static String? message;
  static String? title;
  static Widget? icon;
  static bool isError = false;
  static BuildContext? context;

  static Flushbar? flushbar ;
  static show(){
    flushbar = Flushbar(
      message: message,
      title: title,
      icon: icon,
      backgroundColor: isError ? Colors.red[700]! : AppColors.mansourDarkGreenColor3,
      titleColor: Colors.white,
      onTap: (flushbar) {
        flushbar.dismiss();
      },
      mainButton: IconButton(icon: Icon(Icons.clear,color: AppColors.white,),onPressed: (){
        close();
      },),
      duration: const Duration(seconds: 30),
    );
    flushbar!.show(context!);
  }
  static close(){
    if(flushbar != null)
    if(flushbar!.isShowing()){
      flushbar!.dismiss();
    }
  }
}