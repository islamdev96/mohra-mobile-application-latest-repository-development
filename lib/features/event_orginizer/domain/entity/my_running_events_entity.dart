// To parse this JSON data, do
//
//     final myRunningEvents = myRunningEventsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart';
import 'dart:convert';

import '../../../../core/entities/base_entity.dart';

  class MyRunningEventsEntity extends BaseEntity{
  MyRunningEventsEntity({
    required this.totalCount,
    required this.items,
  });

    final int totalCount;
  final List<EventItemEntity> items;

  @override
  List<Object?> get props => [];


}

class EventItemEntity extends BaseEntity{
  EventItemEntity({
    required this.schedules,
    required this.arTitle,
    required this.enTitle,
    required this.title,
    required this.organizerId,
    required this.mainPicture,
    required this.categoryId,
    required this.categoryName,
    required this.arDescription,
    required this.enDescription,
    required this.description,
    required this.likesCount,
    required this.commentsCount,
    required this.createdBy,
    required this.creatorUserId,
    required this.creationTime,
    required this.startDate,
    required this.endDate,
    required this.fromHour,
    required this.toHour,
    required this.parentId,
    required this.feesType,
    required this.repeat,
    required this.ticketsCount,
    required this.buyingMethod,
    required this.status,
    required this.hideComments,
    required this.totalSeats,
    required this.bookedSeats,
    required this.availableSeats,
    required this.cityId,
    required this.cityName,
    required this.latitude,
    required this.longitude,
    required this.placeName,
    required this.arAbout,
    required this.enAbout,
    required this.about,
    required this.isFeatured,
    required this.tags,
    required this.tickets,
    required this.gallery,
    required this.silverTicketPrice,
    required this.goldenTicketPrice,
    required this.platinumTicketPrice,
    required this.vipTicketPrice,
    required this.price,
    required this.isRefundable,
    required this.isLiked,
    required this.clients,
    required this.organizer,
    required this.scannedTicketsNum,
    required this.eventType,
    required this.invitationCode,
    required this.enGoldenTicketDescription,
    required this.enSilverTicketDescription,
    required this.enPlatinumTicketDescription,
    required this.enVipTicketDescription,
    required this.arGoldenTicketDescription,
    required this.arSilverTicketDescription,
    required this.arPlatinumTicketDescription,
    required this.arVipTicketDescription,
    required this.link,
    required this.value,
    required this.text,
    required this.id,
  });

