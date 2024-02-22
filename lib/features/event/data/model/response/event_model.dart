import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/event/domain/entity/event_entity.dart';

import 'event_client_model.dart';
import 'event_organizer_model.dart';
import 'event_ticket_model.dart';

class EventModel extends BaseModel<EventEntity> {
  EventModel({
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
    required this.goldenTicketDescription,
    required this.silverTicketDescription,
    required this.platinumTicketDescription,
    required this.vipTicketDescription,
    required this.link,
    required this.fromHour,
    required this.toHour,
    this.id,
  });

  final List<SchedulesModel>? schedules;
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
  final List<EventTicketModel> tickets;
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
  final List<EventClientModel> clients;
  final EventOrganizerModel? organizer;
  final int? scannedTicketsNum;
  final int? eventType;
  final String invitationCode;
  final String goldenTicketDescription;
  final String silverTicketDescription;
  final String platinumTicketDescription;
  final String vipTicketDescription;
  final String link;
  final int? id;

  factory EventModel.fromMap(Map<String, dynamic> json) {
    return EventModel(
      schedules: json['schedules'] == null
          ? []
          : List<SchedulesModel>.from(
              json["schedules"].map((x) => SchedulesModel.fromJson(x))),
      arTitle: stringV(json["arTitle"]),
      enTitle: stringV(json["enTitle"]),
      title: stringV(json["title"]),
      organizerId: json["organizerId"] == null ? null : json["organizerId"],
      mainPicture: stringV(json["mainPicture"]),
      categoryId: json["categoryId"] == null ? null : json["categoryId"],
      categoryName: stringV(json["categoryName"]),
      arDescription: stringV(json["arDescription"]),
      enDescription: stringV(json["enDescription"]),
      description: stringV(json["description"]),
      likesCount: json["likesCount"] == null ? null : json["likesCount"],
      commentsCount:
          json["commentsCount"] == null ? null : json["commentsCount"],
      createdBy: stringV(json["createdBy"]),
      creatorUserId:
          json["creatorUserId"] == null ? null : json["creatorUserId"],
      creationTime: json["creationTime"] == null
          ? null
          : DateTime.parse(json["creationTime"]),
      ticketsCount: json["ticketsCount"] == null ? null : json["ticketsCount"],
      buyingMethod: json["buyingMethod"] == null ? null : json["buyingMethod"],
      status: json["status"] == null ? null : json["status"],
      hideComments: json["hideComments"] ?? true,
      totalSeats: json["totalSeats"] == null ? null : json["totalSeats"],
      bookedSeats: json["bookedSeats"] == null ? null : json["bookedSeats"],
      availableSeats:
          json["availableSeats"] == null ? null : json["availableSeats"],
      goldenTotalSeats:
          json["goldenTotalSeats"] == null ? null : json["goldenTotalSeats"],
      platinumTotalSeats: json["platinumTotalSeats"] == null
          ? null
          : json["platinumTotalSeats"],
      silverTotalSeats:
          json["silverTotalSeats"] == null ? null : json["silverTotalSeats"],
      vipTotalSeats:
          json["vipTotalSeats"] == null ? null : json["vipTotalSeats"],
      cityId: json["cityId"] == null ? null : json["cityId"],
      cityName: stringV(json["cityName"]),
      latitude: json["latitude"] == null ? null : json["latitude"],
      longitude: json["longitude"] == null ? null : json["longitude"],
      placeName: stringV(json["placeName"]),
      arAbout: stringV(json["arAbout"]),
      enAbout: stringV(json["enAbout"]),
      about: stringV(json["about"]),
      isFeatured: json["isFeatured"] ?? false,
      tags: json["tags"] == null
          ? []
          : List<String>.from(json["tags"].map((x) => x)),
      tickets: json["tickets"] == null
          ? []
          : List<EventTicketModel>.from(
              json["tickets"].map((x) => EventTicketModel.fromMap(x))),
      gallery: json["gallery"] == null
          ? []
          : List<String>.from(json["gallery"].map((x) => x)),
      silverTicketPrice:
          json["silverTicketPriceWithTax"] == null ? null : json["silverTicketPriceWithTax"],
      goldenTicketPrice:
          json["goldenTicketPriceWithTax"] == null ? null : json["goldenTicketPriceWithTax"],
      platinumTicketPrice: json["platinumTicketPriceWithTax"] == null
          ? null
          : json["platinumTicketPriceWithTax"],
      vipTicketPrice:
          json["vipTicketPriceWithTax"] == null ? null : json["vipTicketPriceWithTax"],
      price: json["priceWithTax"] == null ? null : json["priceWithTax"],
      isRefundable: json["isRefundable"] ?? true,
      fromDate:
          json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
      toDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
      isLiked: json["isLiked"] ?? false,
      clients: json["clients"] == null
          ? []
          : List<EventClientModel>.from(
              json["clients"].map((x) => EventClientModel.fromMap(x))),
      organizer: json["organizer"] == null
          ? null
          : EventOrganizerModel.fromMap(json["organizer"]),
      scannedTicketsNum:
          json["scannedTicketsNum"] == null ? null : json["scannedTicketsNum"],
      eventType: json["eventType"] == null ? null : json["eventType"],
      invitationCode: stringV(json["invitationCode"]),
      goldenTicketDescription: AppConfig().appLanguage == 'en'
          ? stringV(json["enGoldenTicketDescription"])
          : stringV(json["arGoldenTicketDescription"]),
      silverTicketDescription: AppConfig().appLanguage == 'en'
          ? stringV(json["enSilverTicketDescription"])
          : stringV(json["arSilverTicketDescription"]),
      platinumTicketDescription: AppConfig().appLanguage == 'en'
          ? stringV(json["enPlatinumTicketDescription"])
          : stringV(json["arPlatinumTicketDescription"]),
      vipTicketDescription: AppConfig().appLanguage == 'en'
          ? stringV(json["enVIPTicketDescription"])
          : stringV(json["arVIPTicketDescription"]),
      link: stringV(json["link"]),
      id: json["id"] == null ? null : json["id"],
      fromHour:
          json["fromHour"] == null ? null : DateTime.parse(json["fromHour"]),
      toHour: json["toHour"] == null ? null : DateTime.parse(json["toHour"]),
    );
  }

