import 'dart:async';
import 'dart:convert';

import 'package:agora_rtm/agora_rtm.dart';

// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/bloc/global/glogal_cubit.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/chat_message_enum.dart';
import 'package:starter_application/core/constants/enums/custom_file_type.dart';
import 'package:starter_application/core/constants/enums/signal_enum.dart';
import 'package:starter_application/core/datasources/shared_preference.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/core/params/screen_params/single_message_screen_params.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/friend/data/model/request/get_my_friends_request.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/app_main_screen_notifier.dart';
import 'package:starter_application/features/messages/data/model/request/create_brodcast_message_params.dart';
import 'package:starter_application/features/messages/data/model/request/create_message_params.dart';
import 'package:starter_application/features/messages/data/model/request/get_conversation_request.dart';
import 'package:starter_application/features/messages/data/model/request/get_groups_params.dart';
import 'package:starter_application/features/messages/data/model/request/get_rtm_token_params.dart';
import 'package:starter_application/features/messages/data/model/response/group_model.dart';
import 'package:starter_application/features/messages/domain/entity/conversation_entity.dart';
import 'package:starter_application/features/messages/domain/entity/friend_entity.dart';
import 'package:starter_application/features/messages/domain/entity/group_entity.dart';
import 'package:starter_application/features/messages/domain/entity/last_message_entity.dart';
import 'package:starter_application/features/messages/domain/entity/message_entity.dart';
import 'package:starter_application/features/messages/domain/entity/messaging_entity.dart';
import 'package:starter_application/features/messages/domain/entity/room_entity.dart';
import 'package:starter_application/features/messages/domain/entity/signal_entity.dart';
import 'package:starter_application/features/messages/presentation/screen/single_message_screen.dart';
import 'package:starter_application/features/messages/presentation/state_m/cubit/messages_cubit.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/messages_screen_notifie.dart';
import 'package:starter_application/features/salary_count/data/model/response/Data.dart';
import 'package:starter_application/features/upload/data/model/request/upload_image_param.dart';
import 'package:starter_application/features/upload/presentation/state_m/cubit/upload_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import 'broadcast_message_screen_notifier.dart';

class GlobalMessagesNotifier extends ScreenNotifier {
  List<RoomEntity> conversations = [];
  List<RoomEntity> groups = [];
  List<FriendEntity> friends = [];
  AgoraRtmClient? rtmClient;
  int? _userId;
  int _increasedIndex = 0;
  MessagesCubit messagesCubit = MessagesCubit();
  MessagesCubit groupsCubit = MessagesCubit();
  UploadCubit uploadCubit = UploadCubit();
  FriendCubit friendCubit = FriendCubit();
  bool loadingConversations = false;
  bool loadingGroups = false;
  List<ConversationEntity> myConversations = [];

  int? get userId => _userId;
  Timer? _timer;

  set userId(int? value) {
    _userId = value;
    notifyListeners();
  }

  String? RTM_TOKEN = null;

  LatLng? sharedLocation;
  List<LocationListener> locationListeners = [];
  List<LocationInfo> locations = [];

  Future<void> getRtmToken() async {
    await messagesCubit
        .getRtmToken(GetRtmTokenParams(uid: '${UserSessionDataModel.userId}'));
  }

  init({bool isNotification = false}) async {
    if (isNotification == false) {
      await getRtmToken();
      await createClient();
      getConversations();
      getGroups();
      getFriends(withListener: true);
    } else {
      getConversations();
      getGroups();
    }
  }

  getConversations() {
    messagesCubit
        .getConversations(GetConversationParams(maxResultCount: 10000));
  }

  resetConversations() {
    conversations.clear();
    loadingConversations = false;
    // notifyListeners();
  }

  getGroups() {
    groupsCubit.getGroups(GetGroupsParams(maxResultCount: 10000));
  }

  resetGroups() {
    groups.clear();
    loadingGroups = false;
    notifyListeners();
  }

