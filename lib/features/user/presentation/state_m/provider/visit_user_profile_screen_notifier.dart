import 'package:flutter/material.dart';
import 'package:starter_application/core/entities/address_entity.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/single_message_screen_params.dart';
import 'package:starter_application/features/account/data/model/request/get_client_profile_request.dart';
import 'package:starter_application/features/account/domain/entity/client_profile_entity.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';
import 'package:starter_application/features/friend/data/model/request/block_friend_params.dart';
import 'package:starter_application/features/friend/data/model/request/delete_friend_request_params.dart';
import 'package:starter_application/features/friend/data/model/request/send_friend_request_params.dart';
import 'package:starter_application/features/friend/data/model/request/unblock_friend_params.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/features/messages/presentation/screen/single_message_screen.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class VisitUserProfileScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  AccountCubit accountCubit = AccountCubit();
  FriendCubit friendCubit = FriendCubit();
  FriendCubit muteCubit = FriendCubit();
  FriendCubit blockCubit = FriendCubit();
  late ClientProfileEntity clientProfileEntity;
  bool isFriend = false;
  bool isMuted = false;
  bool isBlocked = false;
  bool hasFriendRequest = false;
  String userAddress ='';
  /// Getters and Setters

  /// Methods

  getProfile(int id) {
    accountCubit.getClientProfile(GetClientProfileParams(id: id));

  }
  void onAddFriendTap() {
    friendCubit.sendFriendRequest(
        SendFriendRequestParams(receiverId: clientProfileEntity.client!.id!));
  }
  onGettingProfileDone(ClientProfileEntity clientProfileEntity){
      this.clientProfileEntity = clientProfileEntity;
      isFriend = clientProfileEntity.isFriend;
      isMuted = clientProfileEntity.isMuted;
      isBlocked = clientProfileEntity.isBlocked;
      hasFriendRequest = clientProfileEntity.hasFriendRequest;
  }

  addFriend() {
    friendCubit.sendFriendRequest(
        SendFriendRequestParams(receiverId: clientProfileEntity.client!.id!));
  }

  onFriendAddDone(){
    hasFriendRequest= true;
    notifyListeners();
  }

  cancelFriendRequest(){
    friendCubit.cancelFriendRequest(CancelFriendRequestParams(id: this.clientProfileEntity.client!.id!));
  }
  onFriendRequestCancelDone(){
    this.hasFriendRequest = false;
    notifyListeners();
  }

  void navToRoom() {
    Nav.off(SingleMessageScreen.routeName,
        arguments: SingleMessageScreenParams(
          clientId: clientProfileEntity.client!.id,
          newRoom: true,
          details: '',
          firstEntry: true,
          name: clientProfileEntity.client!.name,
          image: (clientProfileEntity.client?.imageUrl ?? '') != ''  ? clientProfileEntity.client?.imageUrl ?? " " :clientProfileEntity.client?.avatarEntity?.avatarUrl ?? "",
          clients: [clientProfileEntity.client!],
        ));
  }

  @override
  void closeNotifier() {
    accountCubit.close();
    friendCubit.close();
    this.dispose();
  }

  mute(){
    muteCubit.changeMuteStatus(UnblockFriendParams(id: clientProfileEntity.client!.id!));
  }
  block(){
    blockCubit.blockFriend(BlockFriendParams(id: clientProfileEntity.client!.id!));
  }
  unBlock(){
    blockCubit.unblockFriend(UnblockFriendParams(id: clientProfileEntity.client!.id!));
  }


  onMuteStatusChanged(){
    bool newValue = !isMuted;
    isMuted = newValue;
    notifyListeners();
  }

  onBlockDone(){
    bool newValue = !isBlocked;
    isBlocked = newValue;
    notifyListeners();
  }

  onUnBlockDone(){
    bool newValue = !isBlocked;
    isBlocked = newValue;
    notifyListeners();
  }

  setUserAddress(){
    /*if(this.clientProfileEntity.client!.addresses.isEmpty){
      userAddress = '';
      return;
    }
    else{
      AddressEntity? selectedAddress;
      this.clientProfileEntity.client!.addresses.forEach((element) {
        if(element.isDefault){
          selectedAddress = element;
        }
      });
      if(selectedAddress == null){
        userAddress = '';
        return;
      }
      else{
        userAddress += selectedAddress!.city!.text +' , ';
        userAddress += selectedAddress!.street! +' - ' ;
      }
    }*/
    userAddress = '';
    notifyListeners();
  }

  messageTapped(bool isFriend){
    Nav.off(SingleMessageScreen.routeName,
        arguments: SingleMessageScreenParams(
          clientId: clientProfileEntity.client!.id,
          newRoom: true,
          firstEntry: false,
          details: '',
          isFriend: isFriend,
          name:clientProfileEntity.client!.fullName,
          image: (clientProfileEntity.client?.imageUrl ?? '') != ''  ? clientProfileEntity.client?.imageUrl ?? " " :clientProfileEntity.client?.avatarEntity?.avatarUrl ?? " ",
          clients: [clientProfileEntity.client!],
        ));
  }

  getAvatarImage(){
    if (clientProfileEntity.client!.avatarEntity== null){
      return '';
    }
    else {
      if (clientProfileEntity.client!.avatarEntity!.avatarUrl== null){
        return '';
      }
    }
    return clientProfileEntity.client!.avatarEntity!.avatarUrl!;
  }
}
