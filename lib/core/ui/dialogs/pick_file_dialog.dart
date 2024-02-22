import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/permissions_utils.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:image_cropper/image_cropper.dart';

// import 'package:video_compress/video_compress.dart';

void showPickFileDialog({
  required Function(List<String> paths) onFilesPicked,
  Function(Object e)? onError,
  bool isMultiFiles = true,
  required BuildContext context,

  /// Not working
  int? fileQuality,
}) {
  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return BottomSheet(
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 20,
              right: 20,
              top: 10,
            ),
            child: PickfileDialog(
              onFilesPicked: onFilesPicked,
              onError: onError,
              isMultiFiles: isMultiFiles,
              fileQuality: fileQuality,
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
          minHeight: 0.2.sh,
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
      minHeight: 0.2.sh,
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

class PickfileDialog extends StatelessWidget {
  final Function(List<String> paths) onFilesPicked;
  final Function(Object e)? onError;
  final bool isMultiFiles;
  final int? fileQuality;

  PickfileDialog({
    Key? key,
    required this.onFilesPicked,
    this.onError,
    this.isMultiFiles = true,
    this.fileQuality,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Translation.of(context).add,
              style: TextStyle(fontSize: 50.sp, fontWeight: FontWeight.bold),
            ),
            IconButton(
                onPressed: () {
                  Nav.pop();
                },
                icon: Icon(Icons.clear))
          ],
        ),
        Gaps.vGap16,
        buildEditImageCard(
          text: Translation.current.Open_Camera,
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (ctx) {
                return BottomSheet(
                  builder: (BuildContext context) {
                    return Container(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        left: 20,
                        right: 20,
                        top: 10,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Translation.of(context).select,
                                style: TextStyle(
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Nav.pop();
                                  },
                                  icon: Icon(Icons.clear))
                            ],
                          ),
                          Gaps.vGap16,
                          buildEditImageCard(
                            text: Translation.current.capture_image,
                            onTap: () {
                              _captureImage();
                            },
                            icon: Icon(Icons.photo_camera),
                          ),
                          Gaps.vGap8,
                          buildEditImageCard(
                            text: Translation.current.capture_video,
                            onTap: () async {
                              await _captureVideo();
                            },
                            icon: Icon(Icons.video_collection),
                          ),
                          Gaps.vGap96,
                        ],
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
                    minHeight: 0.2.sh,
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
                minHeight: 0.2.sh,
              ),
            );
          },
          icon: Icon(Icons.photo_camera),
        ),
        Gaps.vGap8,
        buildEditImageCard(
          text: Translation.current.Open_Gallery,
          onTap: () async {
            showModalBottomSheet(
              context: context,
              builder: (ctx) {
                return BottomSheet(
                  builder: (BuildContext context) {
                    return Container(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        left: 20,
                        right: 20,
                        top: 10,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Translation.of(context).select,
                                style: TextStyle(
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Nav.pop();
                                  },
                                  icon: Icon(Icons.clear))
                            ],
                          ),
                          Gaps.vGap16,
                          buildEditImageCard(
                            text: Translation.current.gallery_image,
                            onTap: () async {
                              await _pickFile(isImage: true);
                            },
                            icon: Icon(Icons.photo_camera),
                          ),
                          Gaps.vGap8,
                          buildEditImageCard(
                            text: Translation.current.gallery_video,
                            onTap: () async {
                              await _pickFile(isImage: false);
                            },
                            icon: Icon(Icons.video_collection),
                          ),
                          Gaps.vGap96,
                        ],
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
                    minHeight: 0.2.sh,
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
                minHeight: 0.2.sh,
              ),
            );
          },
          icon: Icon(Icons.photo),
        ),
        Gaps.vGap96,
      ],
    );
  }

  /// Methods
  Future<void> _pickFile({bool isImage = true}) async {
    if (Platform.isIOS) {
      final ImagePicker _picker = ImagePicker();
      // Pick an image or video
      XFile? image;
      if (isImage) {
        image = await _picker.pickImage(source: ImageSource.gallery);
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

        onFilesPicked([image!.path]);
      } else {
        image = await _picker.pickVideo(source: ImageSource.gallery);
        if (image != null) onFilesPicked([image!.path]);
      }
    } else {
      try {
        if (isImage) {
          List<XFile> images = [];
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: [
              'png',
              'jpg',
            ],
            allowMultiple: isMultiFiles,
          );
          CroppedFile? croppedFile = await ImageCropper().cropImage(
              sourcePath: result!.files.first.path!,
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
            images = [XFile(croppedFile.path)];
          }
          final paths =
              images.map((e) => e.path).whereType<String>().toList() ?? [];
          Nav.pop();
          onFilesPicked(paths);
        } else {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['mp4'],
            allowMultiple: isMultiFiles,
          );
          final paths =
              result?.files.map((e) => e.path).whereType<String>().toList() ??
                  [];
          Nav.pop();
          onFilesPicked(paths);
        }
      } catch (e) {
        onError?.call(e);
      }
    }
  }

  void _captureImage() async {
    final status = await requestCameraPermission();
    try {
      ImagePicker picker = ImagePicker();
      List<XFile> images = [];

      final ImagePicker _picker = ImagePicker();
      // Pick an image
      XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
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

      images.add(image);
      Nav.pop();
      onFilesPicked(images.map((e) => e.path).toList());
    } catch (e) {
      onError?.call(e);
    }
  }

  Future<void> _captureVideo() async {
    final status = await requestCameraPermission();
    ImagePicker picker = ImagePicker();
    try {
      List<XFile> videos = [];

      final video = await picker.pickVideo(
          source: ImageSource.camera,
          preferredCameraDevice: CameraDevice.front,
          maxDuration: const Duration(seconds: 10));
      // MediaInfo? mediaInfo = await VideoCompress.compressVideo(
      //   video!.path,
      //   quality: VideoQuality.DefaultQuality,
      //   deleteOrigin: false, // It's false by default
      // );
      // if (mediaInfo != null) videos.add(XFile(mediaInfo.path!));

      if (video != null) videos.add(XFile(video.path));
      Nav.pop();
      onFilesPicked(videos.map((e) => e.path).toList());
    } catch (e) {
      onError?.call(e);
    }
  }
}
