import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/home/presentation/screen/app_main_screen.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/all_count_down_screen_notifier.dart';
import 'all_count_down_screen_content.dart';



class AllCountDownScreen extends StatefulWidget {
  static const String routeName = "/AllCountDownScreen";

  const AllCountDownScreen({Key? key}) : super(key: key);

  @override
  _AllCountDownScreenState createState() => _AllCountDownScreenState();
}

class _AllCountDownScreenState extends State<AllCountDownScreen> {
  final sn = AllCountDownScreenNotifier();

  @override
  void initState() {
    sn.getAllTimeTable();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
       return ChangeNotifierProvider<AllCountDownScreenNotifier>.value(
        value: sn,
        child: WillPopScope(
          onWillPop: (){
            // Nav.toAndRemoveAll(AppMainScreen.routeName);
            // return Future.value(false);
            Nav.pop();
            return Future.value(false);
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.mansourLightGreyColor_6,
              elevation: 0.0,
              title: Text(Translation.current.countdown,style: const TextStyle(color:AppColors.black,fontSize: 20.0,),),
              leadingWidth: 66,
              leading: InkWell(
                  onTap: () {
                    Nav.pop();
                  },
                  child:  Icon(
                    AppConstants.getIconBack(),
                    color: Colors.black,
                  )),
              actions: [
                InkWell(
                  onTap: (){},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 70.h,
                      width: 70.h,
                      child: SvgPicture.asset(AppConstants.MENU_ICON),
                    ),
                  ),
                )
              ],
            ),
            backgroundColor: AppColors.mansourLightGreyColor_18,
            // extendBody: false,
            body: AllCountDownScreenContent(),
      ),
        ),
      );
    }


}
  

 


