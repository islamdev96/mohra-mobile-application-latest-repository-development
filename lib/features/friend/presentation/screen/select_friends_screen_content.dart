import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/mansour/search_textfield.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/friend/presentation/state_m/provider/select_friends_screen_notifier.dart';
import 'package:starter_application/features/friend/presentation/widget/select_friends_list.dart';

class SelectFriendsScreenContent extends StatefulWidget {
  SelectFriendsScreenContent({Key? key}) : super(key: key);

  @override
  _SelectFriendsScreenContentState createState() =>
      _SelectFriendsScreenContentState();
}

class _SelectFriendsScreenContentState
    extends State<SelectFriendsScreenContent> {
  late SelectFriendsScreenNotifier sn;
  double headerHeight = 0.45.h;
  double footerHeight = 0.17.sh;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<SelectFriendsScreenNotifier>(context);
    sn.context = context;
    return sn.isLoading
        ? Container(
            child: WaitingWidget(),
            color: Colors.white,
          )
        : Stack(
            children: [
              DraggableHome(
                title:  Text(""),
                leading: IconButton(
                  onPressed: () => Nav.pop(),
                  icon: Icon(
                    AppConstants.getIconBack(),
                    color: AppColors.white,
                    size: 75.sp,
                  ),
                ),
                alwaysShowLeadingAndAction: true,
                headerWidget: _buildHeader(),
                headerExpandedHeight: headerHeight,
                backgroundColor: AppColors.mansourLightGreyColor,
                body: [
                  _buildSelectFriendsList(),
                  SizedBox(
                    height: footerHeight + 50.h,
                  ),
                ],
              ),
              _buildFooter(),
            ],
          );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.appbarGradiant1,
          begin: AlignmentDirectional.topEnd,
          end: AlignmentDirectional.bottomStart,
        ),
      ),
      child: Align(
        alignment: AlignmentDirectional.bottomCenter,
        child: Container(
          height: 130.h,
          width: 0.9.sw,
          margin: EdgeInsets.only(
            bottom: 70.h,
          ),
          child: SearchTextField(
            textKey: GlobalKey(),
            controller: TextEditingController(),
            focusNode: FocusNode(),
            hint: "Search",

            /// Decoration
          ),
        ),
      ),
    );
  }

  Widget _buildSelectFriendsList() {
    return SelectFriendsList(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      friends: sn.friends,
      selectedIDs: sn.selectedFriendsIds,
      onSelectAllTap: sn.onSelectAllItemsTap,
      onFriendTap: sn.onFriendTap,
    );
  }

  Widget _buildFooter() {
    return Positioned(
      bottom: 0,
      child: Container(
        height: footerHeight,
        width: 1.sw,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              50.r,
            ),
            topRight: Radius.circular(
              50.r,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(
                0.2,
              ),
              offset: const Offset(0, 2),
              spreadRadius: 3,
              blurRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: CustomMansourButton(
            width: 0.9.sw,
            // padding: EdgeInsets.symmetric(
            //   vertical: 40.h,
            // ),
            titleText: "Tag ${sn.selectedFriendsIds.length} Friends",

            titleStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 45.sp,
            ),
            onPressed: sn.onSelectFriendsTap,
          ),
        ),
      ),
    );
  }
}
