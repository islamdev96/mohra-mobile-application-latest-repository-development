import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/dialogs/pick_image_dialog.dart';

class PickImage extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final List<String> imagesPaths;
  final Function(List<XFile> imagesFiles) onImagesPicked;
  final String? cameraButtonIcon;
  final Color? cameraButtonColor;
  final Color? cameraButtonBackgroundColor;

  const PickImage({
    Key? key,
    required this.onImagesPicked,
    this.imagesPaths = const [],
    this.shrinkWrap = false,
    this.padding,
    this.physics,
    this.cameraButtonIcon,
    this.cameraButtonColor,
    this.cameraButtonBackgroundColor,
  }) : super(key: key);

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  int get itemsCount => widget.imagesPaths.length;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (itemsCount > 0)
          _customContainer(
            child: Image.file(
              File(widget.imagesPaths[0]),
              fit: BoxFit.cover,
            ),
          ),
        _customContainer(
          child: InkWell(
            onTap: () {
              showPickImageDialog(onImagesPicked: (images) async {
                await widget.onImagesPicked.call(images);
                Nav.pop();
              }, context: context);
            },
            child: Center(
              child: SizedBox(
                height: 80.h,
                width: 80.h,
                child: SvgPicture.asset(
                  widget.cameraButtonIcon ?? AppConstants.SVG_CAMERA,
                  color:
                      widget.cameraButtonColor ?? AppColors.primaryColorLight,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _customContainer({Widget? child}) {
    return Container(
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
          child: child),
    );
  }
}