  addToConversations({
    required String name,
    required int id,
    required String image,
    required String messageString,
  }) {
    RoomEntity room = RoomEntity(
      conversationEntity: ConversationEntity(
          enName: name,
          isActive: true,
          arName: name,
          name: name,
          channel: userId != null
              ? generateConversationChannelName(id, userId!)
              : '',
          firstUser: ClientEntity(
              emailAddress: '',
              surname: '',
              addresses: [],
              imageUrl: image,
              code: '',
              fullName: name,
              name: name,
              phoneNumber: '',
              id: id,
              qrCode: '',
              hasAvatar: false,
              countryCode: ''),
          secondUser: ClientEntity(
            name: UserSessionDataModel.name,
            surname: UserSessionDataModel.surname,
            emailAddress: UserSessionDataModel.emailAddress,
            phoneNumber: UserSessionDataModel.phoneNumber,
            imageUrl: UserSessionDataModel.imageUrl ?? '',
            fullName: UserSessionDataModel.fullName,
            code: UserSessionDataModel.code ?? '',
            addresses: [],
            qrCode: UserSessionDataModel.qrCode ?? '',
            countryCode: '',
            hasAvatar: true,
          ),
          firstUserId: id,
          secondUserId: UserSessionDataModel.userId,
          localMessages: [
            // MessageEntity(
            //   isRead: true,
            //   text: jsonDecode(messageString)['text'],
            //   creationTime: DateTime.now(),
            //   conversationId: int.tryParse(userId != null
            //       ? generateConversationChannelName(id, userId!)
            //       : ''),
            //   senderId: UserSessionDataModel.userId,
            // )
          ],
          lastMessage: LastMessageEntity(
            isRead: true,
            text: jsonDecode(messageString)['text'],
            senderId: UserSessionDataModel.userId,
            conversationId: int.tryParse(userId != null
                ? generateConversationChannelName(id, userId!)
                : ''),
            creationTime: DateTime.now(),
          ),
          creationTime: DateTime.now(),
          countMessegesUnreaded: 0),
    );
    conversations.add(room);
    // Nav.off(SingleMessageScreen.routeName,
    //     arguments: SingleMessageScreenParams(
    //         clientId: id,
    //         newRoom: false,
    //         firstEntry: true,
    //         isFriend: true,
    //         isGroup: false,
    //         name: name,
    //         image: image,
    //         clients: [
    //           ClientEntity(
    //               emailAddress: '',
    //               surname: '',
    //               addresses: [],
    //               imageUrl: image,
    //               code: '',
    //               fullName: name,
    //               name: name,
    //               phoneNumber: '',
    //               id: id,
    //               qrCode: '',
    //               hasAvatar: false,
    //               countryCode: ''),
    //           ClientEntity(
    //             name: UserSessionDataModel.name,
    //             surname: UserSessionDataModel.surname,
    //             emailAddress: UserSessionDataModel.emailAddress,
    //             phoneNumber: UserSessionDataModel.phoneNumber,
    //             imageUrl: UserSessionDataModel.imageUrl ?? '',
    //             fullName: UserSessionDataModel.fullName,
    //             code: UserSessionDataModel.code ?? '',
    //             addresses: [],
    //             qrCode: UserSessionDataModel.qrCode ?? '',
    //             countryCode: '',
    //             hasAvatar: true,
    //           ),
    //         ],isFriendPage: true));
    // getConversations();
    sortConversations();
  }

  sortConversations() {
    try {
      conversations.sort((a, b) =>
          (b.conversationEntity!.lastMessage!.creationTime!)
              .compareTo(a.conversationEntity!.lastMessage!.creationTime!));
    } catch (e) {}
  }

  addToGroups({
    required GroupEntity? group,
  }) async {
    if (group != null) {
      RoomEntity room =
          RoomEntity(channel: await joinChannel(group.id!), groupEntity: group);
      groups.add(room);
    }
    notifyListeners();
  }

  initConversation() async {
    await getConversations();
    setConversations(myConversations);
  }

  setMyConversations(List<ConversationEntity> conversations) {
    myConversations = conversations;
    notifyListeners();
  }

  setConversations(
    List<ConversationEntity> conversations,
  ) {
    this.conversations = [];
    this.conversations.clear();
    BlocProvider.of<GlogalCubit>(AppConfig().appContext, listen: false)
        .refreshNumber();
    conversations.forEach((element) async {
      int number = 0;
      number += element.countMessegesUnreaded!;
      BlocProvider.of<GlogalCubit>(AppConfig().appContext, listen: false)
          .changeNumber(number);
      this
          .conversations
          .add(RoomEntity(conversationEntity: element, firstEntry: true));
    });
    sortConversations();
    notifyListeners();
  }

  setGroups(List<GroupEntity> groups) async {
    await closeAllGroupChannels();
    this.groups = [];
    this.groups.clear();
    groups.forEach((element) async {
      this.groups.add(RoomEntity(
          groupEntity: element,
          firstEntry: true,
          channel: await joinChannel(element.id!)));
    });
    await Future.delayed(Duration(milliseconds: groups.length * 1500));
    Provider.of<GlobalMessagesNotifier>(AppConfig().appContext, listen: false)
        .loadingGroups = true;
    notifyListeners();
  }

