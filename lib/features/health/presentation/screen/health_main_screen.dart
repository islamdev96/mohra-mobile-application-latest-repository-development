import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/health/presentation/screen/exrecise_screen.dart';
import 'package:starter_application/features/health/presentation/screen/food_screen.dart';
import 'package:starter_application/features/health/presentation/screen/health_home_screen.dart';
import 'package:starter_application/features/health/presentation/screen/health_profile_screen.dart';
import 'package:starter_application/features/health/presentation/state_m/provider/health_main_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

class HealthMainScreen extends StatefulWidget {
  static const routeName = "/HealthMainScreen";

  final BottomNavBarInitIndex initIndex;

  const HealthMainScreen({Key? key, required this.initIndex}) : super(key: key);

  @override
  _HealthMainScreenState createState() => _HealthMainScreenState();
}

class _HealthMainScreenState extends State<HealthMainScreen> {
  late HealthMainScreenNotifier sn = HealthMainScreenNotifier();
  late List<Widget> healthWheelPickerItems = [];

  @override
  void initState() {
    healthWheelPickerItems = [
      _buildWheelItem(
        title: Translation.current.dinner,
        icon: AppConstants.SVG_DINNER2,
        onTap: sn.onAddDinnertTap,
      ),
      _buildWheelItem(
        title: Translation.current.snack,
        icon: AppConstants.SVG_SNACKS,
        onTap: sn.onAddSnackTap,
      ),
      _buildWheelItem(
        title: Translation.current.exercise,
        icon: AppConstants.SVG_DUMBBELL3,
        onTap: sn.onAddExrciseTap,
      ),
      _buildWheelItem(
        title: Translation.current.breakfast,
        icon: AppConstants.SVG_BREAKFAST,
        onTap: sn.onAddBreakfastTap,
      ),
      _buildWheelItem(
        title: Translation.current.lunch,
        icon: AppConstants.SVG_LUNCH,
        onTap: sn.onAddLunchTap,
      ),
    ];
    sn.initIndex(widget.initIndex.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('rest');
    print(sn.controller.initialPage);
    print(sn.selectedIndex);
    print(widget.initIndex.index);
    sn.initController(widget.initIndex.index);

    return ChangeNotifierProvider.value(
        value: sn,
        builder: (context, __) {
          context.watch<HealthMainScreenNotifier>();
          return Scaffold(
            body: PageView(
              controller: sn.controller,
              children: [
                SizedBox.expand(
                  child: GestureDetector(
                    onPanUpdate: (details) {},
                    onHorizontalDragUpdate: (details) {
                      int sensitivity = 8;
                      if (details.delta.dx > sensitivity) {
                        Nav.pop();
                      } else if (details.delta.dx < -sensitivity) {
                        sn.onBottomNavigationTap(
                          1,
                          items: healthWheelPickerItems,
                          itemRadius: 200.r,
                          centerRadius: 300.r,
                        );
                      }
                    },
                    child: HealthHomeScreen(),
                  ),
                ),
                const ExreciseScreen(),
                const FoodScreen(),
                const HealthProfileScreen(),
              ],
              onPageChanged: (page) {
                sn.selectedIndex = page;
              },
            ),
            bottomNavigationBar: Builder(
              builder: (context) {
                sn.context = context;
                return Container(
                  height: AppConstants.bottomNavigationBarHeight,
                  color: Colors.white,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.r),
                      topRight: Radius.circular(40.r),
                    ),
                    child: _buildBottomNavigationbar(),
                  ),
                );
              },
            ),
            extendBody: true,
          );
        });
  }

  Widget _buildBottomNavigationbar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      items: sn.navItems.map((e) => _buildBottomNavigationBarItem(e)).toList(),
      selectedLabelStyle: TextStyle(
        color: AppColors.mansourDarkGreenColor,
        fontSize: 0.sp,
      ),
      unselectedLabelStyle: TextStyle(
        color: AppColors.accentColorLight,
        fontSize: 0.sp,
      ),
      currentIndex: sn.selectedIndex,
      selectedItemColor: AppColors.mansourDarkGreenColor,
      unselectedItemColor: AppColors.accentColorLight,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        sn.onBottomNavigationTap(
          index,
          items: healthWheelPickerItems,
          itemRadius: 150.r,
          centerRadius: 300.r,
        );
      },
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      Map<int, dynamic> item) {
    int index = sn.navItems.indexOf(item);
    return BottomNavigationBarItem(
      icon: index != 2
          ? SvgPicture.asset(
              item[HealthMainScreenNotifier.NAV_ICON],
              color: sn.selectedIndex == index
                  ? AppColors.mansourDarkGreenColor
                  : AppColors.accentColorLight,
            )
          : Container(
              padding: EdgeInsets.all(
                40.h,
              ),
              decoration: const BoxDecoration(
                color: AppColors.mansourDarkGreenColor,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                item[HealthMainScreenNotifier.NAV_ICON],
                color: Colors.white,
                height: 80.sp,
              ),
            ),
      label: item[HealthMainScreenNotifier.NAV_TITLE],
    );
  }

  Widget _buildWheelItem({
    required String title,
    required String icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      // hoverColor: Colors.transparent,
      // splashColor: Colors.transparent,
      // focusColor: Colors.transparent,
      // highlightColor: Colors.transparent,
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: LayoutBuilder(builder: (context, cons) {
                return Center(
                  child: SizedBox(
                    height: 0.6 * cons.maxHeight,
                    width: 0.6 * cons.maxHeight,
                    child: SvgPicture.asset(
                      icon,
                    ),
                  ),
                );
              }),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 2,
            child: FittedBox(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
