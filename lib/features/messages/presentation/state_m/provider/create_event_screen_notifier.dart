import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/features/messages/presentation/screen/create_event_2_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/event_intro_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/single_message_screen.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';
import 'messages_screen_notifie.dart';

class CreateEventScreenNotifier extends ScreenNotifier {
  /// Variables
  final FocusNode groupDetailsFocusNode = FocusNode();

  // Key
  final groupDetailsKey = new GlobalKey<FormFieldState<String>>();

  // Controller
  final groupDetailsController = TextEditingController();

  /// Fields
  late BuildContext context;
  List<Message> messages = [
    Message(
        id: 1,
        image: "assets/images/png/temp/person1.jpeg",
        date: "3:23 AM",
        name: "Helena Palmer",
        message: "Hi, are you ok ? ",
        isRead: true,
        numNotRead: "5",
        isSelected: false),
    Message(
        id: 2,
        image: "assets/images/png/temp/person3.jpg",
        date: "5:13 AM",
        name: "Alice Osborne",
        message: "Believing Is The Absence Of Doubt",
        isRead: true,
        isSelected: false,
        numNotRead: "3"),
    Message(
        id: 3,
        image: "assets/images/png/temp/person4.jpg",
        date: "04/11/2020",
        name: "Jeff Griffith",
        message: "Success Steps For Your Personal Or Business Life",
        isRead: true,
        isSelected: false,
        numNotRead: "2"),
    Message(
        id: 4,
        image: "assets/images/png/temp/person5.jpg",
        date: "04/07/2020",
        name: "Jordan Blair",
        message: "Survival",
        isRead: true,
        isSelected: false,
        numNotRead: "2"),
    Message(
        id: 5,
        image: "assets/images/png/temp/person6.jpg",
        date: "04/02/2020",
        name: "Mittie Page",
        message: "Motivation S Effect On Mental And Physical..",
        isRead: true,
        isSelected: false,
        numNotRead: "2"),
    Message(
        id: 6,
        image: "assets/images/png/temp/person7.jpg",
        date: "04/02/2020",
        name: "Work Group",
        message: "Music For Self Improvement",
        isRead: true,
        isSelected: false,
        numNotRead: "2"),
    Message(
        id: 7,
        image: "assets/images/png/temp/person8.jpg",
        date: "04/02/2020",
        name: "Augusta Swanson",
        message: "Motivation How To Build Trust At Work ",
        isRead: true,
        isSelected: false,
        numNotRead: "2")
  ];

  /// Getters and Setters

  /// Methods
  void navEventScreen2() {
    Nav.to(EventScreen2.routeName);
  }

  void onCreateCustom(
      context, String image, String title, String desc, bool isDone) {
    Alert(
            closeIcon: const SizedBox(),
            context: context,
            style: AlertStyle(
                descStyle: TextStyle(fontSize: 40.sp, color: Colors.grey[400]),
                titleStyle: TextStyle(fontSize: 50.sp)),
            buttons: [],
            content: isDone
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Send To :",
                            style: TextStyle(
                                fontSize: 40.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Gaps.vGap32,
                      Row(
                        children: [
                          ClipOval(
                            child: Container(
                              height: 120.r * 0.9,
                              width: 120.r * 0.9,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                "assets/images/png/temp/friendR3.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Gaps.hGap16,
                          Text(
                            "Helena Palmer",
                            style: TextStyle(
                                fontSize: 40.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Gaps.vGap24,
                      Container(
                        width: 1.sw,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              30.r,
                            ),
                            color: AppColors.mansourLightGreyColor_4),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.w, vertical: 40.h),
                          child: Row(
                            children: [
                              Text(
                                "[EVENT]",
                                style: TextStyle(
                                    color: AppColors.primaryColorLight,
                                    fontSize: 40.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Gaps.hGap8,
                              Text(
                                "Mt Fuji Hiking",
                                style: TextStyle(
                                    color: AppColors.black_text,
                                    fontSize: 40.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gaps.vGap64,
                      CustomMansourButton(
                        borderRadius: Radius.circular(20.r),
                        height: 90.h,
                        backgroundColor: AppColors.primaryColorLight,
                        titleText: "Send to Chat",
                        padding: EdgeInsets.symmetric(horizontal: 50.w),
                        titleStyle:
                            TextStyle(fontSize: 40.sp, color: AppColors.white),
                        onPressed: () {
                          Nav.off(SingleMessageScreen.routeName);
                        },
                      ),
                      CustomMansourButton(
                        borderRadius: Radius.circular(20.r),
                        height: 90.h,
                        backgroundColor: AppColors.white,
                        titleText: "Cancel",
                        padding: EdgeInsets.symmetric(horizontal: 50.w),
                        titleStyle: TextStyle(
                            fontSize: 40.sp,
                            color: AppColors.primaryColorLight),
                        onPressed: () {
                          Nav.pop();
                        },
                      ),
                    ],
                  )
                : const SizedBox())
        .show();
  }

  @override
  void closeNotifier() {
    this.dispose();
  }
}
