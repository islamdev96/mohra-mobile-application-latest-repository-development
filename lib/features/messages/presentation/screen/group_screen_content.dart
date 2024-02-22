import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/extensions/extensions.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/mansour/search_textfield.dart';
import 'package:starter_application/core/ui/widgets/pagination_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/features/friend/presentation/widget/select_friends_list.dart';
import 'package:starter_application/features/messages/domain/entity/friend_entity.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../core/common/style/dimens.dart';
import '../../../../core/ui/dialogs/show_dialog.dart';
import '../screen/../state_m/provider/group_screen_notifier.dart';

class GroupScreenContent extends StatefulWidget {
  @override
  State<GroupScreenContent> createState() => _GroupScreenContentState();
}

class _GroupScreenContentState extends State<GroupScreenContent> {
  late GroupScreenNotifier sn;
  double headerHeight = 0.35.h;
  double footerHeight = 0.17.sh;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<GroupScreenNotifier>(context);
    sn.context = context;

    return Stack(
      children: [
        Column(
          children: [
            _buildHeader(),
            Expanded(
              child: BlocBuilder<FriendCubit, FriendState>(
                bloc: sn.friendCubit,
                builder: (context, state) => state.maybeMap(
                  friendInitState: (value) => WaitingWidget(),
                  friendLoadingState: (value) => sn.friends.isEmpty
                      ? WaitingWidget()
                      : _buildSelectFriendsList(),
                  orElse: () => _buildSelectFriendsList(),
                ),
              ),
            ),
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
      child: SafeArea(
        child: Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: Container(
            width: 0.9.sw,
            margin: EdgeInsets.only(
              bottom: 70.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Nav.pop();
                        },
                        icon:  Icon(
                          AppConstants.getIconBack(),
                          color: AppColors.white,
                        ),
                      ),
                      Text(
                        Translation.current.select_member,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 50.sp),
                      ),
                    ],
                  ),
                ),
                Gaps.vGap32,
                SearchTextField(
                  textKey: GlobalKey(),
                  controller: sn.searchController,
                  focusNode: FocusNode(),
                  hint: Translation.current.search,

                  /// Decoration
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectFriendsList() {
    return PaginationWidget<FriendEntity>(
      refreshController: sn.refreshController,
      getItems: sn.returnData,
      items: sn.friends,
      onDataFetched: sn.onDataFetched,
      child: SelectFriendsList(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        friends: sn.friends,
        selectedIDs: sn.selectedFriendsIDs,
        onSelectAllTap: sn.onSelectAllItemsTap,
        onFriendTap: sn.onFriendTap,
      ),
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
          child: sn.isLoading
              ? WaitingWidget()
              : CustomMansourButton(
                  width: 0.9.sw,
                  // padding: EdgeInsets.symmetric(
                  //   vertical: 40.h,
                  // ),
                  titleText:
                      "${Translation.current.select} ${sn.selectedFriendsIDs.length} ${Translation.current.members}",

                  titleStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 45.sp,
                  ),
                  onPressed: () {
                    if(sn.selectedFriendsIDs.length>0){
                      sn.navTOGroupDetails();
                    }else{
                      showGroupValidationDialog();
                    }
                  },
                ),
        ),
      ),
    );
  }
  void showGroupValidationDialog() {
    ShowDialog().showElasticDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Dimens.dp15),
            ),
          ),
          title: Text(
            Translation.current.groupValidation,
            style: Colors.black.bodyText2,
          ),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(const Radius.circular(25)),
            ),
            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          ScreenUtil().setWidth(35),
                        ),
                      ),
                      child: Text(
                        Translation.of(context).confirm,
                        style: const TextStyle(color: Colors.white),
                      ),
                      onPressed: ()async{
                       Nav.pop();
                      },
                      textColor: Theme.of(context).primaryColor,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

}
