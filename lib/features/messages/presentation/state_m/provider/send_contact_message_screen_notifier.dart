import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/friend/data/model/request/get_my_friends_request.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/features/messages/domain/entity/friend_entity.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class SendContactMessageScreenNotifier extends ScreenNotifier {
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

  returnContact(FriendEntity friend) {
    Nav.pop(context, friend);
  }

  @override
  void closeNotifier() {
    this.dispose();
  }
}
