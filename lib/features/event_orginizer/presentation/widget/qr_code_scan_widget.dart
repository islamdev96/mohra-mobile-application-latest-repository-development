import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/permissions_utils.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/dialogs/custom_dialogs.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/generated/l10n.dart';

class QrCodeScanEventWidget extends StatefulWidget {
  final Function(String? code,int? eventId)? onQrCodeScanned;
  final int? eventId;
  final double? indicatorVerticalPadding;

  QrCodeScanEventWidget({
    Key? key,
    this.onQrCodeScanned,
    this.eventId,
    this.indicatorVerticalPadding,
  }) : super(key: key);

  @override
  State<QrCodeScanEventWidget> createState() => _QrCodeScanEventWidgetState();
}

class _QrCodeScanEventWidgetState extends State<QrCodeScanEventWidget> {
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
        return Center(
          child: IconButton(onPressed: ()async{
            await getCameraPermission();
          }, icon: Icon(Icons.refresh , size: 60,)),
        );
      }
    };
    return Stack(
      children: [
        MobileScanner(
          controller: scanController,
          onDetect: (barcode) {
            final String? code = barcode.barcodes.first.rawValue;
            widget.onQrCodeScanned?.call(code,widget.eventId);
          },
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 0.1.sw),
            child: Image.asset(
              AppConstants.Qr,
              width: 1.sw,
              height: 0.7.sw,
              fit: BoxFit.fill,
            ),
          ),
        )
      ],
    );
  }

  Future<void> getCameraPermission() async {
      var cameraPermissionGranted = await requestCameraPermission();
      if (cameraPermissionGranted.isPermanentlyDenied) {
        showCustomConfirmCancelDialog(
            mainContext: AppConfig().appContext,
            isDismissible: true,
            cancelText: Translation.current.back,
            title: Translation.of(AppConfig().appContext).errorOccurred,
            content: Translation.current.Could_not_get_your_camera,
            confirmText: Translation.current.Open_settings,
            onConfirm: (_) async {
              await openAppSettings();
                Nav.pop();
            },
            onCancel: (_) {
              Nav.pop();
              Nav.pop();
            });
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