import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/constants/enums/chat_message_enum.dart';
import 'package:starter_application/core/constants/enums/custom_file_type.dart';
import 'package:starter_application/core/constants/enums/notification_type.dart';
import 'package:starter_application/core/datasources/shared_preference.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/firebase/notification_service.dart';
import 'package:starter_application/core/models/call_notification_model.dart';
import 'package:starter_application/core/models/main_notification_model.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/core/params/screen_params/group_details_screen_param.dart';
import 'package:starter_application/core/params/screen_params/group_screen_params.dart';
import 'package:starter_application/core/params/screen_params/remove_group_member_params.dart';
import 'package:starter_application/core/params/screen_params/single_message_screen_params.dart';
import 'package:starter_application/core/params/screen_params/video_audio_chat_screen_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/core/ui/toast.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/friend/data/model/request/block_friend_params.dart';
import 'package:starter_application/features/friend/data/model/request/get_frined_status_params.dart';
import 'package:starter_application/features/friend/data/model/request/send_friend_request_params.dart';
import 'package:starter_application/features/friend/data/model/request/unblock_friend_params.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart';
import 'package:starter_application/features/friend/domain/entity/get_frined_status_response.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/app_main_screen_notifier.dart';
import 'package:starter_application/features/messages/data/model/request/add_friend_to_group.dart';
import 'package:starter_application/features/messages/data/model/request/clear_conversation_messages_params.dart';
import 'package:starter_application/features/messages/data/model/request/clear_group_messages_params.dart';
import 'package:starter_application/features/messages/data/model/request/create_message_params.dart';
import 'package:starter_application/features/messages/data/model/request/delete_group_params.dart';
import 'package:starter_application/features/messages/data/model/request/get_messages_request.dart';
import 'package:starter_application/features/messages/data/model/request/get_token_params.dart';
import 'package:starter_application/features/messages/data/model/request/make_notification_call_params.dart';
import 'package:starter_application/features/messages/data/model/request/read_messages_request.dart';
import 'package:starter_application/features/messages/domain/entity/friend_entity.dart';
import 'package:starter_application/features/messages/domain/entity/group_entity.dart';
import 'package:starter_application/features/messages/domain/entity/message_entity.dart';
import 'package:starter_application/features/messages/domain/entity/messaging_entity.dart';
import 'package:starter_application/features/messages/domain/entity/token_entity.dart';
import 'package:starter_application/features/messages/domain/usecase/get_messages_usecase.dart';
import 'package:starter_application/features/messages/presentation/screen/create_poll_intro_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/event_intro_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/group_details_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/group_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/message_location_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/remove_group_members_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/send_contact_message_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/video_audio_chat_screen.dart';
import 'package:starter_application/features/messages/presentation/state_m/cubit/messages_cubit.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/global_messages_notifier.dart';
import 'package:starter_application/features/moment/data/model/request/report_post_param.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:starter_application/main.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';
import '../../../data/model/response/token_model.dart';

class SingleMessageScreenNotifier extends ScreenNotifier {
  /// Fields
  static const List<String> videoExtensions = ['mp4', 'wmv'];
  static const List<String> imageExtensions = ['jpg', 'jpeg', 'png'];
  static const List<String> audioExtensions = ['mp3', 'wav', 'wma'];
  static const List<String> docExtensions = ['doc', 'pdf'];
  static const double SIZE_LIMIT = 5242880;
  late BuildContext context;

  /// Variables
  final FocusNode textFiledFocusNode = FocusNode();
  bool isVisible = false;
  bool isRecorderVisible = false;
  bool phoneVisible = false;
  bool firstMessage = true;
  String _message = '';
  int? userId;
  String _name = '';
  String _details = '';
  String _image = '';
  ScrollController scrollController = ScrollController();
  final RefreshController momentsRefreshController = RefreshController();
  late SingleMessageScreenParams params;
  MessagesCubit messagesCubit = MessagesCubit();
  MessagesCubit otherActionsCubit = MessagesCubit();
  MessagesCubit reportCubit = MessagesCubit();
  MessagesCubit muteGroupCubit = MessagesCubit();
  FriendCubit friendCubit = FriendCubit();
  FriendCubit muteCubit = FriendCubit();
  MessagesCubit tokenCubit = MessagesCubit();
  bool firstMessagesGot = false;
  bool loadingNewMessages = false;
  List<ClientEntity> clients = [];
  bool isChatWithVideo = false;
  FlutterSoundRecorder recorder = FlutterSoundRecorder();
  final reasonController = TextEditingController();
  bool isRecorderReady = false;
  ValueNotifier<bool> isLoadingMessages = ValueNotifier<bool>(true);
  RecorderState _recorderState = RecorderState.INIT;
  String _recordPath = '';
  String reason = '';
  List<MessageEntity> messageEntitys = [];

