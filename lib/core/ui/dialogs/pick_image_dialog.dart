import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/permissions_utils.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/system_type.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:image_cropper/image_cropper.dart';

void showPickImageDialog({
  required Function(List<XFile> imagesFiles) onImagesPicked,
  Function(Object e)? onError,
  bool isMultiImages = true,
  bool isCircle = false,
  required BuildContext context,

  /// From 0 to 100
  int? imageQuality,
}) {
  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return BottomSheet(
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 70.h,
              right: 70.h,
              top: 70.h,
            ),
            child: PickImageDialog(
              isCircle: isCircle,
              onImagesPicked: onImagesPicked,
              onError: onError,
              isMultiImages: isMultiImages,
              imageQuality: imageQuality,
            ),
          );
        },
        onClosing: () {},
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
              10,
            ),
          ),
        ),
        constraints: BoxConstraints(
          maxHeight: 1.sh,
          minHeight: 0.1.sh,
        ),
        enableDrag: false,
      );
    },
    isScrollControlled: true,
    enableDrag: false,
    isDismissible: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(
          10,
        ),
      ),
    ),
    constraints: BoxConstraints(
      maxHeight: 1.sh,
      minHeight: 0.1.sh,
    ),
  );
}

buildEditImageCard({
  required Function() onTap,
  required String text,
  required Widget icon,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      color: AppColors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(onPressed: onTap, icon: icon),
          Gaps.hGap12,
          Text(
            text,
            style: TextStyle(
              fontSize: 50.sp,
            ),
          ),
        ],
      ),
    ),
  );
}

class PickImageDialog extends StatelessWidget {
  final Function(List<XFile> imagesFiles) onImagesPicked;
  final Function(Object e)? onError;
  final bool isMultiImages;
  final bool isCircle;
  final int? imageQuality;

  PickImageDialog({
    Key? key,
    required this.onImagesPicked,
    required this.isCircle,
    this.onError,
    this.isMultiImages = true,
    this.imageQuality,
  }) : super(key: key);

  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Nav.pop();
              },
              icon: SizedBox(
                height: 80.h,
                width: 80.h,
                child: SvgPicture.asset(
                  AppConstants.SVG_CLOSE,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              Translation.current.add,
              style: TextStyle(
                  fontSize: 45.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black_text),
            ),
            Gaps.hGap64,
          ],
        ),
        Gaps.vGap16,
        buildEditImageCard(
          text: Translation.current.Open_Gallery,
          onTap: () async {
            if (AppConfig().os == SystemType.IOS) {
              await _pickImage(ImageSource.gallery);
            } else
              _pickImage(ImageSource.gallery);
          },
          icon: Icon(Icons.photo),
        ),
        Gaps.vGap8,
        buildEditImageCard(
          text: Translation.current.Open_Camera,
          onTap: () async {
            await _pickImage(ImageSource.camera);
          },
          icon: Icon(Icons.camera),
        ),
        Gaps.vGap96,
      ],
    );
  }

  /// Methods
  Future<void> _pickImage(ImageSource source) async {
    if (source == ImageSource.gallery) {
      if (AppConfig().os == SystemType.IOS) {
        final status = await requestPhotosPermission();
        await _pickImageFromGallery();
      } else {
        final status = await requestPhotosPermission();
        await _pickImageFromGallery();
      }
    }
    if (source == ImageSource.camera) {
      if (AppConfig().os == SystemType.IOS) {
        final status = await requestCameraPermission();
        await _pickImageFromCamera();
      } else {
        final status = await requestCameraPermission();
        if (status == PermissionStatus.granted) await _pickImageFromCamera();
      }
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      List<XFile> images = [];
      // if (isMultiImages)
      //   images = await picker.pickMultiImage(
      //         imageQuality: imageQuality,
      //       ) ??
      //       [];
      // else {
      XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: imageQuality,
      );

      CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: image!.path,
          aspectRatioPresets: Platform.isAndroid
              ? [
                  CropAspectRatioPreset.square,
                  CropAspectRatioPreset.ratio3x2,
                  CropAspectRatioPreset.original,
                  CropAspectRatioPreset.ratio4x3,
                  CropAspectRatioPreset.ratio16x9
                ]
              : [
                  CropAspectRatioPreset.original,
                  CropAspectRatioPreset.square,
                  CropAspectRatioPreset.ratio3x2,
                  CropAspectRatioPreset.ratio4x3,
                  CropAspectRatioPreset.ratio5x3,
                  CropAspectRatioPreset.ratio5x4,
                  CropAspectRatioPreset.ratio7x5,
                  CropAspectRatioPreset.ratio16x9
                ],
          cropStyle: CropStyle.rectangle,
          uiSettings: [
            IOSUiSettings(
              title: Translation.current.edit,
            ),
            AndroidUiSettings(
                toolbarTitle: Translation.current.edit,
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
          ]);
      if (croppedFile != null) {
        image = XFile(croppedFile.path);
      }
      if (image != null) images.add(image);
      // }
      onImagesPicked(images);
    } catch (e) {
      onError?.call(e);
    }
  }

  Future<void> _pickImageFromCamera() async {
    try {
      List<XFile> images = [];

      XFile? image = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: imageQuality,
      );

      CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: image!.path,
          aspectRatioPresets: Platform.isAndroid
              ? [
                  CropAspectRatioPreset.square,
                  CropAspectRatioPreset.ratio3x2,
                  CropAspectRatioPreset.original,
                  CropAspectRatioPreset.ratio4x3,
                  CropAspectRatioPreset.ratio16x9
                ]
              : [
                  CropAspectRatioPreset.original,
                  CropAspectRatioPreset.square,
                  CropAspectRatioPreset.ratio3x2,
                  CropAspectRatioPreset.ratio4x3,
                  CropAspectRatioPreset.ratio5x3,
                  CropAspectRatioPreset.ratio5x4,
                  CropAspectRatioPreset.ratio7x5,
                  CropAspectRatioPreset.ratio16x9
                ],
          cropStyle: CropStyle.rectangle,
          uiSettings: [
            IOSUiSettings(
              title: Translation.current.edit,
            ),
            AndroidUiSettings(
                toolbarTitle: Translation.current.edit,
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
          ]);
      if (croppedFile != null) {
        image = XFile(croppedFile.path);
      }

      if (image != null) images.add(image);

      onImagesPicked(images);
    } catch (e) {
      onError?.call(e);
    }
  }
}