  createClient() async {
    print('aaaa');
    print(RTM_TOKEN);
    if (userId == null) {
      final prefs = await SpUtil.getInstance();
      userId = await prefs.getInt(AppConstants.KEY_USERID);
    }
    rtmClient = await AgoraRtmClient.createInstance(
      AppConstants.AGORA_APP_ID,
    );
    try {
      rtmClient?.setLog(1, 1024000, "path/to/logs.txt");
    } catch (e) {}
    await _login();
    rtmClient?.onMessageReceived = (AgoraRtmMessage message, String peerId) {
      Map<String, dynamic> map = signalDecode(message.text);
      SignalEntity signalEntity = SignalEntity.fromJson(map);
      SignalType type = signalEntity.type;
      print('111');
      switch (type) {
        case SignalType.MESSAGE:
          addToMessages(
            id: userId!,
            messageEntity: MessageEntity(
                text: signalEntity.data,
                isRead: false,
                creationTime: DateTime.now(),
                senderId: int.parse(peerId)),
          );
          break;
        case SignalType.GROUP_CREATED:
          addToGroups(
              group: GroupModel.fromMap(json.decode(signalEntity.data))
                  .toEntity());
          break;
        case SignalType.LIVE_LOCATION:
          print('recieved from ${peerId}');

          Map<String, dynamic> map = textDecode(signalEntity.data);
          var entity = MessagingLiveLocationMessageEntity.fromJson(map);
          print('${entity.lat} ${entity.lng}');
          addToLocations(LocationInfo(
              receiverId: int.parse(peerId),
              location: LatLng(entity.lat, entity.lng),
              isGroup: false));
          break;
      }

      print("Peer msg: " + peerId + ", msg: " + (message.text));
    };
    rtmClient?.onConnectionStateChanged = (int state, int reason) {
      print('Connection state changed: ' +
          state.toString() +
          ', reason: ' +
          reason.toString());
      if (state == 5) {
        rtmClient?.logout();
        print('Logout.');
        /* setState(() {
          _isLogin = false;
        });*/
      }
    };
    /*_client?.onLocalInvitationReceivedByPeer =
        (AgoraRtmLocalInvitation invite) {
      _log(
          'Local invitation received by peer: ${invite.calleeId}, content: ${invite.content}');
    };
    _client?.onRemoteInvitationReceivedByPeer =
        (AgoraRtmRemoteInvitation invite) {
      _log(
          'Remote invitation received by peer: ${invite.callerId}, content: ${invite.content}');
    };*/
  }

  _login() async {
    try {
      if (userId != null) {
        await rtmClient!.login(RTM_TOKEN, userId.toString());
        print('login success');
      }
    } catch (error) {
      await _login();
      print('login error ${error.toString()}');
    }
  }

  logout() async {
    await closeAllGroupChannels();
    rtmClient?.logout();
  }

  closeAllGroupChannels() async {
    try {
      groups.forEach((element) async {
        await element.channel?.leave();
      });
    } catch (e) {}
  }

  Future<int> sendMessage({
    required int id,
    bool isGroup = false,
    required String text,
  }) async {
    RoomEntity room = getRoomById(id: id, isGroup: isGroup);
    if (isGroup) {
      if (room.groupEntity != null) {
        addToMessages(
            id: id,
            isGroup: true,
            messageEntity: MessageEntity(
                senderId: userId,
                text: text,
                creationTime: DateTime.now(),
                isRead: true));
        try {
          await room.channel?.sendMessage2(RtmMessage.fromText(
              SignalEntity(type: SignalType.MESSAGE, data: text).stringify()));
        } on AgoraRtmChannelException catch (e) {
          print(e.toString());
          if (e.code == 2 || e.code == 1) return 0;
        }
      }
    } else {
      addToMessages(
          id: id,
          isGroup: false,
          messageEntity: MessageEntity(
              senderId: userId,
              text: text,
              creationTime: DateTime.now(),
              isRead: true));
      try {
        if (Provider.of<AppMainScreenNotifier>(
                    getIt<NavigationService>().getNavigationKey.currentContext!,
                    listen: false)
                .isFriendBlocked ==
            false)
          await rtmClient?.sendMessageToPeer2(
              id.toString(),
              RtmMessage.fromText(
                SignalEntity(
                  data: text,
                  type: SignalType.MESSAGE,
                ).stringify(),
              ));
      } on AgoraRtmClientException catch (e) {
        print(e.toString());
        if (e.code == 2 || e.code == 1) return 0;
      }
      print('message sent to ${id}');
    }

    notifyListeners();
    return 1;
  }

  RoomEntity getRoomById({required int id, bool isGroup = false}) {
    RoomEntity room;
    String channel = generateChannelName(id: id, isGroup: isGroup);
    if (isGroup)
      room = groups.firstWhere(
          (element) =>
              element.groupEntity != null &&
              generateGroupChannelName(element.groupEntity!.id!) == channel,
          orElse: () => RoomEntity());
    else
      room = conversations.firstWhere(
        (element) =>
            element.conversationEntity != null &&
            element.conversationEntity!.channel == channel,
        orElse: () => RoomEntity(),
      );
    return room;
  }

  uploadFile({
    required String path,
    required int id,
    required CustomFileType type,
    required ChatMessageType chatType,
    required String roomName,
    required String roomImage,
    required int roomId,
    bool isGroup = false,
  }) {
    late int _index = _increasedIndex++;
    RoomEntity room = getRoomById(id: id, isGroup: isGroup);
    if (isGroup) {
      if (room.groupEntity != null) {
        addToMessages(
            id: id,
            messageEntity: MessageEntity(
                senderId: userId,
                creationTime: DateTime.now(),
                text: MessagingLoadingEntity(
                        id: _index,
                        path: path,
                        type: ChatMessageType.LOADING,
                        roomId: roomId,
                        roomImage: roomImage,
                        roomName: roomName)
                    .stringify(),
                isRead: true),
            isGroup: isGroup);

        uploadCubit.uploadMessagingFile(
            params: UploadFileParams(path: path, type: type),
            id: id,
            loadingIndex: _index,
            isGroup: isGroup,
            chatType: chatType,
            roomName: roomName,
            roomImage: roomImage,
            roomId: roomId);
      }
    } else {
      if (room.conversationEntity != null) {
        addToMessages(
            id: id,
            messageEntity: MessageEntity(
                senderId: userId,
                creationTime: DateTime.now(),
                text: MessagingLoadingEntity(
                  id: _index,
                  path: path,
                  type: ChatMessageType.LOADING,
                  roomId: roomId,
                  roomImage: roomImage,
                  roomName: roomName,
                ).stringify(),
                isRead: true));

        uploadCubit.uploadMessagingFile(
            params: UploadFileParams(path: path, type: type),
            id: id,
            loadingIndex: _index,
            isGroup: isGroup,
            chatType: chatType,
            roomName: roomName,
            roomImage: roomImage,
            roomId: roomId);
      }
    }

    notifyListeners();
  }

