import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/features/friend/presentation/widget/select_friend_card.dart';
import 'package:starter_application/features/messages/domain/entity/friend_entity.dart';

class SelectFriendsList extends StatelessWidget {
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onSelectAllTap;
  final Function(int index)? onFriendTap;
  final List<FriendEntity> friends;
  final List<int> selectedIDs;
  const SelectFriendsList({
    Key? key,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
    this.onFriendTap,
    this.onSelectAllTap,
    this.friends = const [],
    this.selectedIDs = const [],
  }) : super(key: key);

  /// Getters and Setters
  bool get isAllFriendsSelected => friends.length == selectedIDs.length;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // SelectFriendCard(
          //   height: 150.h,
          //   bottomPadding: 50.h,
          //   title: "Select All",
          //   isSelected: isAllFriendsSelected,
          //   titleStyle: TextStyle(
          //     color: Colors.black,
          //     fontSize: 50.sp,
          //     fontWeight: FontWeight.bold,
          //   ),
          //   onTap: onSelectAllTap,
          // ),
          ListView.separated(
            shrinkWrap: shrinkWrap,
            padding: padding,
            physics: physics,
            itemBuilder: (context, index) {
              return SelectFriendCard(
                height: 200.h,
                color: Colors.white,
                title: friends[index].friendInfo?.fullName ?? '',
                image: friends[index].friendInfo?.imageUrl ?? '',
                isSelected: selectedIDs.contains(friends[index].id!),
                onTap: () => onFriendTap?.call(friends[index].id!),
              );
            },
            separatorBuilder: (context, index) {
              return Gaps.vGap10;
            },
            itemCount: friends.length,
          ),
        ],
      ),
    );
  }
}
