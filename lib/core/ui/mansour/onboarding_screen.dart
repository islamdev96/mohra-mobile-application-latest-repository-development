import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/features/account/presentation/screen/login_screen.dart';
import 'package:starter_application/features/account/presentation/screen/register_screen1.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../di/service_locator.dart';
import '../../../features/home/presentation/screen/app_main_screen.dart';
import '../../../features/home/presentation/state_m/provider/app_main_screen_notifier.dart';
import '../../../main.dart';
import '../../navigation/navigation_service.dart';

class OnBoardingScreen extends StatefulWidget {
  static const routeName = "/OnBoardingScreen";

  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final double indecatorHeight = 100.h;
  late final double fullHeight;
  late final double bottomHeight;
  late final double topHeight;
  int _currentPage = 0;
  final PageController controller = PageController();

  late List<Widget> introPages;

  setPages() {
    introPages = [
      _buildPage(
        image: AppConstants.IMG_SHOPPING_INTRO,
        content: isArabic
            ? "تسوق كل ما تحتاجه من مختلف المنتجات والخدمات"
            : "Buy all you need from various products and services",
        title: isArabic ? "التسوق" : "Shopping",
        footerText: isArabic
            ? "تسوق كل ما تحتاجه من مختلف المنتجات والخدمات"
            : "Buy all you need from various products and services",
      ),
      _buildPage(
        image: AppConstants.IMG_HEALTH_INTRO,
        content: isArabic
            ? "تابع جداولك الغذائية والتدريبات لتنعم بصحة افضل ولتصل الى اهدافك بشكل اسرع"
            : "Follow your food and exercise schedules to enjoy better health and reach your goals faster",
        title: isArabic ? "الصحة" : "Health",
        footerText: isArabic
            ? "تابع جداولك الغذائية والتدريبات لتنعم بصحة افضل ولتصل الى اهدافك بشكل اسرع"
            : "Follow your food and exercise schedules to enjoy better health and reach your goals faster",
      ),
      _buildPage(
          image: AppConstants.IMG_FINANCE_INTRO,
          content: isArabic
              ? "جميع امورك المالية تحت سقف واحد لتخطط وتوفر"
              : "All your financial matters under one roof to plan and save",
          title: isArabic ? "المالية" : "Finance",
          footerText: isArabic
              ? "جميع امورك المالية تحت سقف واحد لتخطط وتوفر"
              : "All your financial matters under one roof to plan and save"),
      _buildPage(
        image: AppConstants.IMG_ALL_IN_ONE_APP_INTRO,
        content:
            isArabic ? "كل هذا في تطبيق واحد" : "All that in one application",
        title:
            isArabic ? "كل هذا في تطبيق واحد" : "All that in one application",
        footerText:
            isArabic ? "كل هذا في تطبيق واحد" : "All that in one application",
      ),
    ];
  }

  @override
  void initState() {
    fullHeight = 1.sh - indecatorHeight;
    topHeight = 0.65 * fullHeight;
    bottomHeight = fullHeight - topHeight;
    setPages();
    // controller.addListener(() {
    //   setState(() {
    //     _currentPage = controller.page!;
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
              controller: controller,
              itemCount: introPages.length,
              onPageChanged: (value) {
                setState(() {
                  _currentPage = value!;
                });
              },
              itemBuilder: (context, index) {
                return introPages[index];
              }),
          Positioned(
            top: topHeight + 0.25 * indecatorHeight,
            left: 0,
            right: 0,
            child: DotsIndicator(
              dotsCount: introPages.length,
              position: int.tryParse(_currentPage.toString()) ?? 0,
              decorator: DotsDecorator(
                activeColor: AppColors.primaryColorLight,
                color: AppColors.primaryColorLight.withOpacity(
                  0.2,
                ),
                size: Size(20.h, 20.h),
                activeSize: Size(20.h, 20.h),
              ),
            ),
          ),
          Positioned(
              top: 50,
              left: 10,
              right: 10,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isArabic = false;
                        setPages();
                      });
                    },
                    child: Text(
                      "English",
                      style: TextStyle(
                        color: AppColors.mansourBackArrowColor2,
                        fontSize: 45.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    " | ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 45.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isArabic = true;
                        setPages();
                      });
                    },
                    child: Text(
                      "عربي",
                      style: TextStyle(
                        color: AppColors.mansourBackArrowColor2,
                        fontSize: 45.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Widget _buildPage({
    required String image,
    required String title,
    required String content,
    String? footerText,
  }) {
    return Column(
      children: [
        Container(
          height: topHeight,
          width: 1.sw,
          child: Column(
            children: [
              SizedBox(
                height: 0.3 * topHeight,
              ),
              SizedBox(
                width: 0.7.sw,
                height: 0.4 * topHeight,
                child: Image.asset(image),
              ),
              SizedBox(
                height: 0.05 * topHeight,
              ),
              const Spacer(),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 50.sp,
                ),
              ),
              SizedBox(
                height: 0.01 * topHeight,
              ),
            ],
          ),
        ),
        Container(
          height: indecatorHeight,
        ),
        Expanded(
          child: SizedBox(
            width: 0.9.sw,
            child: Text(
              footerText ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontSize: 35.sp,
              ),
              maxLines: 3,
            ),
          ),
        ),
        CustomMansourButton(
          width: 0.9.sw,
          title: Text(
            isArabic ? "تسجيل حساب" : "Register",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 40.sp,
            ),
          ),
          onPressed: () {
            Nav.to(RegisterScreen1.routeName);
          },
        ),
        CustomMansourButton(
          width: 0.9.sw,
          title: Text(
            isArabic ? "تسجيل الدخول" : "Login",
            style: TextStyle(
              color: AppColors.primaryColorLight,
              fontWeight: FontWeight.bold,
              fontSize: 40.sp,
            ),
          ),
          onPressed: () {
            Nav.to(LoginScreen.routeName);
          },
          backgroundColor: Colors.white,
        ),
        CustomMansourButton(
          width: 0.9.sw,
          title: Text(
            isArabic ? "زائر" : "Guest",
            style: TextStyle(
              color: AppColors.primaryColorLight,
              fontWeight: FontWeight.bold,
              fontSize: 40.sp,
            ),
          ),
          onPressed: () {
            Nav.to(AppMainScreen.routeName);
          },
          backgroundColor: Colors.white,
        ),
        SizedBox(
          height: 0.1 * bottomHeight,
        ),
      ],
    );
  }
}
