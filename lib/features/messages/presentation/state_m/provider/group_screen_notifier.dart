import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/group_details_screen_param.dart';
import 'package:starter_application/core/params/screen_params/group_screen_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/friend/data/model/request/get_my_friends_request.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/features/messages/data/model/request/add_friend_to_group.dart';
import 'package:starter_application/features/messages/domain/entity/friend_entity.dart';
import 'package:starter_application/features/messages/presentation/screen/group_details_screen.dart';
import 'package:starter_application/features/messages/presentation/state_m/cubit/messages_cubit.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class GroupScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  FriendCubit friendCubit = FriendCubit();
  MessagesCubit messagesCubit = MessagesCubit();

  /// Variables
  List<FriendEntity> _friends = [];
  List<int> _selectedFriendsIDs = [];
  bool _isLoading = false;
  RefreshController refreshController = RefreshController();

  late GroupScreenParams params;
  TextEditingController searchController = TextEditingController();

  List<FriendEntity> get friends => _friends;

  set friends(List<FriendEntity> value) {
    _friends = value;
    notifyListeners();
  }

  GroupScreenNotifier() {
    searchController.addListener(() {
      if (searchController.text != '') {
        getClients();
      }
    });
  }

  /// Getters and Setters

  List<int> get selectedFriendsIDs => this._selectedFriendsIDs;

  initSelectedFriends() {
    if (!params.isAddToExistGroup) {
      _selectedFriendsIDs = params.friends;
      notifyListeners();
    }
  }

  bool get isAllFriendsSelected => _selectedFriendsIDs.length == friends.length;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Methods
  void onSelectAllItemsTap() {
    if (!isAllFriendsSelected) {
      _selectedFriendsIDs.clear();
      friends.forEach((element) {
        _selectedFriendsIDs.add(element.id!);
      });
    } else {
      _selectedFriendsIDs.clear();
    }
    notifyListeners();
  }

  onFriendsLoaded(List<FriendEntity> friends) {
    this.friends = filterFriends(friends);
  }

  List<FriendEntity> filterFriends(List<FriendEntity> friends) {
    List<FriendEntity> _friends = [];
    if (params.isAddToExistGroup)
      friends.forEach((element) {
        if (params.friends.firstWhere(
              (element2) => element.friendInfo!.id! == element2,
              orElse: () => -30000,
            ) ==
            -30000) _friends.add(element);
      });
    else
      _friends = friends;
    return _friends;
  }

  void onFriendTap(int id) {
    if (_selectedFriendsIDs.contains(id))
      _selectedFriendsIDs.remove(id);
    else
      _selectedFriendsIDs.add(id);
    notifyListeners();
  }

  Future<Result<AppErrors, List<FriendEntity>>> returnData(int unit) async {
    Result<AppErrors, List<FriendEntity>> result =
        await friendCubit.returnFriends(
      getClientParams(unit),
    );

    return Result(
      data: filterFriends(result.data ?? []),
      error: result.error,
    );
  }

  void onDataFetched(List<FriendEntity> items, int nextUnit) {
    friends = items;
    notifyListeners();
  }

  getClients() {
    friendCubit.getMyFriends(getClientParams(0));
  }

  GetMyFriendsRequest getClientParams(int unit) {
    return GetMyFriendsRequest(
      keyword: searchController.text == '' ? null : searchController.text,
      skipCount: unit * 10,
      isBlock: false,
    );
  }

  List<FriendEntity> getSelectedFriends() {
    List<FriendEntity> friends = [];
    selectedFriendsIDs.forEach((element) {
      this.friends.forEach((element2) {
        if (element == element2.id) friends.add(element2);
      });
    });
    return friends;
  }

  void navTOGroupDetails() {
    if (params.isAddToExistGroup) {
      isLoading = true;
      messagesCubit.addFriendToGroup(AddFriendToGroupParams(
          groupId: params.groupId!, friendIds: selectedFriendsIDs));
    } else {
      if (params.firstEntry)
        Nav.off(GroupDetailsScreen.routeName,
            arguments: GroupDetailsScreenParams(friends: getSelectedFriends(),));
      else {
        Nav.pop(context, getSelectedFriends());
      }
    }
  }

  @override
  void closeNotifier() {
    this.dispose();
  }
}
