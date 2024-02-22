import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/common/dynamic_links.dart';
import 'package:starter_application/core/common/provider/session_data.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/personality_result_screen_params.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/features/home/presentation/screen/app_main_screen.dart';
import 'package:starter_application/features/personality/data/model/request/get_avatar_params.dart';
import 'package:starter_application/features/personality/domain/entity/avatar_entity.dart';
import 'package:starter_application/features/personality/presentation/state_m/cubit/personality_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

class PersonalityResultScreenNotifier extends ScreenNotifier {
  late BuildContext context;
  final personalityCubit = PersonalityCubit();
  ScreenshotController screenshotController = ScreenshotController();
  late Uint8List _imageFile;
  late AvatarListEntity avatarListEntity;
  late PersonalityResultScreenParams params;
  bool isMyPersonality = true;

  /// Variables

  /// Methods

  void onFinishPressed() {
    final session = Provider.of<SessionData>(context, listen: false);
    session.storFullName();
    Nav.off(AppMainScreen.routeName);
  }

  getMyAvatar(PersonalityResultScreenParams? params) {
    if (params == null) {
      this.params = PersonalityResultScreenParams(
        gender: UserSessionDataModel.gender!,
        birthDay: DateTime.parse(UserSessionDataModel.birthday),
      );
    } else {
      this.isMyPersonality = false;
      this.params = params;
    }
    personalityCubit.getMyAvatar(GetAvatarParams(
        gender: this.params.gender, month: this.params.birthDay?.month ?? null));
  }

  void share() async {
    DynamicLinkService dynamicLinkService = DynamicLinkService();
    Uri uri = await dynamicLinkService.createDynamicLink(queryParameters: {
      'gender': params.gender.toString(),
      'date': params.birthDay != null ? params.birthDay!.toIso8601String() : null
    }, type: AppConstants.KEY_DYNAMIC_LINKS_PERSONALITY);
    FlutterShare.share(
      title: uri.toString(),
      linkUrl: uri.toString(),
    );
  }

  onAvatarLoaded(AvatarListEntity avatarListEntity) {
    this.avatarListEntity = avatarListEntity;
    this.isMyPersonality = true;
    notifyListeners();
  }

  onScreenShotTaken() async {
    final image = await screenshotController.capture();
    if (image == null) return;

    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    String name = 'screenshot $time';
    final result = await ImageGallerySaver.saveImage(image, name: name);
    if (result != null)
      ErrorViewer.showError(
          context: context,
          error: CustomError(message: Translation.current.saved_successfully),
          callback: () {});
  }

  @override
  void closeNotifier() {}
}
