import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/app_main_screen_notifier.dart';
import 'package:starter_application/features/sports/presentation/screen/schedule_screen.dart';
import 'package:starter_application/features/sports/presentation/screen/table_screen.dart';
import 'package:starter_application/features/sports/presentation/state_m/provider/sport_main_screen_notifier.dart';
import 'package:starter_application/features/sports/presentation/widget/coming_soon.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../core/navigation/nav.dart';
import 'home/sport_home_screen.dart';

class SportMainScreen extends StatefulWidget {
  static const routeName = "/SportMainScreen";

  SportMainScreen({Key? key}) : super(key: key);

  @override
  _SportMainScreenState createState() => _SportMainScreenState();
}

class _SportMainScreenState extends State<SportMainScreen> {
  late SportMainScreenNotifier sn;
  static const NAV_ICON = 0;
  static const NAV_TITLE = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<SportMainScreenNotifier>(context);

    return Scaffold(
      body: PageView(
        controller: sn.controller,
        children: [
          const SportHomeScreen(),
          const SportComingSoon(),
          const SportComingSoon(),
          const SportComingSoon(),
        ],
        onPageChanged: (page) {
          if(sn.selectedIndex == 0 && page == 0){
            Nav.pop();
          }else {
            sn.selectedIndex = page;
          }
        },
      ),
      bottomNavigationBar: Builder(builder: (context) {
        sn.context = context;
        return Container(
          height: AppConstants.bottomNavigationBarHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.r),
              topRight: Radius.circular(40.r),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.mansourNotSelectedBorderColor.withOpacity(0.3),
                blurRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.r),
              topRight: Radius.circular(40.r),
            ),
            child: _buildBottomNavigationbar(),
          ),
        );
      }),
      extendBody: true,
    );
  }

  Widget _buildBottomNavigationbar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      items: navItems.map((e) => _buildBottomNavigationBarItem(e)).toList(),
      selectedLabelStyle: TextStyle(
        color: AppColors.primaryColorLight,
        fontSize: 35.sp,
      ),
      unselectedLabelStyle: TextStyle(
        color: Colors.black,
        fontSize: 35.sp,
      ),
      currentIndex: sn.selectedIndex,
      selectedItemColor: AppColors.primaryColorLight,
      unselectedItemColor: Colors.black,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      onTap: sn.onBottomNavigationTap,
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      Map<int, dynamic> item) {
    int index = navItems.indexOf(item);
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        item[AppMainScreenNotifier.NAV_ICON],
        color: sn.selectedIndex == index
            ? AppColors.primaryColorLight
            : Colors.black,
      ),
      label: item[AppMainScreenNotifier.NAV_TITLE],
    );
  }

  List<Map<int, dynamic>> navItems = [
    {
      NAV_ICON: AppConstants.SVG_HOME_FILL,
      NAV_TITLE: Translation.current.home,
    },
    {
      NAV_ICON: AppConstants.SVG_SEARCH,
      NAV_TITLE: Translation.current.search,
    },
    {
      NAV_ICON: AppConstants.SVG_SCHEDULE,
      NAV_TITLE: Translation.current.schedule,
    },
    {
      NAV_ICON: AppConstants.SVG_TABLE_SPORT,
      NAV_TITLE: Translation.current.table,
    },
  ];
}