  addToMessages(
      {required int id,
      bool isGroup = false,
      required MessageEntity messageEntity}) async {
    int _id = isGroup || id != userId ? id : messageEntity.senderId!.toInt();
    RoomEntity room = getRoomById(id: _id, isGroup: isGroup);
    if (isGroup) {
      if (room.groupEntity != null) {
        List<MessageEntity> messages2 =
            room.groupEntity!.localMessages.reversed.toList();
        messages2.add(messageEntity);
        room.groupEntity!.localMessages = messages2.reversed.toList();
        room.groupEntity!.lastMessage = MessageEntity(
          text: messageEntity.text,
          isRead: messageEntity.isRead,
          creationTime: messageEntity.creationTime,
        );
        if (!messageEntity.isRead)
          room.groupEntity!.countMessegesUnreaded =
              (room.groupEntity!.countMessegesUnreaded ?? 0) + 1;

        // scrollController.jumpTo(scrollController.position.maxScrollExtent);
        putConversationFirst(room, isGroup: isGroup);
      } else {
        // messagesCubit.getGroups(GetGroupsParams(maxResultCount: 1000));
        Map<String, dynamic> map = textDecode(messageEntity.text);
        int id = map['roomId'];
        String name = map['roomName'];
        String image = map['roomImage'];
        groups.add(RoomEntity(
            groupEntity: GroupEntity(
              name: name,
              imageUrl: image,
              id: id,
              details: '',
              friends: [],
              lastMessage: messageEntity,
              localMessages: [messageEntity],
            ),
            channel: await _createChannel(generateGroupChannelName(id))));
      }
    } else {
      if (room.conversationEntity != null) {
        List<MessageEntity> messages2 =
            room.conversationEntity!.localMessages.reversed.toList();
        messages2.add(messageEntity);
        room.conversationEntity!.localMessages = messages2.reversed.toList();
        room.conversationEntity!.lastMessage = LastMessageEntity(
            text: messageEntity.text,
            isRead: messageEntity.isRead,
            creationTime: messageEntity.creationTime);
        if (!messageEntity.isRead)
          room.conversationEntity!.countMessegesUnreaded =
              (room.conversationEntity!.countMessegesUnreaded ?? 0) + 1;

        // scrollController.jumpTo(scrollController.position.maxScrollExtent);
        putConversationFirst(room, isGroup: isGroup);
      } else {
        // Map<String, dynamic> map = textDecode(messageEntity.text);
        // int id = map['roomId'];
        // String name = map['roomName'];
        // String image = map['roomImage'];
        // conversations.add(RoomEntity(
        //   conversationEntity: ConversationEntity(
        //     name: name,
        //     arName: name,
        //     enName: name,
        //     firstUser: ClientEntity(
        //       id: id,
        //       fullName: name,
        //       imageUrl: image,
        //       addresses: [],
        //       name: '',
        //       code: '',
        //       countryCode: '',
        //       emailAddress: '',
        //       hasAvatar: true,
        //       phoneNumber: '',
        //       qrCode: '',
        //       surname: '',
        //     ),
        //     channel: generateChannelNameFromSecondParty(id),
        //     isActive: true,
        //     localMessages: [messageEntity],
        //     lastMessage: LastMessageEntity(
        //       text: messageEntity.text,
        //       isRead: messageEntity.isRead,
        //     ),
        //   ),
        // ));

        // messagesCubit
        //     .getConversations(GetConversationParams(maxResultCount: 1000));
        Future.delayed(const Duration(milliseconds: 100)).then((value) =>
            Provider.of<GlobalMessagesNotifier>(
                    getIt<NavigationService>().getNavigationKey.currentContext!,
                    listen: false)
                .init(isNotification: true));
      }
    }

    notifyListeners();
  }

  putConversationFirst(RoomEntity room, {bool isGroup = false}) {
    if (isGroup) {
      groups.removeWhere(
          (element) => element.groupEntity!.id! == room.groupEntity!.id);
      groups.insert(0, room);
    } else {
      conversations.removeWhere((element) =>
          element.conversationEntity!.id == room.conversationEntity!.id);
      conversations.insert(0, room);
    }
  }

  String generateConversationChannelName(int _1, int _2) {
    if ((_1) > _2)
      return '${_2}_${_1}';
    else
      return '${_1}_${_2}';
  }