  Map<String, dynamic> toMap() => {
        "arTitle": arTitle,
        "enTitle": enTitle,
        "title": title,
        "organizerId": organizerId == null ? null : organizerId,
        "mainPicture": mainPicture,
        "categoryId": categoryId == null ? null : categoryId,
        "categoryName": categoryName,
        "arDescription": arDescription,
        "enDescription": enDescription,
        "description": description,
        "likesCount": likesCount == null ? null : likesCount,
        "commentsCount": commentsCount == null ? null : commentsCount,
        "createdBy": createdBy,
        "creatorUserId": creatorUserId == null ? null : creatorUserId,
        "creationTime":
            creationTime == null ? null : creationTime!.toIso8601String(),
        "ticketsCount": ticketsCount == null ? null : ticketsCount,
        "buyingMethod": buyingMethod == null ? null : buyingMethod,
        "status": status == null ? null : status,
        "hideComments": hideComments,
        "totalSeats": totalSeats == null ? null : totalSeats,
        "bookedSeats": bookedSeats == null ? null : bookedSeats,
        "availableSeats": availableSeats == null ? null : availableSeats,
        "cityId": cityId == null ? null : cityId,
        "cityName": cityName,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "placeName": placeName,
        "arAbout": arAbout,
        "enAbout": enAbout,
        "about": about,
        "isFeatured": isFeatured,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "tickets": List<dynamic>.from(tickets.map((x) => x.toMap())),
        "gallery": List<dynamic>.from(gallery.map((x) => x)),
        "silverTicketPrice":
            silverTicketPrice == null ? null : silverTicketPrice,
        "goldenTicketPriceWithTax":
            goldenTicketPrice == null ? null : goldenTicketPrice,
        "PlatinumTicketPriceWithTax":
            platinumTicketPrice == null ? null : platinumTicketPrice,
        "vipTicketPrice": vipTicketPrice == null ? null : vipTicketPrice,
        "priceWithTax": price == null ? null : price,
        "isRefundable": isRefundable,
        "fromDate": fromDate == null ? null : fromDate!.toIso8601String(),
        "toDate": toDate == null ? null : toDate!.toIso8601String(),
        "isLiked": isLiked,
        "clients": List<dynamic>.from(clients.map((x) => x.toMap())),
        "organizer": organizer == null ? null : organizer!.toMap(),
        "scannedTicketsNum":
            scannedTicketsNum == null ? null : scannedTicketsNum,
        "eventType": eventType == null ? null : eventType,
        "invitationCode": invitationCode,
        "goldenTicketDescription": goldenTicketDescription,
        "silverTicketDescription": silverTicketDescription,
        "platinumTicketDescription": platinumTicketDescription,
        "vipTicketDescription": vipTicketDescription,
        "link": link,
        "id": id == null ? null : id,
      };

