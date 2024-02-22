import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scan/scan.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/permissions_utils.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/system_type.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:dotted_border/dotted_border.dart';
class QrFromFileWidget extends StatefulWidget {
  final Function(String? code)? onQrCodeScanned;
  const QrFromFileWidget({Key? key , this.onQrCodeScanned}) : super(key: key);

  @override
  State<QrFromFileWidget> createState() => _QrFromFileWidgetState();
}

class _QrFromFileWidgetState extends State<QrFromFileWidget> {
  XFile? pickedImage;
  ImagePicker picker = ImagePicker();
  bool imagePicked = false;
  bool retry = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 40.h, left: 40.w, right: 40.w),
            child: Container(
              height: 0.5.sh,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Text(
                      "Pick Image and add friends",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 55.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  buildPickImageWidget(),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 40.h, left: 40.w, right: 40.w),
            child: Container(
                height: 150.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 100.h,
                        width: 100.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: SvgPicture.asset(
                          AppConstants.SVG_lampQR,
                        ),
                      ),
                      Text(
                        Translation.current.show_qr_code_message,
                        style: TextStyle(color: Colors.white),
                      )
                    ])),
          ),
        ],
      ),
    );
  }

  buildPickImageWidget() {
    return InkWell(
      onTap: (){
        _pickImage().then((value) async {
          if(pickedImage != null){
            setState(() {

            });
            if(imagePicked){
              String? result = await Scan.parse(pickedImage!.path);
              print("imagePickedd");
              if(result != null){
                widget.onQrCodeScanned?.call(result);
              }
            }
          }
        });
      },
      child: Container(
        height: 0.4.sh,
        width: 0.8.sw,
        child: DottedBorder(
          color: AppColors.black,
          strokeWidth: 1,
            dashPattern: [30, 30],
          child: Center(
            child: pickedImage != null
                ? Image.file(File(pickedImage!.path))
                : Icon(
                    Icons.camera_alt_outlined,
                    size: 0.2.sw,
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    if (AppConfig().os == SystemType.IOS) {
      final status = await requestPhotosPermission();
      imagePicked = await _pickImageFromGallery();

    } else {
      final status = await requestPhotosPermission();
      if (status == PermissionStatus.granted)
        imagePicked = await _pickImageFromGallery();
    }
    if (imagePicked) {
      print("imagePicked");
      setState(() {});
    }
  }

  Future<bool> _pickImageFromGallery() async {
    try {
      final ImagePicker _picker = ImagePicker();
      // Pick an image
      final XFile? image1 = await _picker.pickImage(source: ImageSource.gallery);
      /*final image = await picker.pickImage(
        source: ImageSource.gallery,
      );*/
      print(image1!.name);
      pickedImage = image1;
      if (image1 != null) {
        print(image1.name);
        return true;
      }
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}


