import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:starter_application/core/common/permissions_utils.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';

class QrCodeScanWidget extends StatefulWidget {
  final Function(String? code)? onQrCodeScanned;
  final double? indicatorVerticalPadding;

  QrCodeScanWidget({
    Key? key,
    this.onQrCodeScanned,
    this.indicatorVerticalPadding,
  }) : super(key: key);

  @override
  State<QrCodeScanWidget> createState() => _QrCodeScanWidgetState();
}

class _QrCodeScanWidgetState extends State<QrCodeScanWidget> {
  MobileScannerController? scanController;
  int status = 0;

  @override
  void initState() {
    super.initState();
    getCameraPermission();
  }

  @override
  Widget build(BuildContext context) {
    return _buildScanQrCode();
  }

  Widget _buildScanQrCode() {
    if (scanController == null){
      if(status == 0){
        return WaitingWidget();
      }
      else{
        return IconButton(onPressed: ()async{
          setState(() {
            status = 0;
          });
          getCameraPermission();
        }, icon: Icon(Icons.refresh , size: 60,));
      }
    };
    return Stack(
      children: [
        MobileScanner(
          controller: scanController,
          onDetect: (barcode) {
            final String? code = barcode.barcodes.first.rawValue;
            widget.onQrCodeScanned?.call(code);
          },
        ),
        Positioned.fill(
          top: widget.indicatorVerticalPadding ?? 50.h,
          bottom: widget.indicatorVerticalPadding ?? 50.h,
          child: SvgPicture.asset(
            AppConstants.SVG_QR_CODE_SCAN,
          ),
        )
      ],
    );
  }

  Future<void> getCameraPermission() async {
    if(Platform.isIOS){
      await requestCameraPermission();
      setState(() {
        scanController = MobileScannerController(
          facing: CameraFacing.back,
          torchEnabled: false,
        );
      });
      await Future.delayed(Duration(milliseconds: 2000));
      if (!await Permission.camera.isGranted) {
        await openAppSettings();
      }
      if(await Permission.camera.isGranted){
        setState(() {
          scanController = MobileScannerController(
            facing: CameraFacing.back,
            torchEnabled: false,
          );
        });
      }
      else{
        setState(() {
          status = 1;
        });
      }
    }
    else{
      var cameraPermissionGranted = await requestCameraPermission();
      print(cameraPermissionGranted);
      if (cameraPermissionGranted.isPermanentlyDenied) {
        await openAppSettings();
      }
      cameraPermissionGranted = await requestCameraPermission();
      if(cameraPermissionGranted.isGranted){
        setState(() {
          scanController = MobileScannerController(
            facing: CameraFacing.back,
            torchEnabled: false,
          );
        });
      }
      else{
        setState(() {
          status = 1;
        });
      }
    }

  }
}