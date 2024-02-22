import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/custom_file_type.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/dialogs/pick_file_dialog.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/features/moment/presentation/widget/post_card.dart';

import 'video_widget.dart';

class PickFilesGrid extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final List<String> filesPaths;
  final Function(List<String> paths) onFilesPicked;
  final Function(List<String> paths) onFileDeleted;

  //Todo onFileDeleted
  final String? cameraButtonIcon;
  final Color? cameraButtonColor;
  final Color? cameraButtonBackgroundColor;
  final int? imageQuality;
  final bool disable;
  final bool disableDeleteFile;
  final bool allowMultiples;

  const PickFilesGrid({
    Key? key,
    required this.onFilesPicked,
    required this.onFileDeleted,
    this.filesPaths = const [],
    this.shrinkWrap = false,
    this.disable = false,
    this.disableDeleteFile = false,
    this.padding,
    this.physics,
    this.cameraButtonIcon,
    this.cameraButtonColor,
    this.cameraButtonBackgroundColor,
    this.allowMultiples = false,
    this.imageQuality,
  }) : super(key: key);

  @override
  State<PickFilesGrid> createState() => _PickFilesGridState();
}

class _PickFilesGridState extends State<PickFilesGrid> {
  int get itemsCount => widget.filesPaths.length + (reachedMax ? 0 : 1);

  bool get reachedMax =>
      widget.allowMultiples ? false : widget.filesPaths.length >= 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _customContainer(
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
        ),
        if (widget.filesPaths.isNotEmpty)
          Expanded(
            child: GridView.builder(
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
                // if (!reachedMax && index == itemsCount - 1) {
                //   return _customContainer(
                //     child: InkWell(
                //       onTap: widget.disable ? null : showPicker,
                //       child: Center(
                //         child: SizedBox(
                //           height: 80.h,
                //           width: 80.h,
                //           child: SvgPicture.asset(
                //             widget.cameraButtonIcon ?? AppConstants.SVG_CAMERA2,
                //             color:
                //                 widget.cameraButtonColor ?? AppColors.primaryColorLight,
                //           ),
                //         ),
                //       ),
                //     ),
                //   );
                // }

                /// Picked files
                // else {
                return _customContainer(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        _viewPickedFile(widget.filesPaths[index]),
                        Positioned(
                          right: 10.w,
                          top: 10.h,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(
                              100.r,
                            )),
                            child: widget.disableDeleteFile
                                ? const SizedBox.shrink()
                                : Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.red),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(
                                        100.r,
                                      )),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          widget.filesPaths.removeAt(index);
                                        });
                                        // widget.onFileDeleted.call(widget.filesPaths);
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

                    /// If maxfilesCount = 1 then first image work as the picker button
                    onTap: widget.disable
                        ? null
                        : index == 0 && widget.allowMultiples
                            ? showPicker
                            : null);
                // }
              },
              itemCount: itemsCount,
            ),
          ),
      ],
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

  Widget _viewPickedFile(String filesPath) {
    final type = getFileType(filesPath);
    if (type == CustomFileType.IMAGE) {
      return filesPath.contains("http")
          ? CustomNetworkImageWidget(
              imgPath: filesPath,
              boxFit: BoxFit.cover,
            )
          : Image.file(
              File(filesPath),
              fit: BoxFit.cover,
            );
    } else if (type == CustomFileType.VIDEO) {
      return Container(
        width: 1000.w,
        child: VideoWidget(
          path: filesPath,
          autoPlay: true,
          loop: true,
        ),
      );
    }
    return Container();
  }

  /// Methods
  void showPicker() async {
    if (widget.disable) return;
    showPickFileDialog(
        onFilesPicked: (files) async {
          await widget.onFilesPicked.call(
            files,
          );
          Nav.pop();
        },
        isMultiFiles: widget.allowMultiples,
        context: context);
  }
}
