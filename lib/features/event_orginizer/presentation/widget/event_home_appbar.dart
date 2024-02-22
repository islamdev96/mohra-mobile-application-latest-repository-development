import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/event/presentation/screen/my_ticket_screen.dart';
import 'package:starter_application/features/event/presentation/widget/event_search_text_field.dart';
import 'package:starter_application/features/event_orginizer/presentation/state_m/provider/event_organizer_details_screen_notifier.dart';
import 'package:starter_application/features/event_orginizer/presentation/state_m/provider/event_organizer_screen_notifier.dart';
import 'package:starter_application/features/event_orginizer/presentation/widget/event_search_text_filed.dart';
import 'package:starter_application/features/home/presentation/screen/home_screen/home_screen.dart';


class EventsHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  EventsHomeAppBar(
      {Key? key,
      required this.isLeading,
      required this.onPress,
      required this.sn,
       this.title,
      required this.onClose,
      required this.controller,
      this.isHasLeading = false,
      required this.onSubmitted,
      required this.onSearch})
      : super(key: key);
  final bool isLeading;
  final EventOrganizerScreenNotifier sn;
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
                        child: EventsSearchTextField(
                          controller: controller,
                          onSearch: onSearch,
                          onSubmitted: onSubmitted,
                          onChanged: (value) {
                            sn.searchText = value;
                          },
                        ),
                      )
                    : title,
                leading: InkWell(
                    onTap: ()=> sn.scaffoldKey.currentState!.openDrawer(),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset("assets/icons/side_bar_icon.png",height: 25,width: 25,),
                    )),
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
          leading: InkWell(
              onTap: ()=> sn.scaffoldKey.currentState!.openDrawer(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset("assets/icons/side_bar_icon.png",height: 25,width: 25,),
              )),
                title: isLeading
                    ? Padding(
                        padding: EdgeInsetsDirectional.only(end: 50.w),
                        child: EventsSearchTextField(
                          controller: controller,
                          onSearch: onSearch,
                          onSubmitted: onSubmitted,
                          onChanged: (e){
                            sn.searchText = e;
                          },
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


class EventsDetailsHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  EventsDetailsHomeAppBar(
      {Key? key,
        required this.isLeading,
        required this.onPress,
        required this.sn,
        this.title,
        required this.onClose,
        required this.controller,
        this.isHasLeading = false,
        required this.onSubmitted,
        required this.onSearch})
      : super(key: key);
  final bool isLeading;
  final EventOrganizerDetailsScreenNotifier sn;
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
          iconTheme: IconThemeData(color: AppColors.black),
          titleSpacing: 0,
          backgroundColor: AppColors.white,
          shadowColor: AppColors.white,
          leading: IconButton(
            onPressed: () {
              Nav.pop();
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minHeight: 0,
              minWidth: 0,
            ),
            icon: Icon(
              AppConstants.getIconBack(),
              color: Colors.black,
              size: 80.h,
            ),
          ),
          title: isLeading
              ? Padding(
            padding: EdgeInsetsDirectional.only(end: 50.w),
            child: EventsSearchTextField(
              controller: controller,
              onSearch: onSearch,
              onSubmitted: onSubmitted,
              onChanged: (value) {
                sn.searchText = value;
              },
            ),
          )
              : title,
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
          iconTheme: IconThemeData(color: AppColors.black),
          titleSpacing: 0,
          backgroundColor: AppColors.white,
          shadowColor: AppColors.white,
          leading: IconButton(
            onPressed: () {
              Nav.pop();
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minHeight: 0,
              minWidth: 0,
            ),
            icon: Icon(
              AppConstants.getIconBack(),
              color: Colors.black,
              size: 80.h,
            ),
          ),
          title: isLeading
              ? Padding(
            padding: EdgeInsetsDirectional.only(end: 50.w),
            child: EventsSearchTextField(
              controller: controller,
              onSearch: onSearch,
              onSubmitted: onSubmitted,
              onChanged: (e){
                sn.searchText = e;
              },
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