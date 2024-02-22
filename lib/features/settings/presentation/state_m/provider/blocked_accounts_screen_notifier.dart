import 'package:flutter/material.dart';
import 'package:starter_application/features/friend/data/model/request/get_my_friends_request.dart';
import 'package:starter_application/features/friend/data/model/request/unblock_friend_params.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/features/messages/domain/entity/friends_entity.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';


class BlockedAccountsScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final friendCubit = FriendCubit();
  final blockCubit = FriendCubit();
   late FriendsEntity blockedFriends;
  /// Getters and Setters


  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }

  getBlockedFriends(){
    friendCubit.getMyFriends(GetMyFriendsRequest(
      isBlock: true,
    ));
  }
  onBlockedFriendsLoaded(FriendsEntity friendsEntity){
    blockedFriends = friendsEntity;
    notifyListeners();
  }


  unBlock(int index){
    blockCubit.unblockFriend(UnblockFriendParams(id: blockedFriends.items[index].friendInfo!.id!));
  }

  onUnBlockDone(){
    notifyListeners();
    getBlockedFriends();

  }

}
