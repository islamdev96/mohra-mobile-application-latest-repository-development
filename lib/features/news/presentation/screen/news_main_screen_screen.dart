import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/app_main_screen_notifier.dart';
import 'package:starter_application/features/news/presentation/screen/favorite_news_screen.dart';
import 'package:starter_application/features/news/presentation/screen/news_search_screen.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/news_main_screen_screen_notifier.dart';
import 'news_home_screen.dart';

class NewsMainScreen extends StatefulWidget {
  static const String routeName = "/NewsMainScreenScreen";

  const NewsMainScreen({Key? key}) : super(key: key);

  @override
  _NewsMainScreenState createState() => _NewsMainScreenState();
}

class _NewsMainScreenState extends State<NewsMainScreen> {
  late NewsMainScreenScreenNotifier sn;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<NewsMainScreenScreenNotifier>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: PageView(
          controller: sn.controller,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const NewsHomeScreen(),
            const NewsSearchScreen(),
            const FavoriteNewsScreen(),
          ],
          onPageChanged: (page) {
            sn.selectedIndex = page;
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
      ),
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
      onTap: (value) {
        sn.onBottomNavigationTap(value);
      },
      unselectedLabelStyle: TextStyle(
        color: Colors.black,
        fontSize: 35.sp,
      ),
      currentIndex: sn.selectedIndex,
      selectedItemColor: AppColors.primaryColorLight,
      unselectedItemColor: Colors.black,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      // onTap: sn.onBottomNavigationTap,
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
      AppMainScreenNotifier.NAV_ICON: AppConstants.SVG_HOME_FILL,
      AppMainScreenNotifier.NAV_TITLE: Translation.current.home,
    },
    {
      AppMainScreenNotifier.NAV_ICON: AppConstants.SVG_SEAECH,
      AppMainScreenNotifier.NAV_TITLE: Translation.current.search,
    },
    {
      AppMainScreenNotifier.NAV_ICON: AppConstants.SVG_BOOK_MARK,
      AppMainScreenNotifier.NAV_TITLE: Translation.current.favorite,
    },
  ];
}
