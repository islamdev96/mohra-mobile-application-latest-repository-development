import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/dialogs/pick_image_dialog.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_error_snackbar.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';
import 'package:starter_application/generated/l10n.dart';

typedef OnCreatePositive = void Function(
  String title,
  String des,
  XFile image,
);

void showMyLifeBottomSheet({
  required BuildContext context,
  required String title,
  required VoidCallback onPress,
  required List<String> imagesPaths,
  required OnCreatePositive OnAdd,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return BottomSheet(
        builder: (BuildContext context) {
          return AnimatedPadding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            duration: const Duration(milliseconds: 300),
            child: MyLifeBottomSheet(
              onPress: onPress,
              title: title,
              OnCreate: (title, des, image) {
                print(image);
                OnAdd(title, des, image);
              },
            ),
          );
        },
        onClosing: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
              40.r,
            ),
          ),
        ),
        constraints: BoxConstraints(
          maxHeight: 1.sh,
        ),
      );
    },
    isScrollControlled: true,
    isDismissible: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(
          40.r,
        ),
      ),
    ),
    constraints: BoxConstraints(
      maxHeight: 1.sh,
    ),
  );
}

class MyLifeBottomSheet extends StatefulWidget {
  final VoidCallback onPress;
  final String title;
  final OnCreatePositive OnCreate;

  const MyLifeBottomSheet({
    Key? key,
    required this.onPress,
    required this.OnCreate,
    required this.title,
  }) : super(key: key);

  @override
  State<MyLifeBottomSheet> createState() => _MyLifeBottomSheetState();
}

class _MyLifeBottomSheetState extends State<MyLifeBottomSheet> {
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  String? image;
  List<String> imagesPaths = [];
  List<XFile> _imagesFiles = [];

  final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      20.r,
    ),
    borderSide: BorderSide(
      color: Colors.grey[200]!,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5.sh,
      padding: EdgeInsets.only(
        left: 70.h,
        right: 70.h,
        top: 70.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            40.r,
          ),
        ),
      ),
      child: Column(
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
                widget.title,
                style: TextStyle(
                    fontSize: 45.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black_text),
              ),
              Gaps.hGap64,
            ],
          ),
          Gaps.vGap64,
          Row(
            children: [
              if (imagesPaths.isNotEmpty)
                CircleAvatar(
                  backgroundImage: new FileImage(File(imagesPaths[0])),
                ),
              Gaps.hGap15,
              SizedBox(
                height: 80.h,
                width: 80.h,
                child: InkWell(
                  onTap: () {
                    showPickImageDialog(isCircle: true,onImagesPicked: (images) {
                      onImagesPicked.call(images);
                      _imagesFiles = images;

                      Nav.pop();
                    }, context: context);
                  },
                  child: SvgPicture.asset(
                    AppConstants.SVG_CAMERA,
                    color: AppColors.primaryColorLight,
                  ),
                ),
              ),
              Gaps.hGap32,
              Expanded(
                child: TextFormField(
                  controller: title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black_text,
                      fontSize: 45.sp),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[200]!),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[200]!),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[200]!),
                    ),
                  ),
                  inputFormatters: [],
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          Gaps.vGap128,
          Expanded(
            child: Container(
              child: CustomTextField(
                controller: desc,
                border: _border,
                errorBorder: _border,
                enabledBorder: _border,
                disabledBorder: _border,
                focusedBorder: _border,
                filled: true,
                fillColor: Colors.white,
                labelStyle: const TextStyle(color: AppColors.textLight2),
                primaryFieldColor: AppColors.textLight2,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.multiline,
                focusNode: FocusNode(),
                minLines: 4,
                maxLines: 9,
                hintText: Translation.current.positivity_desc_hint,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 50.w, vertical: 40.h),
                horizontalMargin: 0.w,
                validator: (value) {},
                onFieldSubmitted: (term) {},
                onChanged: (value) {},
              ),
            ),
          ),
          CustomMansourButton(
            titleText: Translation.of(context).add_positivity,
            titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 45.sp),
            textColor: AppColors.lightFontColor,
            onPressed: () {
              if (imagesPaths.isEmpty) {
                // showErrorSnackBar(message: Translation.current.image_required);
                showPickImageDialog(isCircle: true,onImagesPicked: (images) {
                  onImagesPicked.call(images);
                  _imagesFiles = images;
                  Nav.pop();
                }, context: context);
              } else if (imagesPaths.last.isNotEmpty &&
                  title.text != "" &&
                  desc.text != "") {
                widget.OnCreate(title.text, desc.text, _imagesFiles.last);
              } else {
                showErrorSnackBar(
                    message: Translation.current.all_fields_required);
              }
            },
          ),
          Gaps.vGap64,
        ],
      ),
    );
  }

  void onImagesPicked(List<XFile> imagesFiles) {
    setState(() {});
    imagesPaths.clear();
    _imagesFiles.addAll(imagesFiles);
    imagesPaths.add(_imagesFiles.last.path);
    setState(() {});
  }

  Widget _customContainer({Widget? child}) {
    return Container(
      height: 100.h,
      width: 100.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }
}