  String generateGroupChannelName(int id) {
    return 'G_' + id.toString();
  }

  String generateChannelNameFromSecondParty(int id) {
    return generateConversationChannelName(id, userId!);
  }

  String generateChannelName({required int id, required bool isGroup}) {
    if (isGroup)
      return generateGroupChannelName(id);
    else
      return generateChannelNameFromSecondParty(id);
  }

  setMessages(List<MessageEntity> messages, int id, {bool isGroup = false}) {
    if (messages.isNotEmpty) {
      RoomEntity room = getRoomById(id: id, isGroup: isGroup);
      if (isGroup) {
        if (room.groupEntity != null) {
          List<MessageEntity> localMessages = room.groupEntity!.localMessages;
          room.groupEntity!.localMessages = [];

          room.groupEntity!.localMessages = messages;
          if (localMessages.length > 0)
            localMessages.forEach((element) {
              if (element.id == null) {
                MessageEntity messageEntity = MessageEntity(
                    creationTime: element.creationTime,
                    isRead: element.isRead,
                    text: element.text,
                    senderId: element.senderId,
                    groupId: element.groupId,
                    group: element.group,
                    conversationId: element.conversationId,
                    conversation: element.conversation,
                    id: messages.first.id != null
                        ? messages.first.id! + 1
                        : null);
                room.groupEntity!.localMessages.insert(
                    (room.groupEntity!.localMessages.length - 1),
                    messageEntity);
              }
            });
          if (room.groupEntity!.localMessages.length > 0)
            room.groupEntity!.localMessages
                .sort((a, b) => b.creationTime.compareTo(a.creationTime));
          room.groupEntity!.localMessages.toSet().toList();
          room.firstEntry = false;
        }
      } else {
        if (room.conversationEntity != null) {
          //      List<MessageEntity> localMessages =
          //               room.conversationEntity!.localMessages;
          List<MessageEntity> localMessages = [];
          room.conversationEntity!.localMessages = [];

          room.conversationEntity!.localMessages = messages;
          if (localMessages.length > 0)
            localMessages.forEach((element) {
              if (element.id == null) {
                MessageEntity messageEntity = MessageEntity(
                    creationTime: element.creationTime,
                    isRead: element.isRead,
                    text: element.text,
                    senderId: element.senderId,
                    groupId: element.groupId,
                    group: element.group,
                    conversationId: element.conversationId,
                    conversation: element.conversation,
                    id: messages.first.id != null
                        ? messages.first.id! + 1
                        : null);
                room.conversationEntity!.localMessages.insert(
                    (room.conversationEntity!.localMessages.length - 1),
                    messageEntity);
              }
            });
          if (room.conversationEntity!.localMessages.length > 0)
            room.conversationEntity!.localMessages
                .sort((a, b) => b.creationTime.compareTo(a.creationTime));
          room.conversationEntity!.localMessages.toSet().toList();
          room.firstEntry = false;
        }
      }
      notifyListeners();
    }
  }

  clearMessagesLocally(int id, {bool isGroup = false}) {
    /*Room room = conversations.firstWhere(
      (element) =>
          element.conversationEntity != null &&
          element.conversationEntity!.channel == channel,
      orElse: () => Room(),
    );

    if (room.conversationEntity != null) {
      room.conversationEntity!.localMessages = [];
    }*/
    RoomEntity room = getRoomById(id: id, isGroup: isGroup);
    if (isGroup) {
      if (room.groupEntity != null) {
        room.groupEntity!.localMessages = [];
        room.groupEntity!.lastMessage =
            MessageEntity(text: '', isRead: true, creationTime: DateTime.now());
      }
    } else {
      RoomEntity roomEntity = conversations.firstWhere((element) =>
          element.conversationEntity != null &&
          element.conversationEntity!.channel ==
              generateChannelNameFromSecondParty(id));
      roomEntity.conversationEntity!.lastMessage = LastMessageEntity(
          isRead: true, text: "", creationTime: DateTime.now());
      roomEntity.conversationEntity!.localMessages.clear();
    }
    notifyListeners();
  }

  appendHistoryMessages(List<MessageEntity> messages, int id,
      {bool isGroup = false}) {
    RoomEntity room = getRoomById(id: id, isGroup: isGroup);

    if (isGroup) {
      if (room.groupEntity != null) {
        room.groupEntity!.localMessages.addAll(messages);
        room.firstEntry = false;
      }
    } else if (room.conversationEntity != null) {
      // room.conversationEntity!.localMessages.forEach((element) {
      //   if(messages.indexWhere((messagesElement) => messagesElement.id == element.id) != -1){
      //
      //   }
      // });
      // if(room.conversationEntity!.localMessages.indexWhere((element) => element.id == ))
      List<MessageEntity> temp = messages;
      room.conversationEntity!.localMessages = messages;
      room.firstEntry = false;
    }

    notifyListeners();
  }

