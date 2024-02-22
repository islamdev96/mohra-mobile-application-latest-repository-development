import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/event/presentation/screen/my_ticket_screen.dart';
import 'package:starter_application/features/event/presentation/widget/event_search_text_field.dart';
import 'package:starter_application/features/home/presentation/screen/home_screen/home_screen.dart';

import 'news_search_text_filed.dart';

class NewsHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  NewsHomeAppBar(
      {Key? key,
      required this.isLeading,
      required this.onPress,
       this.title,
      required this.onClose,
      required this.controller,
      this.isHasLeading = false,
      required this.onSubmitted,
      required this.onSearch})
      : super(key: key);
  final bool isLeading;
  final VoidCallback onPress;
  final VoidCallback onSearch;
  final VoidCallback onClose;
  final TextEditingController controller;
  final Function(String)? onSubmitted;
  final Widget? title;
  bool isHasLeading;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        isHasLeading
            ? AppBar(
                titleSpacing: 0,
                backgroundColor: AppColors.white,
                shadowColor: AppColors.white,
                title: isLeading
                    ? Padding(
                        padding: EdgeInsetsDirectional.only(end: 50.w),
                        child: NewsSearchTextField(
                          controller: controller,
                          onSearch: onSearch,
                          onSubmitted: onSubmitted,
                        ),
                      )
                    : title,
                centerTitle: true,
                leading: InkWell(
                  onTap: () {

                    onClose();
                  },
                  child: Icon(
                    AppConstants.getIconBack(),
                    color: Colors.black,
                    size: 80.sp,
                  ),
                ),
                actions: [
                  isLeading
                      ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                        onTap: onPress,
                        child: Icon(
                          Icons.cancel_sharp,
                          color: Colors.black,
                          size: 80.sp,
                        )),
                      )
                      : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                        onTap: onPress,
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 80.sp,
                        )),
                      ),

                ],
              )
            : AppBar(
                titleSpacing: 0,
                backgroundColor: AppColors.white,
                shadowColor: AppColors.white,
                title: isLeading
                    ? Padding(
                        padding: EdgeInsetsDirectional.only(end: 50.w),
                        child: NewsSearchTextField(
                          controller: controller,
                          onSearch: onSearch,
                          onSubmitted: onSubmitted,
                        ),
                      )
                    : title,
                centerTitle: true,
                actions: [
                  InkWell(
                    onTap: () {

                      onClose();
                    },
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                      size: 80.sp,
                    ),
                  )
                ],
              ),
      ],
    );
  }

  void _onIconPressed() {
    Nav.to(MyTicketScreen.routeName);
  }

  @override
  Size get preferredSize => Size.fromHeight(150.h);
}
