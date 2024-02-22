import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/dialogs/pick_image_dialog.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/toast/errv_toast_options.dart';

class PickImagesGrid extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final List<String> imagesPaths;
  final Function(List<XFile> imagesFiles) onImagesPicked;
  final Function(int index)? onImageDeleted;
  final String? cameraButtonIcon;
  final Color? cameraButtonColor;
  final Color? cameraButtonBackgroundColor;
  final int? maxImagesCount;
  final int? imageQuality;
  final bool disable;
  final bool disableDeleteImage;
  final String? disableMessage;

  const PickImagesGrid(
      {Key? key,
      required this.onImagesPicked,
      required this.onImageDeleted,
      this.imagesPaths = const [],
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
      this.disableMessage})
      : super(key: key);

  @override
  State<PickImagesGrid> createState() => _PickImagesGridState();
}

class _PickImagesGridState extends State<PickImagesGrid> {
  int get itemsCount => widget.imagesPaths.length + (reachedMax ? 0 : 1);

  bool get reachedMax => widget.maxImagesCount == null
      ? false
      : widget.imagesPaths.length == widget.maxImagesCount;

  bool get issMultiImages => widget.maxImagesCount != 1;

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
              onTap: widget.disable ? showDisableMessage : showPicker,
              child: Center(
                child: SizedBox(
                  // height: 80.h,
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
                    height: 1000.h,
                    child: widget.imagesPaths[index].contains("http")
                        ? Image.network(
                            widget.imagesPaths[index],
                            fit: BoxFit.fill,
                          )
                        : Image.file(
                            File(widget.imagesPaths[index]),
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
                                  widget.onImageDeleted?.call(index);
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
                  ? showDisableMessage
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
    showPickImageDialog(
      onImagesPicked: (images) async {
        await widget.onImagesPicked.call(images);
        Nav.pop();
      },
      isMultiImages: issMultiImages,
      imageQuality: widget.imageQuality,
      context: context
    );
  }

  showDisableMessage() {
    if (widget.disableMessage == null) return;
    ErrorViewer.showCustomError(context, widget.disableMessage!,
        errorViewerOptions: const ErrVToastOptions());
  }



}
