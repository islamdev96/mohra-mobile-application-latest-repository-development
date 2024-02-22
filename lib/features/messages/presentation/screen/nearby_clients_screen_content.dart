import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/features/account/domain/entity/nearby_client_entity.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart';
import 'package:starter_application/features/messages/presentation/widgets/friend_widget.dart';

import '../screen/../state_m/provider/nearby_clients_screen_notifier.dart';

class NearbyClientsScreenContent extends StatefulWidget {
  @override
  State<NearbyClientsScreenContent> createState() =>
      _NearbyClientsScreenContentState();
}

class _NearbyClientsScreenContentState
    extends State<NearbyClientsScreenContent> {
  late NearbyClientsScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<NearbyClientsScreenNotifier>(context);
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
          )),
    );
  }
}
