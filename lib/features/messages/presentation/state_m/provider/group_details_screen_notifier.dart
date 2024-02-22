import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:starter_application/core/constants/enums/custom_file_type.dart';
import 'package:starter_application/core/params/screen_params/group_details_screen_param.dart';
import 'package:starter_application/features/messages/data/model/request/create_group_params.dart';
import 'package:starter_application/features/messages/data/model/request/update_group_params.dart';
import 'package:starter_application/features/messages/domain/entity/friend_entity.dart';
import 'package:starter_application/features/messages/presentation/state_m/cubit/messages_cubit.dart';
import 'package:starter_application/features/upload/data/model/request/upload_image_param.dart';
import 'package:starter_application/features/upload/presentation/state_m/cubit/upload_cubit.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class GroupDetailsScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;

  List<FriendEntity> _friends = [];
  MessagesCubit messagesCubit = MessagesCubit();
  UploadCubit uploadCubit = UploadCubit();
  bool _showHud = false;
  late GroupDetailsScreenParams params;

  /// Getters and Setters
  List<String> get imagesPaths => _imagesFiles.map((e) => e.path).toList();

  /// Variables
  final FocusNode groupTitleFocusNode = FocusNode();
  final FocusNode groupDetailsFocusNode = FocusNode();
  List<XFile> _imagesFiles = [];

  // Key
  final groupTitleKey = new GlobalKey<FormFieldState<String>>();
  final groupDetailsKey = new GlobalKey<FormFieldState<String>>();

  final GlobalKey<FormState> form = GlobalKey<FormState>();
  // Controller
  final groupTitleController = TextEditingController();
  final groupDetailsController = TextEditingController();

  String? imageGroup ;
  List<FriendEntity> get friends => _friends;

  setGroupTitle(String title) {
    print(title);
    groupTitleController.text = title;
    notifyListeners();
  }

  setGroupDetails(String details) {
    print(details);
    groupDetailsController.text = details;
    notifyListeners();
  }

  setGroupImage(String image) {
    print(image);
    imageGroup = image;
    notifyListeners();
  }


  set friends(List<FriendEntity> value) {
    _friends = value;
    notifyListeners();
  }

  bool get showHud => _showHud;

  set showHud(bool value) {
    _showHud = value;
    notifyListeners();
  }

  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }

  void onImagesPicked(List<XFile> imagesFiles) {
    if (imagesPaths.isNotEmpty) {
      _imagesFiles.clear();
    }
    _imagesFiles.addAll(imagesFiles);
    notifyListeners();
  }
  onImageDeleted(int index) {
    _imagesFiles.removeAt(index);
    notifyListeners();
  }

  String getParticipantsText() {
    String result = 'you';
    int index = 0;
    if (friends.length > 3)
      index = 2;
    else
      index = friends.length;
    if (friends.isNotEmpty)
      friends.getRange(0, index).forEach((element) {
        result = result +
            (friends.elementAt(index - 1).id == element.id ? ' and ' : ', ') +
            (element.friendInfo?.fullName ?? '');
      });
    return result;
  }

  void navToGroup() {
    // Nav.to(MessagesScreen.routeName,
    //     arguments: const MessagesScreen(
    //       initialIndex: 1,
    //     ));
    showHud = false;
    if ((form.currentState?.validate() ?? false)) {
      if (imagesPaths.isNotEmpty) {
        uploadCubit.uploadFile(UploadFileParams(
            path: imagesPaths.first, type: CustomFileType.IMAGE));
      }
      else{
        showHud=true;
        createGroup(null);
      }
    }
  }

  void createGroup(String? first) {
    if (params.isEditGroup)
      messagesCubit.updateGroup(UpdateGroupParams(
          name: groupTitleController.text,
          details: groupDetailsController.text,
          imageUrl: first ?? params.image,
          id: params.id!));
    else
      messagesCubit.createGroup(CreateGroupParams(
          name: groupTitleController.text,
          details: groupDetailsController.text,
          imageUrl: first ?? params.image,
          friendIds: friends.map((e) => e.friendInfo!.id!).toList()));
  }
}
