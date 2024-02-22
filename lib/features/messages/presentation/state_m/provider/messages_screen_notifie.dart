import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/group_screen_params.dart';
import 'package:starter_application/core/params/screen_params/single_message_screen_params.dart';
import 'package:starter_application/core/params/screen_params/visit_user_profile_screen_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/friend/data/model/request/get_clients_request.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/features/messages/presentation/screen/broadcast_message_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/friends_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/group_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/nearby_clients_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/single_message_screen.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/global_messages_notifier.dart';
import 'package:starter_application/features/messages/presentation/widgets/show_dilog.dart';
import 'package:starter_application/features/user/presentation/screen/view_profile_screen.dart';
import 'package:starter_application/features/user/presentation/screen/visit_user_profile_screen.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../../core/params/screen_params/video_audio_chat_screen_params.dart';
import '../../../../home/presentation/state_m/provider/app_main_screen_notifier.dart';
import '../../screen/video_audio_chat_screen.dart';

class MessagesNotifier extends ScreenNotifier {
  late BuildContext context;
  late int numberOfNotRead = 0;
  static const int _pageLength = 10;
  bool isMoreSelect = false;
  bool isSearch = false;

  // static int countMessegesUnreaded=0;
  static int countFriendReceivedOnly = 0;

  // static var number=ValueNotifier(countMessegesUnreaded);
  static var friendReceivedOnly = ValueNotifier(countFriendReceivedOnly);

  List<MenuItem> items = [
    MenuItem(text: Translation.current.mark_as_read),
    MenuItem(text: Translation.current.select_all),
  ];
  List<ClientEntity> _searches = [];
  RefreshController refreshController = RefreshController();
  FriendCubit friendCubit = FriendCubit();
  TextEditingController searchController = TextEditingController();
  List<int> _selectedIndexes = [];

  AnimateIconController animateIconController = AnimateIconController();
  bool isAddOpened = false;
  double opacity = 0;

  notify() {
    notifyListeners();
  }

  bool openAdd() {
    isAddOpened = true;

    if (animateIconController.isStart()) {
      animateIconController.animateToEnd();
    }
    opacity = 1;
    notifyListeners();
    return true;
  }

  bool closeAdd() {
    isAddOpened = false;

    if (animateIconController.isEnd()) {
      animateIconController.animateToStart();
    }
    opacity = 0;
    notifyListeners();
    return true;
  }

  MessagesNotifier() {
    searchController.addListener(() {
      // if (searchController.text != '') {
      //   searchFriends();
      // }
      searchFriends();
    });
  }

  List<Message> messages = [];
  List<Groups> groups = [];
  List<String> icons = [
    AppConstants.SVG_PEOPLE_MESSAGE,
    AppConstants.SVG_QR_MESSAGE,
    AppConstants.SVG_FRIENDS_ICON,
    AppConstants.SVG_QR_BLOCK,
    AppConstants.SVG_QR_CONTACT,
  ];
  List<String> iconsName = [
    Translation.current.add_friend,
    Translation.current.scan_qr_code,
    Translation.current.friend,
    Translation.current.blocked,
    Translation.current.contact,
  ];
  List<FriendRequest> friendRequests = [];
  List<FriendRequest> friendYouKnow = [];

  List<int> get selectedMessagesIndexes => this._selectedIndexes;

  bool get isAllFriendsSelected => _selectedIndexes.length == messages.length;

  bool get isSearchValue => isSearch;

  //Method
  onTabForRead(int Index) {
    if (_selectedIndexes.length == 0) {
      isMoreSelect = false;
      // navTOSingleMessage();
    }
    if (isMoreSelect) {
      if (!selectedMessagesIndexes.contains(Index)) {
        _selectedIndexes.add(Index);
        messages[Index].isSelected = true;
        print(_selectedIndexes);
      } else {
        messages[Index].isSelected = false;
        _selectedIndexes.remove(Index);
      }
    }
    if (!messages[Index].isRead && !isMoreSelect) {
      messages[Index].isRead = true;
      numberOfNotRead--;
    }
    notifyListeners();
    print("_selectedIndexes.length${_selectedIndexes.length}");
  }

  Future<Result<AppErrors, List<ClientEntity>>> returnSearchesData(
      int unit) async {
    return friendCubit.returnClients(
      setSearchFriendsRequest(
          search: searchController.text, unit: unit, contain: true),
    );
  }

  onLongTab(int Index) {
    isMoreSelect = true;
    if (!messages[Index].isSelected) {
      if (!selectedMessagesIndexes.contains(Index)) {
        _selectedIndexes.add(Index);
        print(_selectedIndexes);
      }
      messages[Index].isSelected = true;
    }
    notifyListeners();
  }

  deletedSelected() {
    print(_selectedIndexes);
    print(selectedMessagesIndexes);
    for (int i = 0; i < messages.length; i++) {
      if (messages[i].isSelected) {
        print(messages[i].id);
        messages[i].isSelected = false;
        messages.removeAt(i);
      }
    }

    notifyListeners();
  }

  List<ClientEntity> get searches => _searches;

  set searches(List<ClientEntity> value) {
    _searches = value;
    notifyListeners();
  }

  void onDataFetched(List<ClientEntity> items, int nextUnit) {
    searches = items;
    notifyListeners();
  }

