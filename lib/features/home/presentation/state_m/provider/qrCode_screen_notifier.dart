import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/features/friend/data/model/request/add_friend_by_qrcode_param.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

class QrCodeScreenNotifier extends ScreenNotifier {
  late BuildContext context;
  final FriendCubit addFriendCubit = FriendCubit();
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  void closeNotifier() {
    addFriendCubit.close();
    this.dispose();
  }

  onQrCodeScanned(String? friendId) {
    if (friendId != null)
      addFriendCubit.addFriendByQrCode(AddFriendByQrCodeParam(friendId));
  }

  void takeScreenShot() async {
    // String path = await createFolder(type: ExternalPath.DIRECTORY_SCREENSHOTS);
    Uint8List? _image = await screenshotController.capture();
    if (_image == null) return;
    final tempDir = await getTemporaryDirectory();
    File? file = await new File('${tempDir.path}/image.jpg').create();
    file.writeAsBytesSync(_image);

    GallerySaver.saveImage(file.path).then((value) {
      ErrorViewer.showError(
          context: context,
          error: CustomError(message: Translation.current.image_saved),
          callback: () {});
    });
  }
}
