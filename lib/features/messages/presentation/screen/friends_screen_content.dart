import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/ui/widgets/pagination_widget.dart';
import 'package:starter_application/features/messages/domain/entity/friend_entity.dart';

import '../screen/../state_m/provider/friends_screen_notifier.dart';

class FriendsScreenContent extends StatefulWidget {
  @override
  State<FriendsScreenContent> createState() => _FriendsScreenContentState();
}

class _FriendsScreenContentState extends State<FriendsScreenContent> {
  late FriendsScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<FriendsScreenNotifier>(context);
    // sn.clients.removeWhere((element) => element.client == null);
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
              itemBuilder: (context, index) {
                return _buildItem(sn.clients.elementAt(index));
              },
              separatorBuilder: (context, index) => SizedBox(
                    height: 40.h,
                  ),
              itemCount: sn.clients.length)),
    );
  }

  Widget _buildItem(FriendEntity clientEntity) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: GestureDetector(
        onTap: () {
          sn.navToRoom(clientEntity);
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100.r),
              child: CustomNetworkImageWidget(
                height: 150.w,
                width: 150.w,
                imgPath: (clientEntity.friendInfo?.imageUrl ?? '') != ''
                    ? clientEntity.friendInfo?.imageUrl
                    : clientEntity.friendInfo?.avatarEntity?.avatarUrl ?? "",
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 0.6.sw,
              child: Text(
                clientEntity.friendInfo?.fullName ??
                    clientEntity.friendInfo?.name ??
                    '',
                style: TextStyle(fontSize: 50.sp),
              ),
            ),
            const Spacer(
              flex: 6,
            ),
          ],
        ),
      ),
    );
  }
}