  void readAllConversation(int id, bool withNotify, {bool isGroup = false}) {
    RoomEntity room = getRoomById(id: id, isGroup: isGroup);

    if (isGroup) {
      if (room.groupEntity != null) {
        room.groupEntity!.countMessegesUnreaded = 0;
        room.groupEntity!.localMessages.forEach((element) {
          if (!element.isRead) element.isRead = true;
        });
      }
    } else if (room.conversationEntity != null) {
      room.conversationEntity!.countMessegesUnreaded = 0;
      room.conversationEntity!.localMessages.forEach((element) {
        if (!element.isRead) element.isRead = true;
      });
    }
    if (withNotify) notifyListeners();
  }

  Future<AgoraRtmChannel?> joinChannel(int id) async {
    AgoraRtmChannel? _channel =
        await _createChannel(generateGroupChannelName(id));
    try {
      if (_channel != null) {
        await _channel.join();
        print('joined channel');

        _channel.onMemberJoined = (AgoraRtmMember member) {
          print("Member joined: " +
              member.userId +
              ', channel: ' +
              member.channelId);
        };
        _channel.onMemberLeft = (AgoraRtmMember member) {
          print("Member left: " +
              member.userId +
              ', channel: ' +
              member.channelId);
        };
        _channel.onMessageReceived =
            (AgoraRtmMessage message, AgoraRtmMember member) {
          Map<String, dynamic> map = signalDecode(message.text);
          SignalEntity signalEntity = SignalEntity.fromJson(map);
          SignalType type = signalEntity.type;
          switch (type) {
            case SignalType.MESSAGE:
              addToMessages(
                  id: id,
                  messageEntity: MessageEntity(
                    text: signalEntity.data,
                    isRead: false,
                    creationTime: DateTime.now(),
                    senderId: int.parse(
                      member.userId,
                    ),
                  ),
                  isGroup: true);
              print("Channel msg: " + member.userId + ", msg: " + message.text);
              notifyListeners();
              break;
            case SignalType.GROUP_CREATED:
              break;
            case SignalType.LIVE_LOCATION:
              Map<String, dynamic> map = textDecode(signalEntity.data);
              var entity = MessagingLiveLocationMessageEntity.fromJson(map);
              addToLocations(LocationInfo(
                  receiverId: int.parse(member.userId),
                  location: LatLng(entity.lat, entity.lng),
                  isGroup: false));
              break;
          }
        };
      }
    } catch (error) {
      print('error joining channel');
    }
    return _channel;
  }

  addToLocations(LocationInfo locationInfo) {
    LocationInfo location = locations.firstWhere(
      (element) => locationInfo.receiverId == element.receiverId,
      orElse: () => LocationInfo(
          receiverId: -1, location: const LatLng(0, 0), isGroup: false),
    );
    if (location.receiverId != -1)
      locations
          .removeWhere((element) => element.receiverId == location.receiverId);
    locations.add(locationInfo);
    notifyListeners();
  }

  editGroup(GroupEntity groupEntity) {
    late RoomEntity room;
    int i = groups.indexWhere(
      (element) =>
          element.groupEntity != null &&
          element.groupEntity!.id! == groupEntity.id,
    );
    groupEntity.lastMessage = groups[i].groupEntity!.lastMessage;
    groupEntity.localMessages = groups[i].groupEntity!.localMessages;
    groups[i] = RoomEntity(
        groupEntity: groupEntity,
        channel: groups[i].channel,
        firstEntry: groups[i].firstEntry,
        conversationEntity: groups[i].conversationEntity);
    notifyListeners();
  }

  Future<AgoraRtmChannel?> _createChannel(String name) async {
    AgoraRtmChannel? channel = await rtmClient?.createChannel(name);

    return channel;
  }

  @override
  void closeNotifier() {}

  int getMessagesCount(int id, {bool isGroup = false}) {
    RoomEntity room = getRoomById(id: id, isGroup: isGroup);

    if (isGroup) {
      if (room.groupEntity != null)
        return room.groupEntity!.localMessages.length;
    } else if (room.conversationEntity != null)
      return room.conversationEntity!.localMessages.length;
    return 0;
  }

  bool isLastMessageSame(int id, {bool isGroup = false}) {
    RoomEntity room = getRoomById(id: id, isGroup: isGroup);

    if (isGroup) {
      if (room.groupEntity != null)
        return (room.groupEntity!.localMessages.length > 0 &&
                room.groupEntity!.lastMessage != null)
            ? !(room.groupEntity!.localMessages.last.id ==
                room.groupEntity!.lastMessage!.id)
            : true;
    } else if (room.conversationEntity != null)
      return (room.conversationEntity!.localMessages.length > 0 &&
              room.conversationEntity!.lastMessage != null)
          ? !(room.conversationEntity!.localMessages.last.id ==
              room.conversationEntity!.lastMessage!.id)
          : true;
    return true;
  }

