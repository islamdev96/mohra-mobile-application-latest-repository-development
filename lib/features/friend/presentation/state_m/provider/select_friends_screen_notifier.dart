import 'package:flutter/material.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/friend/presentation/screen/select_friends_screen.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/features/messages/domain/entity/friend_entity.dart';

class SelectFriendsScreenNotifier extends ScreenNotifier {
  SelectFriendsScreenNotifier({
    required this.param,
  });

  /// Variables
  late BuildContext context;
  final FriendCubit friendCubit = FriendCubit();
  final SelectFriendsScreenParam param;
  List<int> _selectedFriendsIds = [];
  List<FriendEntity> friends = [];
  bool isLoading = true;

  /// Methods
  void onSelectAllItemsTap() {
    if (!isAllFriendsSelected) {
      _selectedFriendsIds.clear();
      _selectedFriendsIds.addAll(
        List.generate(friends.length, (index) => friends[index].id!),
      );
    } else {
      _selectedFriendsIds.clear();
    }
    notifyListeners();
  }

  void onFriendTap(int id) {
    // _selectedFriendsIds.clear();
    // _selectedFriendsIds.add(id);
    if (_selectedFriendsIds.contains(id))
      _selectedFriendsIds.remove(id);
    else
      _selectedFriendsIds.add(id);
    notifyListeners();
  }

  void loadDone() {
    isLoading = false;
    notifyListeners();
  }

  @override
  void closeNotifier() {
    friendCubit.close();
    this.dispose();
  }

  /// Getters and Setters
  List<int> get selectedFriendsIds => this._selectedFriendsIds;
  bool get isAllFriendsSelected => _selectedFriendsIds.length == friends.length;

  void onSelectFriendsTap() {
    param.onSelectFriends?.call(
        friends.where((e) => selectedFriendsIds.contains(e.id!)).toList());
    Nav.pop();
  }
}
