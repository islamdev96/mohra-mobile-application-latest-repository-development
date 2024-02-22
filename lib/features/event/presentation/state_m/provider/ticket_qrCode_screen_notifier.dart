import 'package:flutter/material.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/features/event/data/model/request/scan_ticket_qr_code_param.dart';
import 'package:starter_application/features/event/presentation/state_m/cubit/event_cubit.dart';

import '../../../../../core/navigation/nav.dart';

class TicketQrCodeScreenNotifier extends ScreenNotifier {
  late BuildContext context;
  final EventCubit scanQrcodeTicket = EventCubit();
  bool isComplete = false;

  @override
  void closeNotifier() {
    scanQrcodeTicket.close();
    this.dispose();
  }

  changeProgress(bool value) {
    isComplete = value;
    notifyListeners();
  }

  onQrCodeScanned(String? scannedQrCode, int? eventId) {
    if (scannedQrCode != null) {
      try {
        if (!isComplete) {
          changeProgress(true);
          scanQrcodeTicket.scanTicketQrCode(ScanTicketQrCodeParam(
              qrCode: scannedQrCode, eventId: eventId ?? 0));
          print("Now");
        }
      } catch (e) {}
    }
  }
}