  // Key
  final textFiledKey = new GlobalKey<FormFieldState<String>>();

// Controller
  final textFiledController = TextEditingController();
  final messageBordCastController = TextEditingController();

  /// Getters and Setters
  bool get iconsIsVisible => this.iconsIsVisible;

  bool get phoneIsVisible => this.phoneIsVisible;

  SingleMessageScreenNotifier() {
    // scrollController.addListener(() {
    // if (scrollController.position.pixels ==
    //         scrollController.position.maxScrollExtent &&
    //     !loadingNewMessages &&
    //     params.id != null) {
    //   getMessages();
    // }
    // });
    textFiledController.addListener(() {
      message = textFiledController.text;
    });
  }

  String get name => _name;

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  String get details => _details;

  set details(String value) {
    _details = value;
    notifyListeners();
  }

  String get message => _message;

  set message(String value) {
    _message = value;
    notifyListeners();
  }

  RecorderState get recorderState => _recorderState;

  set recorderState(RecorderState value) {
    _recorderState = value;
    notifyListeners();
  }

  String get recordPath => _recordPath;

  set recordPath(String value) {
    _recordPath = value;
    notifyListeners();
  }

  /// Methods
  initUserId() async {
    if (userId == null) {
      userId =
          Provider.of<GlobalMessagesNotifier>(context, listen: false).userId;
    }
  }

  Future<Result<AppErrors, List<MessageEntity>>> getMomentsItems(
      int unit) async {
    final result = await getIt<GetMessagesUseCase>()(GetMessagesParams(
      conversationId: params.isGroup ? null : params.id,
      groupId: params.isGroup ? params.id : null,
      skipCount: unit * 10,
      maxResultCount: 10,
    ));

    return Result<AppErrors, List<MessageEntity>>(
        data: result.data?.items, error: result.error);
  }

  void onMomentsItemsFetched(List<MessageEntity> items, int nextUnit) {
    Provider.of<GlobalMessagesNotifier>(context, listen: false)
        .setMessages(items, getClientOrGroupId(), isGroup: params.isGroup);
    firstMessagesGot = true;
    // onMessagesLoaded(items);
    notifyListeners();
  }

  getFriendStatus(int id) {
    if (params.isGroup)
      muteGroupCubit.getGroupStatus(GetFrinedStatusParams(GroupId: id));
    else
      muteCubit.getFriendStatus(GetFrinedStatusParams(friendId: id));
  }

  void onPlusIconPressed() {
    isVisible = !isVisible;
    isRecorderVisible = false;
    notifyListeners();
  }