  void onSelectAllItemsTap() {
    isMoreSelect = true;
    if (!isAllFriendsSelected) {
      _selectedIndexes.clear();
      for (int i = 0; i < messages.length; i++) {
        if (!selectedMessagesIndexes.contains(i)) {
          messages[i].isSelected = true;
          selectedMessagesIndexes.add(i);
        }
      }
    } else {
      clear();
      _selectedIndexes.clear();
    }
    notifyListeners();
  }

  delete(int id) {
    Provider.of<GlobalMessagesNotifier>(AppConfig().appContext, listen: false)
        .removeConversation(id);
    notifyListeners();
  }

  void clear() {
    for (int i = 0; i < messages.length; i++) {
      messages[i].isSelected = false;
    }
    selectedMessagesIndexes.clear();

    notifyListeners();
  }

  void MarkAsRead() {
    for (int i = 0; i < messages.length; i++) {
      messages[i].isRead = true;
      numberOfNotRead = 0;
      messages[i].isSelected = false;
      _selectedIndexes.clear();
    }
    notifyListeners();
  }

  void switchOperation(int value) {
    switch (value) {
      case 1:
        {}
        break;
      case 2:
        {
          break;
        }
      case 3:
        {
          print("dsad");
          MarkAsRead();
        }
        break;
      case 4:
        {
          onSelectAllItemsTap();
        }
        break;
    }
  }

  void search() {
    isSearch = !isSearch;
    print(isSearch);
    notifyListeners();
  }

  navToUserProfile(ClientEntity clientEntity) {
    if (clientEntity.id == UserSessionDataModel.userId)
      Nav.to(
        ViewProfileScreen.routeName,
      );
    else
      Nav.to(VisitUserProfileScreen.routeName,
          arguments: VisitUserProfileScreenParams(id: clientEntity.id!));
  }

  Future searchFriends() async {
    friendCubit.getClients(setSearchFriendsRequest(
      unit: 0,
      search: searchController.text,
      contain: true,
    ));
  }

  GetClientsRequest setSearchFriendsRequest({
    required int unit,
    String? search,
    bool contain = false,
  }) {
    return GetClientsRequest(
        skipCount: unit * _pageLength, keyword: search, CheckContain: contain);
  }

  void navTOBrodCast() {
    Nav.pop();
    Nav.to(BroadcastMessageScreen.routeName);
  }

  void navToFriendsScreen() {
    Nav.pop();
    Nav.to(FriendsScreen.routeName);
  }

  void navTOGroup() {
    Nav.pop();
    Nav.to(GroupScreen.routeName,
        arguments: GroupScreenParams(friends: [], firstEntry: true));
  }

  void navTOSingleMessage({
    required String image,
    required String name,
    required String details,
    required String date,
    required String title,
    required List<ClientEntity> clients,
    required bool firstEntry,
    required int? id,
    required int? clientId,
    int? creatorId,
    bool isGroup = false,
  }) {
    if (context.read<AppMainScreenNotifier>().isInCall &&
        context.read<AppMainScreenNotifier>().callerId == clientId) {
      Nav.to(VideoAudioChatScreen.routeName,
          arguments: VideoAudioChatScreenParams(
            isGroup: context.read<AppMainScreenNotifier>().callParams!.isGroup,
            withVideo:
                context.read<AppMainScreenNotifier>().callParams!.withVideo,
            token: context.read<AppMainScreenNotifier>().callParams!.token,
            clients: context.read<AppMainScreenNotifier>().callParams!.clients,
            name: context.read<AppMainScreenNotifier>().callParams!.name,
          ));
      // context.read<AppMainScreenNotifier>().setController(PageController());
    } else {
      Nav.to(
        SingleMessageScreen.routeName,
        arguments: SingleMessageScreenParams(
            name: name,
            image: image,
            clients: clients,
            newRoom: false,
            firstEntry: firstEntry,
            isGroup: isGroup,
            clientId: clientId,
            isFriend: true,
            details: details,
            creatorId: creatorId,
            id: id),
      );
      // context.read<AppMainScreenNotifier>().setController(PageController());
    }
  }

  void onTabAddFloat({
    required List<Widget> items,
    required double itemRadius,
    required double centerRadius,
  }) {
    onAddButtonTap(
      centerRadius: centerRadius,
      itemRadius: itemRadius,
      items: items,
    );
  }

  void onAddButtonTap({
    required List<Widget> items,
    required double itemRadius,
    required double centerRadius,
  }) {
    showAddMessageDialog(
      context,
      centerRadius: centerRadius,
      itemRadius: itemRadius,
      items: items,
    );
  }

  void navToNearbyClientsScreen() {
    Nav.to(NearbyClientsScreen.routeName);
  }

  @override
  void closeNotifier() {}

  void block(int id) {
    Provider.of<GlobalMessagesNotifier>(AppConfig().appContext)
        .removeConversation(id);
  }
}

class Message {
  final int id;
  final String image;
  final String name;
  final String message;
  final String date;
  final String numNotRead;
  bool isSelected = false;
  bool isRead = false;

  Message({
    required this.id,
    required this.image,
    required this.name,
    required this.message,
    required this.date,
    required this.numNotRead,
    required this.isRead,
    required this.isSelected,
  });
}

class Groups {
  final String image;
  final String name;
  final String title;
  final String date;

  Groups({
    required this.image,
    required this.name,
    required this.title,
    required this.date,
  });
}

class MenuItem {
  final String text;

  MenuItem({
    required this.text,
  });
}

class FriendRequest {
  final String image;
  final String name;

  FriendRequest({
    required this.image,
    required this.name,
  });
}