  final List<EventItemEntity> schedules;
  final String? arTitle;
  final String? enTitle;
  final String? title;
  final int? organizerId;
  final String? mainPicture;
  final int? categoryId;
  final String? categoryName;
  final String? arDescription;
  final String? enDescription;
  final String? description;
  final int? likesCount;
  final int? commentsCount;
  final dynamic createdBy;
  final int? creatorUserId;
  final DateTime creationTime;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime fromHour;
  final DateTime toHour;
  final int? parentId;
  final int? feesType;
  final int? repeat;
  final int? ticketsCount;
  final int? buyingMethod;
  final int? status;
  final bool hideComments;
  final int? totalSeats;
  final int? bookedSeats;
  final int? availableSeats;
  final int? cityId;
  final String? cityName;
  final double? latitude;
  final double? longitude;
  final String? placeName;
  final String? arAbout;
  final String? enAbout;
  final String? about;
  final bool isFeatured;
  final List<String?> tags;
  final List<dynamic> tickets;
  final List<dynamic> gallery;
  final double? silverTicketPrice;
  final double? goldenTicketPrice;
  final double? platinumTicketPrice;
  final double? vipTicketPrice;
  final double? price;
  final bool isRefundable;
  final bool isLiked;
  final List<ClientAttEntity> clients;
  final OrganizerEntity organizer;
  final int? scannedTicketsNum;
  final int? eventType;
  final String? invitationCode;
  final String? enGoldenTicketDescription;
  final String? enSilverTicketDescription;
  final dynamic enPlatinumTicketDescription;
  final dynamic enVipTicketDescription;
  final String? arGoldenTicketDescription;
  final String? arSilverTicketDescription;
  final dynamic arPlatinumTicketDescription;
  final dynamic arVipTicketDescription;
  final String? link;
  final String? value;
  final String? text;
  final int id;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  factory EventItemEntity.fromJson(Map<String, dynamic> json) => EventItemEntity(
    schedules: List<EventItemEntity>.from(
        json["schedules"].map((x) => EventItemEntity.fromJson(x))),
    arTitle: json["arTitle"],
    enTitle: json["enTitle"],
    title: json["title"],
    organizerId: json["organizerId"],
    mainPicture: json["mainPicture"],
    categoryId: json["categoryId"],
    categoryName: json["categoryName"],
    arDescription: json["arDescription"],
    enDescription: json["enDescription"],
    description: json["description"],
    likesCount: json["likesCount"],
    commentsCount: json["commentsCount"],
    createdBy: json["createdBy"],
    creatorUserId: json["creatorUserId"],
    creationTime: DateTime.parse(json["creationTime"]),
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    fromHour: DateTime.parse(json["fromHour"]),
    toHour: DateTime.parse(json["toHour"]),
    parentId: json["parentId"],
    feesType: json["feesType"],
    repeat: json["repeat"],
    ticketsCount: json["ticketsCount"],
    buyingMethod: json["buyingMethod"],
    status: json["status"],
    hideComments: json["hideComments"],
    totalSeats: json["totalSeats"],
    bookedSeats: json["bookedSeats"],
    availableSeats: json["availableSeats"],
    cityId: json["cityId"],
    cityName: json["cityName"],
    latitude: json["latitude"]!=null?json["latitude"].toDouble():null,
    longitude: json["longitude"]!=null?json["longitude"].toDouble():null,
    placeName: json["placeName"],
    arAbout: json["arAbout"],
    enAbout: json["enAbout"],
    about: json["about"],
    isFeatured: json["isFeatured"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    tickets: List<dynamic>.from(json["tickets"].map((x) => x)),
    gallery: List<dynamic>.from(json["gallery"].map((x) => x)),
    silverTicketPrice: json["silverTicketPrice"]!=null?json["silverTicketPrice"].toDouble():null,
    goldenTicketPrice: json["goldenTicketPrice"]!=null?json["goldenTicketPrice"].toDouble():null,
    platinumTicketPrice: json["platinumTicketPrice"]!=null?json["platinumTicketPrice"].toDouble():null,
    vipTicketPrice: json["vipTicketPrice"]!=null?json["vipTicketPrice"].toDouble():null,
    price: json["price"]!=null?json["price"].toDouble():null,
    isRefundable: json["isRefundable"],
    isLiked: json["isLiked"],
    clients: List<ClientAttEntity>.from(
        json["clients"].map((x) => ClientAttEntity.fromJson(x))),
    organizer: OrganizerEntity.fromJson(json["organizer"]),
    scannedTicketsNum: json["scannedTicketsNum"],
    eventType: json["eventType"],
    invitationCode: json["invitationCode"],
    enGoldenTicketDescription: json["enGoldenTicketDescription"],
    enSilverTicketDescription: json["enSilverTicketDescription"],
    enPlatinumTicketDescription: json["enPlatinumTicketDescription"],
    enVipTicketDescription: json["enVIPTicketDescription"],
    arGoldenTicketDescription: json["arGoldenTicketDescription"],
    arSilverTicketDescription: json["arSilverTicketDescription"],
    arPlatinumTicketDescription: json["arPlatinumTicketDescription"],
    arVipTicketDescription: json["arVIPTicketDescription"],
    link: json["link"],
    value: json["value"],
    text: json["text"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "schedules": List<dynamic>.from(schedules.map((x) => x.toJson())),
    "arTitle": arTitle,
    "enTitle": enTitle,
    "title": title,
    "organizerId": organizerId,
    "mainPicture": mainPicture,
    "categoryId": categoryId,
    "categoryName": categoryName,
    "arDescription": arDescription,
    "enDescription": enDescription,
    "description": description,
    "likesCount": likesCount,
    "commentsCount": commentsCount,
    "createdBy": createdBy,
    "creatorUserId": creatorUserId,
    "creationTime": creationTime.toIso8601String(),
    "startDate": startDate.toIso8601String(),
    "endDate": endDate.toIso8601String(),
    "fromHour": fromHour.toIso8601String(),
    "toHour": toHour.toIso8601String(),
    "parentId": parentId,
    "feesType": feesType,
    "repeat": repeat,
    "ticketsCount": ticketsCount,
    "buyingMethod": buyingMethod,
    "status": status,
    "hideComments": hideComments,
    "totalSeats": totalSeats,
    "bookedSeats": bookedSeats,
    "availableSeats": availableSeats,
    "cityId": cityId,
    "cityName": cityName,
    "latitude": latitude,
    "longitude": longitude,
    "placeName": placeName,
    "arAbout": arAbout,
    "enAbout": enAbout,
    "about": about,
    "isFeatured": isFeatured,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "tickets": List<dynamic>.from(tickets.map((x) => x)),
    "gallery": List<dynamic>.from(gallery.map((x) => x)),
    "silverTicketPrice": silverTicketPrice,
    "goldenTicketPrice": goldenTicketPrice,
    "platinumTicketPrice": platinumTicketPrice,
    "vipTicketPrice": vipTicketPrice,
    "price": price,
    "isRefundable": isRefundable,
    "isLiked": isLiked,
    "clients": List<dynamic>.from(clients.map((x) => x.toJson())),
    "organizer": organizer.toJson(),
    "scannedTicketsNum": scannedTicketsNum,
    "eventType": eventType,
    "invitationCode": invitationCode,
    "enGoldenTicketDescription": enGoldenTicketDescription,
    "enSilverTicketDescription": enSilverTicketDescription,
    "enPlatinumTicketDescription": enPlatinumTicketDescription,
    "enVIPTicketDescription": enVipTicketDescription,
    "arGoldenTicketDescription": arGoldenTicketDescription,
    "arSilverTicketDescription": arSilverTicketDescription,
    "arPlatinumTicketDescription": arPlatinumTicketDescription,
    "arVIPTicketDescription": arVipTicketDescription,
    "link": link,
    "value": value,
    "text": text,
    "id": id,
  };

}



class ClientAttEntity extends BaseEntity{
  ClientAttEntity({
    required this.imageUrl,
    required this.fullName,
    required this.name,
    required this.surname,
    required this.phoneNumber,
    required this.emailAddress,
    required this.points,
    required this.isFriend,
    required this.isEmailConfirmed,
    required this.isPhoneNumberConfirmed,
    required this.id,
  });

  final String? imageUrl;
  final String? fullName;
  final String? name;
  final String? surname;
  final String? phoneNumber;
  final String? emailAddress;
  final int? points;
  final bool isFriend;
  final bool isEmailConfirmed;
  final bool isPhoneNumberConfirmed;
  final int id;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  factory ClientAttEntity.fromJson(Map<String, dynamic> json) => ClientAttEntity(
    imageUrl: json["imageUrl"],
    fullName: json["fullName"],
    name: json["name"],
    surname: json["surname"],
    phoneNumber: json["phoneNumber"],
    emailAddress: json["emailAddress"],
    points: json["points"],
    isFriend: json["isFriend"],
    isEmailConfirmed: json["isEmailConfirmed"],
    isPhoneNumberConfirmed: json["isPhoneNumberConfirmed"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "imageUrl": imageUrl,
    "fullName": fullName,
    "name": name,
    "surname": surname,
    "phoneNumber": phoneNumber,
    "emailAddress": emailAddress,
    "points": points,
    "isFriend": isFriend,
    "isEmailConfirmed": isEmailConfirmed,
    "isPhoneNumberConfirmed": isPhoneNumberConfirmed,
    "id": id,
  };

}

class OrganizerEntity extends BaseEntity{
  OrganizerEntity({
    required this.licenseUrl,
    required this.bankId,
    required this.accountNumber,
    required this.companyWebsite,
    required this.imageUrl,
    required this.isLive,
    required this.name,
    required this.surname,
    required this.phoneNumber,
    required this.emailAddress,
    required this.countryCode,
    required this.bankName,
    required this.userName,
    required this.registrationDate,
    required this.isActive,
    required this.id,
  });

  final dynamic licenseUrl;
  final int? bankId;
  final String? accountNumber;
  final String? companyWebsite;
  final String? imageUrl;
  final bool isLive;
  final String? name;
  final String? surname;
  final String? phoneNumber;
  final String? emailAddress;
  final String? countryCode;
  final dynamic bankName;
  final String? userName;
  final DateTime registrationDate;
  final bool isActive;
  final int id;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  factory OrganizerEntity.fromJson(Map<String, dynamic> json) => OrganizerEntity(
    licenseUrl: json["licenseUrl"],
    bankId: json["bankId"],
    accountNumber: json["accountNumber"],
    companyWebsite: json["companyWebsite"],
    imageUrl: json["imageUrl"],
    isLive: json["isLive"],
    name: json["name"],
    surname: json["surname"],
    phoneNumber: json["phoneNumber"],
    emailAddress: json["emailAddress"],
    countryCode: json["countryCode"],
    bankName: json["bankName"],
    userName: json["userName"],
    registrationDate: DateTime.parse(json["registrationDate"]),
    isActive: json["isActive"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "licenseUrl": licenseUrl,
    "bankId": bankId,
    "accountNumber": accountNumber,
    "companyWebsite": companyWebsite,
    "imageUrl": imageUrl,
    "isLive": isLive,
    "name": name,
    "surname": surname,
    "phoneNumber": phoneNumber,
    "emailAddress": emailAddress,
    "countryCode": countryCode,
    "bankName": bankName,
    "userName": userName,
    "registrationDate": registrationDate.toIso8601String(),
    "isActive": isActive,
    "id": id,
  };

}


