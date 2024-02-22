import 'package:flutter/material.dart';
import 'package:starter_application/features/friend/data/model/request/get_my_friends_request.dart';
import 'package:starter_application/features/friend/data/model/request/unblock_friend_params.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/features/messages/domain/entity/friends_entity.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';


class MutedAccountsScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final friendCubit = FriendCubit();
  final muteCubit = FriendCubit();
  late FriendsEntity mutedFriends;
  /// Getters and Setters


  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }


  getMutedFriends(){
    friendCubit.getMyFriends(GetMyFriendsRequest(
      isMuted: true,
    ));
  }

  onMutedFriendsLoaded(FriendsEntity friendsEntity){
    mutedFriends = friendsEntity;
    notifyListeners();
  }

  mute(int index){
    muteCubit.changeMuteStatus(UnblockFriendParams(id: mutedFriends.items[index].friendInfo!.id!));
  }


  onMuteStatusChanged(){
    getMutedFriends();
    notifyListeners();
  }

}
