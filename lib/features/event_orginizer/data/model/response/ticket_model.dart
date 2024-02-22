// To parse this JSON data, do
//
//     final tickets = ticketsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TicketsModel ticketsFromJson(String str) => TicketsModel.fromJson(json.decode(str));

String ticketsToJson(TicketsModel data) => json.encode(data.toJson());



class TicketsModel {
  TicketsModel({
    required this.totalCount,
    required this.items,
  });

  final int totalCount;
  final List<TicketItemModel> items;

  factory TicketsModel.fromJson(Map<String, dynamic> json) => TicketsModel(
    totalCount: json["totalCount"],
    items: List<TicketItemModel>.from(json["items"].map((x) => TicketItemModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class EventModel {
  EventModel({
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

  final List<dynamic> schedules;
  final String arTitle;
  final String enTitle;
  final String title;
  final int organizerId;
  final String mainPicture;
  final int categoryId;
  final String categoryName;
  final String arDescription;
  final String enDescription;
  final String description;
  final int likesCount;
  final int commentsCount;
  final dynamic createdBy;
  final int creatorUserId;
  final DateTime creationTime;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime fromHour;
  final DateTime toHour;
  final int parentId;
  final int feesType;
  final int repeat;
  final int ticketsCount;
  final int buyingMethod;
  final int status;
  final bool hideComments;
  final int totalSeats;
  final int bookedSeats;
  final int availableSeats;
  final int cityId;
  final String cityName;
  final double latitude;
  final double longitude;
  final String placeName;
  final String arAbout;
  final String enAbout;
  final String about;
  final bool isFeatured;
  final List<dynamic> tags;
  final List<TicketItemModel> tickets;
  final List<dynamic> gallery;
  final dynamic silverTicketPrice;
  final dynamic goldenTicketPrice;
  final dynamic platinumTicketPrice;
  final dynamic vipTicketPrice;
  final int price;
  final bool isRefundable;
  final bool isLiked;
  final List<dynamic> clients;
  final OrganizerModel organizer;
  final int scannedTicketsNum;
  final int eventType;
  final dynamic invitationCode;
  final dynamic enGoldenTicketDescription;
  final dynamic enSilverTicketDescription;
  final dynamic enPlatinumTicketDescription;
  final dynamic enVipTicketDescription;
  final dynamic arGoldenTicketDescription;
  final dynamic arSilverTicketDescription;
  final dynamic arPlatinumTicketDescription;
  final dynamic arVipTicketDescription;
  final dynamic link;
  final String value;
  final String text;
  final int id;

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
    schedules: List<dynamic>.from(json["schedules"].map((x) => x)),
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
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    placeName: json["placeName"],
    arAbout: json["arAbout"],
    enAbout: json["enAbout"],
    about: json["about"],
    isFeatured: json["isFeatured"],
    tags: List<dynamic>.from(json["tags"].map((x) => x)),
    tickets: List<TicketItemModel>.from(json["tickets"].map((x) => TicketItemModel.fromJson(x))),
    gallery: List<dynamic>.from(json["gallery"].map((x) => x)),
    silverTicketPrice: json["silverTicketPrice"],
    goldenTicketPrice: json["goldenTicketPrice"],
    platinumTicketPrice: json["platinumTicketPrice"],
    vipTicketPrice: json["vipTicketPrice"],
    price: json["price"],
    isRefundable: json["isRefundable"],
    isLiked: json["isLiked"],
    clients: List<dynamic>.from(json["clients"].map((x) => x)),
    organizer: OrganizerModel.fromJson(json["organizer"]),
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
    "schedules": List<dynamic>.from(schedules.map((x) => x)),
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
    "tickets": List<dynamic>.from(tickets.map((x) => x.toJson())),
    "gallery": List<dynamic>.from(gallery.map((x) => x)),
    "silverTicketPrice": silverTicketPrice,
    "goldenTicketPrice": goldenTicketPrice,
    "platinumTicketPrice": platinumTicketPrice,
    "vipTicketPrice": vipTicketPrice,
    "price": price,
    "isRefundable": isRefundable,
    "isLiked": isLiked,
    "clients": List<dynamic>.from(clients.map((x) => x)),
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

class TicketItemModel {
  TicketItemModel({
    required this.number,
    required this.name,
    required this.phoneNumber,
    required this.emailAddress,
    required this.clientId,
    required this.client,
    required this.eventId,
    required this.event,
    required this.type,
    required this.date,
    required this.bookingId,
    required this.qrCode,
    required this.scanned,
    required this.id,
  });

  final String number;
  final String name;
  final String phoneNumber;
  final String emailAddress;
  final int clientId;
  final ClientModel client;
  final int eventId;
  final EventModel event;
  final int type;
  final DateTime date;
  final String bookingId;
  final String qrCode;
  final bool scanned;
  final int id;

  factory TicketItemModel.fromJson(Map<String, dynamic> json) => TicketItemModel(
    number: json["number"],
    name: json["name"],
    phoneNumber: json["phoneNumber"],
    emailAddress: json["emailAddress"],
    clientId: json["clientId"],
    client: ClientModel.fromJson(json["client"]),
    eventId: json["eventId"],
    event: EventModel.fromJson(json["event"]),
    type: json["type"],
    date: DateTime.parse(json["date"]),
    bookingId: json["bookingId"],
    qrCode: json["qrCode"],
    scanned: json["scanned"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "name": name,
    "phoneNumber": phoneNumber,
    "emailAddress": emailAddress,
    "clientId": clientId,
    "client": client.toJson(),
    "eventId": eventId,
    "event": event.toJson(),
    "type": type,
    "date": date.toIso8601String(),
    "bookingId": bookingId,
    "qrCode": qrCode,
    "scanned": scanned,
    "id": id,
  };
}

class OrganizerModel {
  OrganizerModel({
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
  final int bankId;
  final dynamic accountNumber;
  final dynamic companyWebsite;
  final dynamic imageUrl;
  final bool isLive;
  final String name;
  final String surname;
  final String phoneNumber;
  final String emailAddress;
  final String countryCode;
  final dynamic bankName;
  final String userName;
  final DateTime registrationDate;
  final bool isActive;
  final int id;

  factory OrganizerModel.fromJson(Map<String, dynamic> json) => OrganizerModel(
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

class ClientModel {
  ClientModel({
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

  final String imageUrl;
  final String fullName;
  final String name;
  final String surname;
  final String phoneNumber;
  final String emailAddress;
  final int points;
  final bool isFriend;
  final bool isEmailConfirmed;
  final bool isPhoneNumberConfirmed;
  final int id;

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
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
