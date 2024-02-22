import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart';
import 'package:starter_application/features/messages/presentation/widgets/remove_member_item_widget.dart';

import '../screen/../state_m/provider/remove_group_members_screen_notifier.dart';

class RemoveGroupMembersScreenContent extends StatefulWidget {
  final RemoveGroupMembersScreenNotifier initialNotifier;
  const RemoveGroupMembersScreenContent({
    Key? key,
    required this.initialNotifier,
  }) : super(key: key);
  @override
  State<RemoveGroupMembersScreenContent> createState() =>
      _RemoveGroupMembersScreenContentState();
}

class _RemoveGroupMembersScreenContentState
    extends State<RemoveGroupMembersScreenContent> {
  late RemoveGroupMembersScreenNotifier sn;
  @override
  void initState() {
    super.initState();
    widget.initialNotifier.params.clients
        .removeWhere((element) => element.id == UserSessionDataModel.userId);
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<RemoveGroupMembersScreenNotifier>(context);
    sn.context = context;
    return Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: ListView.separated(
            itemBuilder: (context, index) =>
                _buildItem(sn.params.clients.elementAt(index)),
            separatorBuilder: (context, index) => SizedBox(
                  height: 40.h,
                ),
            itemCount: sn.params.clients.length));
  }

  Widget _buildItem(ClientEntity clientEntity) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
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
            clientEntity.fullName,
            style: TextStyle(fontSize: 50.sp),
          ),
          const Spacer(
            flex: 6,
          ),
          RemoveMemberItemWidget(
            clientEntity: clientEntity,
            groupId: sn.params.groupId,
            onMemberRemoved: sn.onMemberRemoved,
          )
        ],
      ),
    );
  }
}
