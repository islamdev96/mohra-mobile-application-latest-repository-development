import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/ui/widgets/pagination_widget.dart';
import 'package:starter_application/features/messages/domain/entity/friend_entity.dart';
import 'package:starter_application/features/messages/presentation/widgets/blocked_friend_widget.dart';

import '../screen/../state_m/provider/blocked_people_screen_notifier.dart';

class BlockedPeopleScreenContent extends StatefulWidget {
  @override
  State<BlockedPeopleScreenContent> createState() =>
      _BlockedPeopleScreenContentState();
}

class _BlockedPeopleScreenContentState
    extends State<BlockedPeopleScreenContent> {
  late BlockedPeopleScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<BlockedPeopleScreenNotifier>(context);
    sn.context = context;
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: PaginationWidget<FriendEntity>(
          refreshController: sn.refreshController,
          getItems: (unit) {
            return sn.returnData(unit);
          },
          items: sn.clients,
          onDataFetched: (items, nextUnit) => sn.onDataFetched(items, nextUnit),
          child: ListView.separated(
              itemBuilder: (context, index) =>
                  _buildItem(sn.clients.elementAt(index)),
              separatorBuilder: (context, index) => SizedBox(
                    height: 40.h,
                  ),
              itemCount: sn.clients.length)),
    );
  }

  Widget _buildItem(FriendEntity friendEntity) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100.r),
            child: CustomNetworkImageWidget(
              height: 150.w,
              width: 150.w,
              imgPath: friendEntity.friendInfo?.imageUrl ?? '',
            ),
          ),
          const Spacer(),
          Text(
            friendEntity.friendInfo?.fullName ?? '',
            style: TextStyle(fontSize: 50.sp),
          ),
          const Spacer(
            flex: 6,
          ),
          BlockedFriendWidget(
            friendEntity: friendEntity,
            onUnBlockMemberSuccess:()=> sn.onUnBlockMemberSuccess(friendEntity),
          )
        ],
      ),
    );
  }
}
