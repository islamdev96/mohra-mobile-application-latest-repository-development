import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/single_message_screen_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/friend/data/model/request/get_my_friends_request.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/features/messages/domain/entity/friend_entity.dart';
import 'package:starter_application/features/messages/domain/entity/room_entity.dart';
import 'package:starter_application/features/messages/presentation/screen/single_message_screen.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';
import 'global_messages_notifier.dart';

class FriendsScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  FriendCubit friendCubit = FriendCubit();
  List<FriendEntity> clients = [];
  RefreshController refreshController = RefreshController();

  /// Getters and Setters

  /// Methods
  Future<Result<AppErrors, List<FriendEntity>>> returnData(int unit) async {
    return friendCubit.returnFriends(
      getClientParams(unit),
    );
  }

  void onDataFetched(List<FriendEntity> items, int nextUnit) {
    clients = items;
    notifyListeners();
  }

  getClients() {
    friendCubit.getMyFriends(getClientParams(0));
  }

  GetMyFriendsRequest getClientParams(int unit) {
    return GetMyFriendsRequest(skipCount: unit * 10);
  }

  @override
  void closeNotifier() {
    friendCubit.close();
    this.dispose();
  }

  void navToRoom(FriendEntity clientEntity) {
    RoomEntity checkNumberConversation = Provider.of<GlobalMessagesNotifier>(AppConfig().appContext, listen: false).conversations.firstWhere((element) => (((element.conversationEntity?.secondUserId ?? 0) == clientEntity.friendId) || ((element.conversationEntity?.firstUserId ?? 0) == clientEntity.friendId)),orElse: () => RoomEntity(),);
    Nav.off(SingleMessageScreen.routeName,
        arguments: SingleMessageScreenParams(
          clientId: clientEntity.friendId,
          newRoom: checkNumberConversation.conversationEntity != null ? false : true,
          firstEntry: true,
          name: clientEntity.friendInfo?.fullName ?? '',
          image: (clientEntity.friendInfo?.imageUrl ?? '') != ''  ? clientEntity.friendInfo?.imageUrl ?? " " :clientEntity.friendInfo?.avatarEntity?.avatarUrl ?? " ",
          clients: [clientEntity.friendInfo!],
          isFriend:true,
          isGroup: false,
          isFriendPage: true,
          details: "",
          id: checkNumberConversation.conversationEntity != null ? checkNumberConversation.conversationEntity!.id : 0
        ));
  }
}
