import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/permissions_utils.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';

void showPickVideoDialog({
  required Function(List<XFile> videoFiles) onVideosPicked,
  Function(Object e)? onError,
  /// Not working for now
  bool isMultiVideos = true,

}) {
  showDialog(
      context: AppConfig().appContext,
      builder: (context) {
        return Dialog(
          child: PickViedoDialog(
            onVideosPicked: onVideosPicked,
            onError: onError,
            isMultiVideos: isMultiVideos,
          ),
        );
      });
}

class PickViedoDialog extends StatelessWidget {
  final Function(List<XFile> videosFiles) onVideosPicked;
  final Function(Object e)? onError;
  /// Not working for now
  final bool isMultiVideos;

  PickViedoDialog({
    Key? key,
    required this.onVideosPicked,
    this.onError,
    this.isMultiVideos = true,
  }) : super(key: key);

  ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.3.sh,
      width: 0.5.sw,
      child: Column(
        children: [
          Gaps.vGap32,
          Text(
            "Pick a Video",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 50.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(
            color: Theme.of(context).colorScheme.secondary,
            thickness: 2,
            height: 100.h,
          ),
          Column(
            children: [
              /// Gallery
              CustomListTile(
                padding: EdgeInsetsDirectional.only(
                  start: 20.w,
                ),
                leading: SizedBox(
                  height: 70.h,
                  width: 70.h,
                  child: SvgPicture.asset(
                    AppConstants.SVG_IMAGE_FILL,
                  ),
                ),
                title: Text(
                  "Gallery",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 45.sp,
                  ),
                ),
                onTap: () async {
                  _pickVideo(ImageSource.gallery);
                },
              ),
              Divider(
                color: Theme.of(context).colorScheme.secondary,
                thickness: 1,
                height: 30.h,
              ),

              /// Camera
              CustomListTile(
                padding: EdgeInsetsDirectional.only(
                  start: 20.w,
                ),
                leading: SizedBox(
                  height: 70.h,
                  width: 70.h,
                  child: SvgPicture.asset(AppConstants.SVG_CAMERA_FILL),
                ),
                title: Text(
                  "Camera",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 45.sp,
                  ),
                ),
                onTap: () async {
                  await _pickVideo(ImageSource.camera);
                },
              ),
              Divider(
                color: Theme.of(context).colorScheme.secondary,
                thickness: 1,
                height: 30.h,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Methods
  Future<void> _pickVideo(ImageSource source) async {
    if (source == ImageSource.gallery) {
      final status = await requestPhotosPermission();
      if (status == PermissionStatus.granted) await _pickVideoFromGallery();
    }
    if (source == ImageSource.camera) {
      final status = await requestCameraPermission();
      if (status == PermissionStatus.granted) await _pickVideoFromCamera();
    }
  }

  Future<void> _pickVideoFromGallery() async {
    try {
      List<XFile> videos = [];
      if (false && isMultiVideos) {
        // videos = await picker.pickMultiVideo(
        //       imageQuality: imageQuality,
        //     ) ??
        //     [];
      } else {
        final video = await picker.pickVideo(
          source: ImageSource.gallery,
        );
        if (video != null) videos.add(video);
      }
      onVideosPicked(videos);
    } catch (e) {
      onError?.call(e);
    }
  }

  Future<void> _pickVideoFromCamera() async {
    try {
      List<XFile> videos = [];

      final video = await picker.pickVideo(
        source: ImageSource.camera,
      );
      if (video != null) videos.add(video);

      onVideosPicked(videos);
    } catch (e) {
      onError?.call(e);
    }
  }
}
