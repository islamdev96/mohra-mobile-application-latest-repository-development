
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/extensions/text_style_extension.dart';
import 'package:starter_application/core/common/style/dimens.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/dialogs/show_dialog.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/features/health/presentation/widget/profile/circled_profile_pic.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/app_main_screen_notifier.dart';
import 'package:starter_application/features/user/presentation/screen/view_profile_screen.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../main.dart';
class AppDrawer extends StatefulWidget {
  AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  late AppMainScreenNotifier sn;
  @override
  void initState() {
    // sn = Provider.of<AppMainScreenNotifier>(context, listen: false);
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      sn = Provider.of<AppMainScreenNotifier>(context, listen: false);

    });
  }
  @override
  Widget build(BuildContext context) {
    sn = Provider.of<AppMainScreenNotifier>(
      context,
    );
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
                   Center(
                    child: GestureDetector(
                      onTap: (){
                        // Nav.to(ViewProfileScreen.routeName).then((value) => sn.notifyListeners());
                      },
                      child: ProfilePic(
                        width: 150.h,
                        height: 150.h,
                        imageUrl: UserSessionDataModel.imageUrl,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                   Padding(
                     padding: EdgeInsets.symmetric(
                       horizontal: 50.w,
                     ),
                     child: Center(child: Text(UserSessionDataModel.fullName ??"",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                   ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.all(4),
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
                               Text(UserSessionDataModel.name??"",style: TextStyle(color: Color(0xFFCC471A)),
                        ),
                            ],
                          ),
                      ),
                      ),

                    ],
                  ),
                  const SizedBox(height: 10,),
                  // const Text("E-Z Event Organiser Company",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                  // const SizedBox(height: 10,),

                   Padding(
                     padding: EdgeInsets.symmetric(
                       horizontal: 50.w,
                     ),
                     child: Text(UserSessionDataModel.emailAddress??"",style: TextStyle(color: Colors.grey,fontSize: 12),),
                   ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 50.w,
                    ),
                    child: CustomListTile(
                      onTap: (){},
                      leading: const Icon(
                        Icons.language,
                        color: AppColors.primaryColorLight,
                        size: 25,

                      ),
                      title: Row(
                        children: [
                          FlutterSwitch(
                            height: 35,
                            width: 70,
                            activeColor: AppColors.primaryColorLight,
                            activeIcon: AppConfig().appLanguage == AppConstants.LANG_EN
                                ? const Text('En')
                                : const Text('Ar'),
                            inactiveIcon: AppConfig().appLanguage == AppConstants.LANG_EN
                                ? const Text('Ar')
                                : const Text('En'),
                            showOnOff: false,
                            value: true,
                            onToggle: (val) => sn.changeLang(contextEvent: context),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 50.w,
                    ),
                    child: _buildDrawerItem(
                      AppConstants.SVG_LOG_OUT_1,
                      Translation.current.logOut,
                      onTap: () async {
                        isArabic = true;
                        sn.showLogoutDialog(contextEvent: context);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 20 ,
                      right: 50.w,
                      left: 50.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'App Version',
                          style: TextStyle(
                              color: AppColors.text_gray,
                              fontSize: 50.sp
                          ),
                        ),
                        Text(
                          '${AppConfig().currentVersion}',
                          style: TextStyle(
                              color: AppColors.text_gray,
                              fontSize: 50.sp
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
          ),
      ),
    );
  }

  Widget _buildDrawerItem(String icon, String title, {VoidCallback? onTap}) {
    return Column(
      children: [
        CustomListTile(
          onTap: onTap,
          leading: SvgPicture.asset(
            icon,
            color: AppColors.primaryColorLight,
            width: 25,
            height: 25,
          ),
          title: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 40.sp,
            ),
          ),
        ),
        Gaps.vGap64,
      ],
    );
  }
}
