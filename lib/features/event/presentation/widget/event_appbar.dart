import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/event/presentation/screen/my_ticket_screen.dart';
import 'package:starter_application/features/event/presentation/state_m/provider/event_home_screen_notifier.dart';
import 'package:starter_application/features/event/presentation/widget/event_search_text_field.dart';
import 'package:starter_application/features/location/domain/entity/location_lite_entity.dart';

class EventHomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final TextEditingController controller;
  final Function(LocationLiteEntity? locationLiteEntity) search;
  final LocationLiteEntity? locationLiteEntity;
  final EventHomeScreenNotifier? sn;
  const EventHomeAppBar({
    Key? key,
    required this.controller,
    required this.search,
    required this.locationLiteEntity,
    required this.sn,
  }) : super(key: key);

  @override
  State<EventHomeAppBar> createState() => _EventHomeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(150.h);
}

class _EventHomeAppBarState extends State<EventHomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 50.w),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AppBar(
            elevation: 0,
            titleSpacing: 0,
            backgroundColor: AppColors.transparent,
            leading: InkWell(
                onTap: () {
                  Nav.pop();
                },
                child:  Icon(
                  AppConstants.getIconBack(),
                  color: Colors.white,
                )),
            // shadowColor: AppColors.transparent,
            title: Padding(
              padding: EdgeInsetsDirectional.only(end: 50.w),
              child: EventSearchTextField(
                locationLiteEntity: widget.locationLiteEntity,
                search: (locationLiteEntity) => widget.search(locationLiteEntity),
                controller: widget.controller,
                sn: widget.sn,
              ),
            ),
            actions: [

              GestureDetector(
                onTap: _onIconPressed,
                child: Image.asset(
                  AppConstants.IMG_MY_TICKET,
                  height: 80.w,
                  width: 80.w,
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }

  void _onIconPressed() {
    Nav.to(MyTicketScreen.routeName);
  }

  @override
  Size get preferredSize => Size.fromHeight(150.h);
}
