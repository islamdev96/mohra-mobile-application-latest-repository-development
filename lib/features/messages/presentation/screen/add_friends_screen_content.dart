import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/ui/widgets/pagination_widget.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart';
import 'package:starter_application/features/messages/presentation/widgets/friend_widget.dart';

import '../screen/../state_m/provider/add_friends_screen_notifier.dart';

class AddFriendsScreenContent extends StatefulWidget {
  @override
  State<AddFriendsScreenContent> createState() =>
      _AddFriendsScreenContentState();
}

class _AddFriendsScreenContentState extends State<AddFriendsScreenContent> {
  late AddFriendsScreenNotifier sn;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<AddFriendsScreenNotifier>(context);
    sn.context = context;
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: PaginationWidget<ClientEntity>(
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

  Widget _buildItem(ClientEntity clientEntity) {
    return GestureDetector(
      onTap: (){
        sn.navToUserProfile(clientEntity);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100.r),
              child: CustomNetworkImageWidget(
                height: 150.w,
                width: 150.w,
                imgPath: clientEntity.imageUrl != null ?  clientEntity.imageUrl : clientEntity.avatarEntity?.avatarUrl??"",
              ),
            ),
            const Spacer(),
            Text(
              clientEntity.fullName,
              style: TextStyle(fontSize: 50.sp),
            ),
            const Spacer(
              flex: 6,
            ),
            FriendWidget(
              clientEntity: clientEntity,
            )
          ],
        ),
      ),
    );
  }
}