  @override
  EventEntity toEntity() {
    print(fromDate);
    print(toDate);
    return EventEntity(
      arTitle: arTitle,
      enTitle: enTitle,
      title: title,
      mainPicture: mainPicture,
      categoryName: categoryName,
      arDescription: arDescription,
      enDescription: enDescription,
      description: description,
      createdBy: createdBy,
      hideComments: hideComments,
      cityName: cityName,
      placeName: placeName,
      arAbout: arAbout,
      enAbout: enAbout,
      about: about,
      isFeatured: isFeatured,
      tags: tags,
      tickets: tickets.map((e) => e.toEntity()).toList(),
      gallery: gallery,
      isRefundable: isRefundable,
      isLiked: isLiked,
      clients: clients.map((e) => e.toEntity()).toList(),
      invitationCode: invitationCode,
      goldenTicketDescription: goldenTicketDescription,
      silverTicketDescription: silverTicketDescription,
      platinumTicketDescription: platinumTicketDescription,
      vipTicketDescription: vipTicketDescription,
      link: link,
      id: id,
      availableSeats: availableSeats,
      goldenTotalSeats: goldenTotalSeats,
      silverTotalSeats: silverTotalSeats,
      platinumTotalSeats: platinumTotalSeats,
      vipTotalSeats: vipTotalSeats,
      bookedSeats: bookedSeats,
      buyingMethod: buyingMethod,
      categoryId: categoryId,
      cityId: cityId,
      commentsCount: commentsCount,
      creationTime: creationTime,
      creatorUserId: creatorUserId,
      eventType: eventType,
      fromDate: fromDate,
      goldenTicketPrice: goldenTicketPrice,
      latitude: latitude,
      likesCount: likesCount,
      longitude: longitude,
      organizer: organizer?.toEntity(),
      organizerId: organizerId,
      platinumTicketPrice: platinumTicketPrice,
      price: price,
      scannedTicketsNum: scannedTicketsNum,
      silverTicketPrice: silverTicketPrice,
      status: status,
      ticketsCount: ticketsCount,
      toDate: toDate,
      totalSeats: totalSeats,
      vipTicketPrice: vipTicketPrice,
      fromHour: fromHour,
      toHour: toHour,
      schedules: schedules != null
          ? schedules!.map((e) => e.toEntity()).toList()
          : null,
    );
  }
}

class SchedulesModel extends BaseModel<SchedulesEntity> {
  String? creationTime;
  String? startDate;
  String? endDate;
  String? fromHour;
  String? toHour;
  int? id;

  SchedulesModel(
      {this.creationTime,
      this.startDate,
      this.endDate,
      this.fromHour,
      this.toHour,
      this.id});

  SchedulesModel.fromJson(Map<String, dynamic> json) {
    creationTime = json['creationTime'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    fromHour = json['fromHour'];
    toHour = json['toHour'];
    id = json['id'];
  }

  @override
  SchedulesEntity toEntity() {
    return SchedulesEntity(
        id: id,
        creationTime: creationTime,
        endDate: endDate,
        fromHour: fromHour,
        startDate: startDate,
        toHour: toHour);
  }
}