  int getSkipMessages(int id, {bool isGroup = false}) {
    RoomEntity room = getRoomById(id: id, isGroup: isGroup);

    if (isGroup) {
      if (room.groupEntity != null) {
        bool num = (room.groupEntity!.localMessages.length > 0 &&
            room.groupEntity!.lastMessage != null);
        return num
            ? ((room.groupEntity!.localMessages.last.id ?? 1) -
                (room.groupEntity!.lastMessage!.id ?? 0))
            : 0;
      }
    } else if (room.conversationEntity != null) {
      bool num = (room.conversationEntity!.localMessages.length > 0 &&
          room.conversationEntity!.lastMessage != null);
      int numMessagesNullId = 0;
      room.conversationEntity!.localMessages.forEach((element) {
        if (element.id == null) numMessagesNullId++;
      });
      return num
          ? ((room.conversationEntity!.localMessages.last.id ?? 0) -
              (room.conversationEntity!.lastMessage!.id ?? 0) -
              numMessagesNullId)
          : 0;
    }
    return 0;
  }

  void removeConversation(int id, {bool isGroup = false}) {
    if (isGroup) {
      RoomEntity room = getRoomById(id: id, isGroup: isGroup);
      room.channel?.leave();
      groups.remove(room);
    } else {
      RoomEntity room = conversations.firstWhere((element) =>
          element.conversationEntity != null &&
          element.conversationEntity!.channel ==
              generateChannelNameFromSecondParty(id));
      room.conversationEntity!.localMessages.clear();
      room.conversationEntity!.lastMessage = LastMessageEntity(
          isRead: true, text: "", creationTime: DateTime.now());
    }
    notifyListeners();
  }

  void addToLiveLocationListeners(LocationListener locationListener) {
    locationListeners.add(locationListener);
    if (_timer == null || !_timer!.isActive) {
      Duration duration = const Duration(seconds: 2);
      _timer = Timer.periodic(duration, (timer) {
        locationListeners.forEach((element) async {
          sharedLocation = await getUserLocationLogic();
          if (sharedLocation != null)
            shareMyLocation(
                id: element.receiverId,
                latLng: sharedLocation!,
                isGroup: element.isGroup);
        });
      });
    }
  }

  void onFileLoaded({
    required int id,
    required int loadingId,
    bool isGroup = false,
    required ChatMessageType type,
    required String url,
    required String roomName,
    required String roomImage,
    required int roomId,
  }) async {
    RoomEntity room = getRoomById(id: id, isGroup: isGroup);
    if (isGroup) {
      if (room.groupEntity != null)
        room.groupEntity!.localMessages.removeAt(getLoadingIndex(
            isGroup: isGroup, loadingId: loadingId, room: room));
    } else {
      if (room.conversationEntity != null)
        room.conversationEntity!.localMessages.removeAt(getLoadingIndex(
            isGroup: isGroup, loadingId: loadingId, room: room));
    }

    int result = await sendMessage(
        id: id,
        text: MessagingFileEntity(
                type: type,
                url: url,
                roomName: roomName,
                roomImage: roomImage,
                roomId: roomId)
            .stringify(),
        isGroup: isGroup);
    if (result == 1)
      sendMessageToServer(CreateMessageParams(
        channel: generateChannelName(id: id, isGroup: isGroup),
        text: MessagingFileEntity(
                type: type,
                url: url,
                roomName: roomName,
                roomImage: roomImage,
                roomId: roomId)
            .stringify(),
        receiverId: isGroup ? null : id,
        groupId: isGroup ? id : null,
      ));
    else
      ErrorViewer.showError(
          context: AppConfig().appContext,
          error: CustomError(message: Translation.current.message_not_sent),
          callback: () {});

    notifyListeners();
  }

  onFileNotLoaded({
    required int id,
    required int loadingId,
    bool isGroup = false,
    required ChatMessageType type,
  }) {
    RoomEntity room = getRoomById(id: id, isGroup: isGroup);
    if (isGroup) {
      if (room.groupEntity != null)
        room.groupEntity!.localMessages.elementAt(getLoadingIndex(
            isGroup: isGroup, loadingId: loadingId, room: room));
    } else {
      if (room.conversationEntity != null)
        room.conversationEntity!.localMessages.removeAt(getLoadingIndex(
            isGroup: isGroup, loadingId: loadingId, room: room));
    }

    notifyListeners();
  }

  Map<String, dynamic> textDecode(String text) {
    Map<String, dynamic> map = {};
    try {
      map = json.decode(text);
    } catch (e) {
      map['type'] = ChatMessageType.TEXT.index;
      map['text'] = text;
    }
    return map;
  }

  static String getMessageFromEntity(Map<String, dynamic> map) {
    final type = ChatMessageType.values[map['type']];

    String message = '';
    switch (type) {
      case ChatMessageType.TEXT:
        message = ' 📝 ';
        message += MessagingTextEntity.fromJson(map).text;
        break;
      case ChatMessageType.IMAGE:
        message = ' 🖼️ ';
        message += MessagingFileEntity.fromJson(map).url.split('/').last;
        break;
      case ChatMessageType.VIDEO:
        message = ' 🎬 ';
        message += MessagingFileEntity.fromJson(map).url.split('/').last;
        break;
      case ChatMessageType.AUDIO:
        message = ' 🎧 ';
        message += MessagingFileEntity.fromJson(map).url.split('/').last;
        break;
      case ChatMessageType.LOADING:
        message = ' ⚓ ';
        break;
      case ChatMessageType.FILE:
        message = ' 🖺 ';
        message += MessagingFileEntity.fromJson(map).url.split('/').last;
        break;
      case ChatMessageType.CONTACT:
        message = ' 📇 ';
        message += MessagingContactEntity.fromJson(map).name;
        break;
      case ChatMessageType.LOCATION:
        message = ' 🗺️ ';
        message += MessagingLocationEntity.fromJson(map).info;
        break;
      case ChatMessageType.LIVE_LOCATION:
        message = ' 🗺️ ';
        break;
    }

    return message;
  }

