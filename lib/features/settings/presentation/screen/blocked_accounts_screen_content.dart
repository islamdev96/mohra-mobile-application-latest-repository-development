import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/features/health/presentation/widget/profile/circled_profile_pic.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/blocked_accounts_screen_notifier.dart';

class BlockedAccountsScreenContent extends StatelessWidget {
  late BlockedAccountsScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<BlockedAccountsScreenNotifier>(context);
    sn.context = context;
    return ProgressHUD(
      child: Container(
        height: 1.sh,
        width: 1.sw,
        margin: EdgeInsets.only(top: 10),
        child: BlocConsumer<FriendCubit, FriendState>(
          bloc: sn.friendCubit,
          listener: (context, state) {
            if (state is MyFriendsLoadedState) {
              sn.onBlockedFriendsLoaded(state.friendsEntity);
            }
          },
          builder: (context, state) {
            return state.maybeMap(
              myFriendsLoadedState: (s) => _buildList(),
              friendInitState: (s) => _buildList(),
              friendLoadingState: (s) => WaitingWidget(),
              orElse: () => _buildList(),
            );
          },
        ),
      ),
    );
  }

  _buildList() {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.mansourDarkOrange.withOpacity(0.2),
                offset: Offset(0, 0),
                blurRadius: 2,
              )
            ],
          ),
          margin: EdgeInsets.symmetric(horizontal: 15),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              Row(
                children: [
                  ProfilePic(
                    width: 150.w,
                    height: 150.w,
                    imageUrl:
                        sn.blockedFriends.items[index].friendInfo!.imageUrl,
                  ),
                  Gaps.hGap15,
                  Container(
                    height: 150.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          sn.blockedFriends.items[index].friendInfo!.fullName,
                          style: TextStyle(
                            fontSize: 45.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          Translation.current.userName +
                              ' : ' +
                              sn.blockedFriends.items[index].friendInfo!
                                  .userName!,
                          style: TextStyle(
                              fontSize: 35.sp, color: AppColors.text_gray),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Gaps.vGap32,
              Row(
                children: [
                  Spacer(),
                  Text(
                    'Blocked at : 17-12-2022',
                    style:
                        TextStyle(fontSize: 35.sp, color: AppColors.text_gray),
                  ),
                ],
              ),
              Gaps.vGap16,
              BlocConsumer<FriendCubit , FriendState>(
                bloc: sn.blockCubit,
                builder: (context , state) {
                  return state.maybeMap(
                    orElse: (){
                      return CustomMansourButton(
                        height: 40,
                        titleText: Translation.current.un_block,
                        onPressed: (){
                          sn.unBlock(index);
                        },
                      );
                    }
                  );
                },
                listener: (context , state) {
                  if(state is FriendUnblockedState){
                    sn.onUnBlockDone();
                    ProgressHUD.of(context)!.dismiss();
                  }
                  if(state is FriendLoadingState){
                    ProgressHUD.of(context)!.show();
                  }
                },
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Gaps.vGap32;
      },
      itemCount: sn.blockedFriends.items.length,
    );
  }
}
