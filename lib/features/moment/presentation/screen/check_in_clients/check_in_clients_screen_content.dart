import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/features/account/domain/entity/nearby_client_entity.dart';
import 'package:starter_application/features/moment/presentation/state_m/provider/check_in_clients_screen_notifier.dart';

import '../../../../friend/domain/entity/client_entity.dart';
import '../../../../messages/presentation/widgets/friend_widget.dart';

class CheckInClientsScreenContent extends StatefulWidget {
  @override
  State<CheckInClientsScreenContent> createState() =>
      _CheckInClientsScreenContentState();
}

class _CheckInClientsScreenContentState
    extends State<CheckInClientsScreenContent> {
  late CheckInClientsScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<CheckInClientsScreenNotifier>(context);
    sn.context = context;
    return ListView.separated(
        itemBuilder: (context, index) =>
            _buildItem(sn.clients.elementAt(index)),
        separatorBuilder: (context, index) => SizedBox(
              height: 40.h,
            ),
        itemCount: sn.clients.length);
  }

  Widget _buildItem(NearbyClientEntity clientEntity) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: GestureDetector(
        onTap: () {
          sn.navToUserProfile(clientEntity);
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100.r),
              child: CustomNetworkImageWidget(
                height: 150.w,
                width: 150.w,
                imgPath: clientEntity.imageUrl,
              ),
            ),
            const Spacer(),
            Text(
              clientEntity.name,
              style: TextStyle(fontSize: 50.sp),
            ),
            const Spacer(
              flex: 6,
            ),
            if (!clientEntity.isFriend)
              FriendWidget(
                clientEntity: ClientEntity(
                    id: clientEntity.id,
                    name: clientEntity.name,
                    surname: clientEntity.name,
                    emailAddress: clientEntity.emailAddress,
                    phoneNumber: clientEntity.phoneNumber,
                    imageUrl: clientEntity.imageUrl,
                    fullName: clientEntity.name,
                    code: '',
                    addresses: [],
                    qrCode: '',
                    countryCode: '',
                    hasAvatar: false),
              ),
          ],
        ),
      ),
    );
  }
}