  Map<String, dynamic> signalDecode(String text) {
    Map<String, dynamic> map = {};
    try {
      map = json.decode(text);
      if (map['data'] == null) {
        map = {};
        map['type'] = SignalType.MESSAGE.index;
        map['data'] = text;
      }
    } catch (e) {
      map['type'] = SignalType.MESSAGE.index;
      map['data'] = text;
    }
    return map;
  }

  int getLoadingIndex(
      {required bool isGroup,
      required RoomEntity room,
      required int loadingId}) {
    int index = -1;
    int resultIndex = -1;
    if (isGroup) {
      room.groupEntity!.localMessages.forEach((element) {
        index++;
        Map<String, dynamic> map = textDecode(element.text);
        if (map['type'] == ChatMessageType.LOADING.index) {
          final message = MessagingLoadingEntity.fromJson(map);
          if (message.id == loadingId) {
            resultIndex = index;
          }
        }
      });
    } else {
      room.conversationEntity!.localMessages.forEach((element) {
        index++;
        Map<String, dynamic> map = textDecode(element.text);
        if (map['type'] == ChatMessageType.LOADING.index) {
          final message = MessagingLoadingEntity.fromJson(map);
          if (message.id == loadingId) {
            resultIndex = index;
          }
        }
      });
    }
    return resultIndex;
  }

  sendMessageToServer(CreateMessageParams params) async {
    messagesCubit.createMessage(params);
  }

  sendBroadcastMessage(CreateBroadCastMessageParams params,
      List<CreateBroadCastMessageFriend> friends) async {
    friends.forEach((element1) {
      RoomEntity room = conversations.firstWhere(
        (element) =>
            element.conversationEntity != null &&
            element.conversationEntity!.channel ==
                generateChannelName(id: element1.id!, isGroup: false),
        orElse: () => RoomEntity(),
      );
      if (room.conversationEntity == null)
        addToConversations(
            name: element1.name ?? '',
            id: element1.id!,
            image: element1.image ?? '',
            messageString: params.text ?? "");

      sendMessage(id: element1.id!, text: params.text!, isGroup: false);
    });
    getConversations();
  }

  void sendGroupCreatedSignal({GroupModel? group}) {
    group?.friends.forEach((element) {
      rtmClient?.sendMessageToPeer(
          element.id.toString(),
          AgoraRtmMessage.fromText(
            SignalEntity(
                    type: SignalType.GROUP_CREATED,
                    data: json.encode(group.toMap()))
                .stringify(),
          ));
    });
  }

  void shareMyLocation({
    bool isGroup = false,
    required int id,
    required LatLng latLng,
  }) {
    String text = SignalEntity(
            type: SignalType.LIVE_LOCATION,
            data: MessagingLiveLocationMessageEntity(
              senderId: UserSessionDataModel.userId,
              type: ChatMessageType.LIVE_LOCATION,
              lng: latLng.longitude,
              lat: latLng.latitude,
              roomId: id,
              roomImage: '',
              roomName: '',
            ).stringify())
        .stringify();
    if (isGroup) {
      RoomEntity room = getRoomById(id: id, isGroup: isGroup);
      room.channel?.sendMessage(AgoraRtmMessage.fromText(
          SignalEntity(type: SignalType.MESSAGE, data: text).stringify()));
    } else {
      print('222 sent to ${id}');
      rtmClient?.sendMessageToPeer(
        id.toString(),
        AgoraRtmMessage.fromText(
          text,
        ),
      );
    }
  }

  GetMyFriendsRequest getFriendsParam = GetMyFriendsRequest(
    skipCount: 0,
    maxResultCount: 10000,
  );

  void getFriends({bool withListener = true}) {
    friendCubit.getMyFriends(getFriendsParam, withListener: withListener);
    if (withListener) notifyListeners();
  }

  bool isFriend(int? id) {
    // getFriends(withListener: true);
    final matchedFriends = friends.where((element) => element.friendId == id);
    if (matchedFriends.length > 0 && !matchedFriends.first.isBlock) return true;
    return false;
  }

  bool isFriendBlocked(int? id) {
    final matchedFriends = friends.where((element) => element.friendId == id);
    if (matchedFriends.length > 0) return matchedFriends.first.isBlock;
    return false;
  }
}

class LocationListener {
  final int receiverId;
  final bool isGroup;

  LocationListener({required this.receiverId, required this.isGroup});
}

class LocationInfo {
  final int receiverId;
  final LatLng? location;
  final bool isGroup;

  LocationInfo(
      {required this.receiverId,
      required this.location,
      required this.isGroup});
}
