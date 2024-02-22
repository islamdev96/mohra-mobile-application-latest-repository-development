import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/dialogs/pick_video_dialog.dart';

/// It doesn't support multi videos for now
/// Need testing
class PickVideosGrid extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final List<String> videoPaths;
  final Function(List<XFile> imagesFiles) onVideosPicked;
  final String? cameraButtonIcon;
  final Color? cameraButtonColor;
  final Color? cameraButtonBackgroundColor;
  final int? maxImagesCount;
  final int? imageQuality;
  final bool disable;
  final bool disableDeleteImage;
  const PickVideosGrid({
    Key? key,
    required this.onVideosPicked,
    this.videoPaths = const [],
    this.shrinkWrap = false,
    this.disable = false,
    this.disableDeleteImage = false,
    this.padding,
    this.physics,
    this.cameraButtonIcon,
    this.cameraButtonColor,
    this.cameraButtonBackgroundColor,
    this.maxImagesCount,
    this.imageQuality,
  }) : super(key: key);

  @override
  State<PickVideosGrid> createState() => _PickVideosGridState();
}

class _PickVideosGridState extends State<PickVideosGrid> {
  int get itemsCount => widget.videoPaths.length + (reachedMax ? 0 : 1);
  bool get reachedMax => widget.maxImagesCount == null
      ? false
      : widget.videoPaths.length == widget.maxImagesCount;
  bool get isMultiVideos => widget.maxImagesCount != 1;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: widget.padding,
      shrinkWrap: widget.shrinkWrap,
      physics: widget.physics,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
        crossAxisSpacing: 20.h,
        mainAxisSpacing: 20.h,
      ),
      itemBuilder: (context, index) {
        /// Pick image icon
        if (!reachedMax && index == itemsCount - 1) {
          return _customContainer(
            child: InkWell(
              onTap: widget.disable ? null : showPicker,
              child: Center(
                child: SizedBox(
                  height: 80.h,
                  width: 80.h,
                  child: SvgPicture.asset(
                    widget.cameraButtonIcon ?? AppConstants.SVG_CAMERA2,
                    color:
                        widget.cameraButtonColor ?? AppColors.primaryColorLight,
                  ),
                ),
              ),
            ),
          );
        }

        /// Picked images
        else {
          return _customContainer(
              child: Stack(
                children: [
                  Container(
                    width: 1000.w,
                    child: widget.videoPaths[index].contains("http")
                        ? Image.network(
                            widget.videoPaths[index],
                            fit: BoxFit.fill,
                          )
                        : Image.file(
                            File(widget.videoPaths[index]),
                            fit: BoxFit.fill,
                          ),
                  ),
                  Positioned(
                    right: 10.w,
                    top: 10.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(
                        100.r,
                      )),
                      child: widget.disableDeleteImage
                          ? const SizedBox.shrink()
                          : Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.all(Radius.circular(
                                  100.r,
                                )),
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    widget.videoPaths.removeAt(index);
                                  });
                                },
                                child: const Icon(
                                  Icons.clear_outlined,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              ),
                            ),
                    ),
                  )
                ],
              ),

              /// If maxImagesCount = 1 then first image work as the picker button
              onTap: widget.disable
                  ? null
                  : index == 0 && widget.maxImagesCount == 1
                      ? showPicker
                      : null);
        }
      },
      itemCount: itemsCount,
    );
  }

  //Todo Enable user to path his own widget and logic
  Widget _customContainer({
    Widget? child,
    VoidCallback? onTap,
  }) {
    return SizedBox(
      height: 200.h,
      width: 200.h,
      child: Stack(
        children: [
          Container(
            height: 200.h,
            width: 200.h,
            decoration: BoxDecoration(
              color: widget.cameraButtonBackgroundColor ??
                  AppColors.mansourLightGreyColor_4,
              borderRadius: BorderRadius.circular(
                30.r,
              ),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  30.r,
                ),
                child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(onTap: onTap, child: child))),
          ),
          IgnorePointer(
            ignoring: true,
            child: Container(
              height: 200.h,
              width: 200.h,
              decoration: BoxDecoration(
                color: widget.disable
                    ? Colors.grey.withOpacity(0.5)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(
                  30.r,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Methods
  void showPicker() {
    if (widget.disable) return;
    showPickVideoDialog(
      onVideosPicked: (Videos) async {
        await widget.onVideosPicked.call(Videos);
        Nav.pop();
      },
      isMultiVideos: isMultiVideos,
    );
  }
}