  void onChangeLoadingMessages() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    isLoadingMessages.value = false;
    notifyListeners();
  }

  void onRecorderIconPressed() {
    isRecorderVisible = !isRecorderVisible;
    isVisible = false;
    recordPath = '';
    notifyListeners();
  }

  void removeRecord() {
    recordPath = '';
  }

  void onPhoneIconPressed() {
    phoneVisible = !phoneVisible;
    notifyListeners();
  }

  void hidePhoneIcon() {
    phoneVisible = false;
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
        {}
        break;
      case 4:
        {}
        break;
    }
  }

  void navPollScreen() {
    Nav.to(CreatePollIntroScreen.routeName);
  }

  void navEventScreen() {
    Nav.to(EventIntroScreen.routeName);
  }

  readConversationLocally(bool withNotify) {
    Provider.of<GlobalMessagesNotifier>(context, listen: false)
        .readAllConversation(getClientOrGroupId(), withNotify,
            isGroup: params.isGroup);
  }

  sendTextMessage() async {
    if (textFiledController.text != '') {
      sendMessage(MessagingTextEntity(
        type: ChatMessageType.TEXT,
        text: textFiledController.text,
        roomName: UserSessionDataModel.fullName,
        roomImage: UserSessionDataModel.imageUrl,
        roomId: getGroupIdOrUserId(),
      ).stringify());
      textFiledController.text = '';
    }
  }

  sendWelcomeMessage() async {
    sendMessage(MessagingTextEntity(
      type: ChatMessageType.TEXT,
      text: !AppConfig().isLTR
          ? (params.isGroup ? "مرحباً بكم جميعاً" : "مرحبا, كيف حالك")
          : (params.isGroup ? "Hello all" : "Hi, how are you"),
      roomName: UserSessionDataModel.fullName,
      roomImage: UserSessionDataModel.imageUrl,
      roomId: getGroupIdOrUserId(),
    ).stringify());
  }

  sendMessage(String messageString) async {
    print('message results');
    print(messageString);
    if (params.newRoom && firstMessage && !params.isGroup) {
      Provider.of<GlobalMessagesNotifier>(context, listen: false)
          .addToConversations(
              name: name,
              id: clients.first.id!,
              image: image,
              messageString: messageString);
      // Provider.of<GlobalMessagesNotifier>(context, listen: false).getConversations();
      firstMessage = false;
    }
    int result =
        await Provider.of<GlobalMessagesNotifier>(context, listen: false)
            .sendMessage(
                id: params.isGroup ? params.id! : clients.first.id!,
                text: messageString,
                isGroup: params.isGroup);
    if (result == 1)
      await Provider.of<GlobalMessagesNotifier>(context, listen: false)
          .sendMessageToServer(CreateMessageParams(
        channel: getChannel(),
        text: messageString,
        receiverId: params.isGroup ? null : clients.first.id,
        groupId: params.isGroup ? params.id : null,
      ));
    // if(!params.isGroup) {
    //   if (Provider
    //       .of<AppMainScreenNotifier>(
    //       getIt<NavigationService>().getNavigationKey.currentContext!,
    //       listen: false)
    //       .isFriendBlocked == false) {
    //     await Provider.of<GlobalMessagesNotifier>(context, listen: false)
    //         .sendMessageToServer(CreateMessageParams(
    //       channel: getChannel(),
    //       text: messageString,
    //       receiverId: params.isGroup ? null : clients.first.id,
    //       groupId: params.isGroup ? params.id : null,
    //     ));
    //   } else {
    //
    //   }
    // }else{
    //   await Provider.of<GlobalMessagesNotifier>(context, listen: false)
    //       .sendMessageToServer(CreateMessageParams(
    //     channel: getChannel(),
    //     text: messageString,
    //     receiverId: params.isGroup ? null : clients.first.id,
    //     groupId: params.isGroup ? params.id : null,
    //   ));
    // }
    else
      ErrorViewer.showError(
          context: context,
          error: CustomError(message: Translation.current.message_not_sent),
          callback: () {});
    scrollController.jumpTo(scrollController.position.minScrollExtent);
  }

  int getGroupIdOrUserId() {
    return params.isGroup ? params.id! : userId!;
  }

  readMessages() {
    messagesCubit.readMessages(ReadMessagesParams(
      conversationId: params.isGroup ? null : params.id,
      groupId: params.isGroup ? params.id : null,
    ));
  }

  onMessagesLoaded(List<MessageEntity> messages) {
    loadingNewMessages = true;
    if (!firstMessagesGot) {
      Provider.of<GlobalMessagesNotifier>(context, listen: false)
          .setMessages(messages, getClientOrGroupId(), isGroup: params.isGroup);
      firstMessagesGot = true;
    } else {
      Provider.of<GlobalMessagesNotifier>(context, listen: false)
          .appendHistoryMessages(messages, getClientOrGroupId(),
              isGroup: params.isGroup);
    }
    // scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  String getMemberName(int id) {
    String name = '';
    clients.forEach((element) {
      if (element.id == id) name = element.fullName;
    });
    return name;
  }

  int getClientOrGroupId() {
    if (params.isGroup)
      return params.id!;
    else
      return params.clients.first.id!;
  }

  String getChannel() {
    if (params.isGroup)
      return Provider.of<GlobalMessagesNotifier>(AppConfig().appContext,
              listen: false)
          .generateGroupChannelName(params.id!);
    else
      return Provider.of<GlobalMessagesNotifier>(AppConfig().appContext,
              listen: false)
          .generateConversationChannelName(userId ?? 0, clients.first.id!);
  }

  gotoVideoChatScreen(TokenEntity tokenEntity) {
    messagesCubit.makeCallNotification(MakeNotificationCallParams(
        callType: 1,
        receiverId: clients.first.id,
        token: TokenModel(
            token: tokenEntity.token, channel: tokenEntity.channel)));
    Nav.to(VideoAudioChatScreen.routeName,
        arguments: VideoAudioChatScreenParams(
          isGroup: params.isGroup,
          withVideo: true,
          token: tokenEntity,
          clients: clients,
          name: name,
          id: params.clientId,
        ));

    // Messaging.showNotifications(
    //   title: Translation.of(context).video_call,
    //   description: Translation.of(context).group_call,
    //   type: NotificationType.CallConversation,
    //   payload: MainNotificationModel(
    //           type: Messaging.CALL_CHANNEL_ID_STRING,
    //           payload: CallNotificationModel(
    //                   isGroup: params.isGroup,
    //                   name: name,
    //                   withVideo: true,
    //                   token: tokenEntity.token,
    //                   channel: tokenEntity.channel)
    //               .toMap())
    //       .toMap(),
    // );
  }

  gotoAudioChatScreen(TokenEntity tokenEntity) {
    messagesCubit.makeCallNotification(MakeNotificationCallParams(
        callType: 0,
        receiverId: clients.first.id,
        token: TokenModel(
            token: tokenEntity.token, channel: tokenEntity.channel)));
    Nav.to(VideoAudioChatScreen.routeName,
        arguments: VideoAudioChatScreenParams(
          isGroup: params.isGroup,
          withVideo: false,
          token: tokenEntity,
          clients: clients,
          name: name,
          id: params.clientId,
        ));
    // Messaging.showNotifications(
    //   title: Translation.of(context).video_call,
    //   description: Translation.of(context).group_call,
    //   type: NotificationType.CallConversation,
    //   payload: MainNotificationModel(
    //           type: Messaging.CALL_CHANNEL_ID_STRING,
    //           payload: CallNotificationModel(
    //                   isGroup: params.isGroup,
    //                   name: name,
    //                   withVideo: false,
    //                   token: tokenEntity.token,
    //                   channel: tokenEntity.channel)
    //               .toMap())
    //       .toMap(),
    // );
  }

  void getToken(bool withVideo) {
    isChatWithVideo = withVideo;
    tokenCubit.getToken(GetTokenParams(channel: getChannel()));
  }

  @override
  void closeNotifier() {
    messagesCubit.close();
    friendCubit.close();
    tokenCubit.close();
    muteGroupCubit.close();
    otherActionsCubit.close();
    reportCubit.close();
    recorder.closeRecorder();
    this.dispose();
  }

  onMessagesCleared() {
    Provider.of<GlobalMessagesNotifier>(context, listen: false)
        .clearMessagesLocally(getClientOrGroupId(), isGroup: params.isGroup);
    if (!params.isGroup) {
      Nav.pop();
    }
  }

  clearMessages() {
    if (params.id != null) {
      if (!params.isGroup)
        otherActionsCubit.clearConversationMessages(
            ClearConversationMessagesParams(id: params.id!));
      else
        otherActionsCubit
            .clearGroupMessages(ClearGroupMessagesParams(id: params.id!));
    }
  }

  reportConversation() {
    if (params.id != null) {
      reportCubit.reportConversation(ReportPostParam(
          description: reasonController.text, refId: params.id, refType: 3));
    }
  }

  void editGroup() async {
    await Future.delayed(const Duration(milliseconds: 10));
    Nav.to(GroupDetailsScreen.routeName,
            arguments: GroupDetailsScreenParams(
                friends: [],
                isEditGroup: true,
                name: name,
                details: details,
                image: image,
                id: params.id))
        .then((value) {
      name = (value as GroupEntity).name;
      details = (value as GroupEntity).details;
      image = (value).imageUrl;
    });
  }

  void addMembers() async {
    await Future.delayed(const Duration(milliseconds: 10));
    Nav.to(GroupScreen.routeName,
            arguments: GroupScreenParams(
                friends: clients.map((e) => e.id!).toList(),
                isAddToExistGroup: true,
                groupId: params.id))
        .then((value) {
      clients.addAll(
          (value as List<FriendEntity>).map((e) => e.friendInfo!).toList());
      notifyListeners();
    });
  }

  void removeMembers() async {
    await Future.delayed(const Duration(milliseconds: 10));
    Nav.to(RemoveGroupMembersScreen.routeName,
        arguments:
            RemoveGroupMemberParams(clients: clients, groupId: params.id!));
  }

  deleteGroup() {
    if (params.id != null)
      otherActionsCubit.deleteGroup(DeleteGroupParams(id: params.id!));
  }

  muteGroup() async {
    if (params.isGroup)
      muteGroupCubit.changeMuteStatus(
          AddFriendToGroupParams(groupId: params.id ?? 0, friendIds: []));
    else {
      if (params.clientId != null) {
        final sp = await SpUtil.instance;
        friendCubit.changeMuteStatus(UnblockFriendParams(id: params.clientId!));
        sp.updateStringList("mute", params.clientId.toString());
      }
    }
  }

  onGroupDeleted() {
    Provider.of<GlobalMessagesNotifier>(context, listen: false)
        .removeConversation(params.id!, isGroup: params.isGroup);
    Nav.pop();
  }

  onRecorderPressed() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) return;
    if (recorder.isRecording)
      await stopRecording();
    else
      await startRecording();
  }

  stopRecording() async {
    if (!isRecorderReady) return;
    final path = await recorder.stopRecorder();
    recordPath = File(path!).path;
    recorderState = RecorderState.FINISHED;
  }

  startRecording() async {
    if (!isRecorderReady) return;
    await recorder.startRecorder(toFile: 'audio.mp4', codec: Codec.aacMP4);
    recorderState = RecorderState.RECORDING;
  }

  block() {
    friendCubit.blockFriend(BlockFriendParams(id: clients.first.id!));
  }

  sendRecord() async {
    if (recordPath != '') {
      File file = File(recordPath);
      if (await file.length() > SIZE_LIMIT) {
        ErrorViewer.showError(
            context: context,
            error: CustomError(message: Translation.current.size_limit_msg),
            callback: () {});
        return;
      }
      Provider.of<GlobalMessagesNotifier>(context, listen: false).uploadFile(
        path: recordPath,
        id: getClientOrGroupId(),
        type: CustomFileType.AUDIO,
        chatType: ChatMessageType.AUDIO,
        isGroup: params.isGroup,
        roomName: UserSessionDataModel.fullName,
        roomImage: UserSessionDataModel.imageUrl ?? '',
        roomId: getGroupIdOrUserId(),
      );
    }
    onRecorderIconPressed();
  }

  initRecorder() async {
    isRecorderReady = true;
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  void getMessages({int? conversationId}) {
    messagesCubit.getMessages(GetMessagesParams(
        conversationId: params.isGroup ? null : (params.id ?? conversationId),
        groupId: params.isGroup ? params.id : null,
        skipCount: 0,
        maxResultCount: 10));
  }

  openFilePicker({List<String> allowed = const [], bool isFile = false}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: allowed,
    );

    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      if (file.lengthSync() > SIZE_LIMIT) {
        ErrorViewer.showError(
            context: context,
            error: CustomError(message: Translation.current.size_limit_msg),
            callback: () {});
        return;
      }
      ChatMessageType? chatType =
          getMessageType(path: file.path, isFile: isFile);
      if (chatType != null)
        Provider.of<GlobalMessagesNotifier>(context, listen: false).uploadFile(
          path: file.path,
          id: getClientOrGroupId(),
          type: getFileType(path: file.path, isFile: isFile),
          chatType: chatType,
          isGroup: params.isGroup,
          roomName: UserSessionDataModel.fullName,
          roomImage: UserSessionDataModel.imageUrl ?? '',
          roomId: getGroupIdOrUserId(),
        );
      else
        ErrorViewer.showError(
          context: context,
          error: const CustomError(message: 'Unsupported File'),
          callback: () => () {},
        );
    } else {
      // User canceled the picker\
    }
  }

  CustomFileType getFileType({required String path, bool isFile = false}) {
    List<String> parts = path.split('.');
    String ext = parts.last;

    if (imageExtensions.contains(ext)) {
      return CustomFileType.IMAGE;
    } else if (videoExtensions.contains(ext)) {
      return CustomFileType.VIDEO;
    } else if (audioExtensions.contains(ext)) {
      return CustomFileType.AUDIO;
    } else if (docExtensions.contains(ext)) {
      return CustomFileType.DOC;
    } else
      return CustomFileType.DOC;
  }

  onCameraOpen(bool isImage) async {
    ImagePicker imagePicker = ImagePicker();
    if (isImage) {
      XFile? file = await imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );

      if (file != null) {
        if (await file.length() > SIZE_LIMIT) {
          ErrorViewer.showError(
              context: context,
              error: CustomError(message: Translation.current.size_limit_msg),
              callback: () {});
          return;
        }
        Provider.of<GlobalMessagesNotifier>(context, listen: false).uploadFile(
          path: file.path,
          id: getClientOrGroupId(),
          type: CustomFileType.IMAGE,
          chatType: ChatMessageType.IMAGE,
          isGroup: params.isGroup,
          roomName: UserSessionDataModel.fullName,
          roomImage: UserSessionDataModel.imageUrl ?? '',
          roomId: getGroupIdOrUserId(),
        );
      }
    } else {
      XFile? file = await imagePicker.pickVideo(
        source: ImageSource.camera,
      );
      if (file != null) {
        if (await file.length() > SIZE_LIMIT) {
          ErrorViewer.showError(
              context: context,
              error: CustomError(message: Translation.current.size_limit_msg),
              callback: () {});
          return;
        }
        Provider.of<GlobalMessagesNotifier>(context, listen: false).uploadFile(
          path: file.path,
          id: getClientOrGroupId(),
          type: CustomFileType.VIDEO,
          chatType: ChatMessageType.VIDEO,
          isGroup: params.isGroup,
          roomName: UserSessionDataModel.fullName,
          roomImage: UserSessionDataModel.imageUrl ?? '',
          roomId: getGroupIdOrUserId(),
        );
      }
    }
  }

  ChatMessageType? getMessageType({required String path, bool isFile = false}) {
    List<String> parts = path.split('.');
    String ext = parts.last;

    if (imageExtensions.contains(ext)) {
      if (isFile) return ChatMessageType.FILE;
      return ChatMessageType.IMAGE;
    } else if (videoExtensions.contains(ext)) {
      if (isFile) return ChatMessageType.FILE;
      return ChatMessageType.VIDEO;
    } else if (audioExtensions.contains(ext)) {
      if (isFile) return ChatMessageType.FILE;
      return ChatMessageType.AUDIO;
    } else if (docExtensions.contains(ext)) {
      if (isFile) return ChatMessageType.FILE;
      return ChatMessageType.FILE;
    } else
      return null;
  }

  navToSendContactScreen() {
    Nav.to(SendContactMessageScreen.routeName).then((value) async {
      if (value != null && (value as FriendEntity).friendInfo != null) {
        ClientEntity client = value.friendInfo!;

        sendMessage(MessagingContactEntity(
          type: ChatMessageType.CONTACT,
          id: client.id!,
          name: client.fullName,
          roomName: name,
          roomImage: image,
          roomId: getGroupIdOrUserId(),
        ).stringify());
      }
    });
  }

  shareLiveLocation(LatLng latLng) {
    sendMessage(MessagingLiveLocationMessageEntity(
      senderId: UserSessionDataModel.userId,
      type: ChatMessageType.LIVE_LOCATION,
      lng: latLng.longitude,
      lat: latLng.latitude,
      roomName: UserSessionDataModel.fullName,
      roomImage: UserSessionDataModel.imageUrl,
      roomId: getGroupIdOrUserId(),
    ).stringify());
    Provider.of<GlobalMessagesNotifier>(context, listen: false)
        .addToLiveLocationListeners(LocationListener(
            receiverId: params.isGroup ? params.id! : clients.first.id!,
            isGroup: params.isGroup));
  }

  String get image => _image;

  set image(String value) {
    _image = value;
    notifyListeners();
  }

  void setParams(SingleMessageScreenParams params) {
    this.params = params;
    name = params.name;
    details = params.details;
    image = params.image;
    clients = params.clients;
  }

  void gotoLocation() {
    Nav.to(LocationMessageScreen.routeName).then((value) async {
      (value as LocationScreenResultParam?);

      if (value == null) return;
      if (!value.isShareLiveLocation) {
        String info = getPlaceMarkInfo(value.placeMark!);
        sendMessage(MessagingLocationEntity(
          type: ChatMessageType.LOCATION,
          info: info,
          lat: value.latLng!.latitude,
          lng: value.latLng!.longitude,
          roomName: UserSessionDataModel.fullName,
          roomImage: UserSessionDataModel.imageUrl,
          roomId: getGroupIdOrUserId(),
        ).stringify());
      } else {
        LatLng myLocation = const LatLng(33.510414, 36.278336);
        if (value.latLng != null) myLocation = value.latLng!;
        shareLiveLocation(myLocation);
      }
    });
  }

  void onUnBlockTap() {
    friendCubit.unblockFriend(
      UnblockFriendParams(id: clients.first.id!),
    );
  }

  void onAddFriendTap() {
    friendCubit.sendFriendRequest(
        SendFriendRequestParams(receiverId: clients.first.id!));
  }
}

enum RecorderState { INIT, RECORDING, FINISHED }

class LocationScreenResultParam {
  final bool isShareLiveLocation;
  final Placemark? placeMark;
  final LatLng? latLng;

  LocationScreenResultParam(
      {required this.placeMark,
      required this.isShareLiveLocation,
      required this.latLng});
}
