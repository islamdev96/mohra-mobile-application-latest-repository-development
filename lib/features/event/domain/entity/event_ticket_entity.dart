import 'package:screenshot/screenshot.dart';
import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/event/domain/entity/event_entity.dart';

import 'event_client_entity.dart';

class EventTicketEntity extends BaseEntity {
  EventTicketEntity({
    required this.number,
    required this.name,
    required this.phoneNumber,
    required this.emailAddress,
    this.clientId,
    this.client,
    this.eventId,
    this.event,
    this.type,
    this.date,
    this.price,
    required this.bookingId,
    required this.qrCode,
    this.id,
    required this.scanned,
  });

  final String number;
  final String name;
  final String phoneNumber;
  final String emailAddress;
  final int? clientId;
  final EventClientEntity? client;
  final int? eventId;
  final double? price;
  final EventEntity? event;
  final int? type;
  final DateTime? date;
  final String bookingId;
  final String qrCode;
  final int? id;
  final bool scanned;
  final ScreenshotController screenShotController = ScreenshotController();
  @override
  List<Object?> get props => [];
}
