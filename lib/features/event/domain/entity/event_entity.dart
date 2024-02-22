import 'package:starter_application/core/entities/base_entity.dart';

import 'event_client_entity.dart';
import 'event_organizer_entity.dart';
import 'event_ticket_entity.dart';

class EventEntity extends BaseEntity {
  EventEntity({
    this.schedules,
    required this.arTitle,
    required this.enTitle,
    required this.title,
    this.organizerId,
    required this.mainPicture,
    this.categoryId,
    required this.categoryName,
    required this.arDescription,
    required this.enDescription,
    required this.description,
    this.likesCount,
    this.commentsCount,
    required this.createdBy,
    this.creatorUserId,
    this.creationTime,
    this.ticketsCount,
    this.buyingMethod,
    this.status,
    required this.hideComments,
    this.totalSeats,
    this.bookedSeats,
    this.availableSeats,
    this.goldenTotalSeats,
    this.silverTotalSeats,
    this.platinumTotalSeats,
    this.vipTotalSeats,
    this.cityId,
    required this.cityName,
    this.latitude,
    this.longitude,
    required this.placeName,
    required this.arAbout,
    required this.enAbout,
    required this.about,
    required this.isFeatured,
    required this.tags,
    required this.tickets,
    required this.gallery,
    this.silverTicketPrice,
    this.goldenTicketPrice,
    this.platinumTicketPrice,
    this.vipTicketPrice,
    this.price,
    required this.isRefundable,
    this.fromDate,
    this.toDate,
    required this.isLiked,
    required this.clients,
    this.organizer,
    this.scannedTicketsNum,
    this.eventType,
    required this.invitationCode,
    required this.toHour,
    required this.fromHour,
    required this.goldenTicketDescription,
    required this.silverTicketDescription,
    required this.platinumTicketDescription,
    required this.vipTicketDescription,
    required this.link,
    this.id,
  });

  final List<SchedulesEntity>? schedules;
  final String arTitle;
  final String enTitle;
  final String title;
  final int? organizerId;
  final String mainPicture;
  final int? categoryId;
  final String categoryName;
  final String arDescription;
  final String enDescription;
  final String description;
  final int? likesCount;
  final int? commentsCount;
  final String createdBy;
  final int? creatorUserId;
  final DateTime? creationTime;
  final int? ticketsCount;
  final int? buyingMethod;
  final int? status;
  final bool hideComments;
  final int? totalSeats;
  final int? bookedSeats;
  final int? availableSeats;
  final int? goldenTotalSeats;
  final int? silverTotalSeats;
  final int? platinumTotalSeats;
  final int? vipTotalSeats;
  final int? cityId;
  final String cityName;
  final double? latitude;
  final double? longitude;
  final String placeName;
  final String arAbout;
  final String enAbout;
  final String about;
  final bool isFeatured;
  final List<String> tags;
  final List<EventTicketEntity> tickets;
  final List<String> gallery;
  final double? silverTicketPrice;
  final double? goldenTicketPrice;
  final double? platinumTicketPrice;
  final double? vipTicketPrice;
  final double? price;
  final bool isRefundable;
  final DateTime? fromDate;
  final DateTime? toDate;
  final DateTime? fromHour;
  final DateTime? toHour;
  final bool isLiked;
  final List<EventClientEntity> clients;
  final EventOrganizerEntity? organizer;
  final int? scannedTicketsNum;
  final int? eventType;
  final String invitationCode;
  final String goldenTicketDescription;
  final String silverTicketDescription;
  final String platinumTicketDescription;
  final String vipTicketDescription;
  final String link;
  final int? id;

  @override
  List<Object?> get props => [id];
}

class SchedulesEntity extends BaseEntity {
  String? creationTime;
  String? startDate;
  String? endDate;
  String? fromHour;
  String? toHour;
  int? id;

  SchedulesEntity(
      {this.creationTime,
      this.startDate,
      this.endDate,
      this.fromHour,
      this.toHour,
      this.id});

  @override
  List<Object?> get props => [id];
}
