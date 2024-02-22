import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/ui/widgets/pagination_widget.dart';
import 'package:starter_application/features/messages/domain/entity/friend_entity.dart';

import '../screen/../state_m/provider/send_contact_message_screen_notifier.dart';

class SendContactMessageScreenContent extends StatefulWidget {
  @override
  State<SendContactMessageScreenContent> createState() =>
      _SendContactMessageScreenContentState();
}

class _SendContactMessageScreenContentState
    extends State<SendContactMessageScreenContent> {
  late SendContactMessageScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<SendContactMessageScreenNotifier>(context);
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

  Widget _buildItem(FriendEntity clientEntity) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: GestureDetector(
        onTap: () {
          sn.returnContact(clientEntity);
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100.r),
              child: CustomNetworkImageWidget(
                height: 150.w,
                width: 150.w,
                imgPath: clientEntity.friendInfo?.imageUrl ?? '',
              ),
            ),
            const Spacer(),
            Text(
              clientEntity.friendInfo?.fullName ?? '',
              style: TextStyle(fontSize: 50.sp),
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
