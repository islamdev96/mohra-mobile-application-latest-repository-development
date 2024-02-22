import 'dart:convert';

import 'package:starter_application/core/params/base_params.dart';

class ScanTicketQrCodeParam extends BaseParams {
  final String qrCode;
  final int eventId;
  ScanTicketQrCodeParam({
    required this.qrCode,
    required this.eventId,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'qrCode': qrCode,
      'eventId': eventId,
    };
  }


}
