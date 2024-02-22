import 'package:starter_application/core/params/base_params.dart';

class CreateEventTicketRequest extends BaseParams {
  CreateEventTicketRequest({
    this.name,
    this.phoneNumber,
    this.emailAddress,
    this.eventId,
    this.date,
    this.ticketTypeInfos,
    this.invitationCode,
  });

  final String? name;
  final String? phoneNumber;
  final String? emailAddress;
  final int? eventId;
  final DateTime? date;
  final List<TicketTypeInfo>? ticketTypeInfos;
  final String? invitationCode;

  factory CreateEventTicketRequest.fromMap(Map<String, dynamic> json) =>
      CreateEventTicketRequest(
        name: json["name"] == null ? null : json["name"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        emailAddress:
            json["emailAddress"] == null ? null : json["emailAddress"],
        eventId: json["eventId"] == null ? null : json["eventId"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        invitationCode:
            json["invitationCode"] == null ? null : json["invitationCode"],
        ticketTypeInfos: json["ticketTypeInfos"] == null
            ? null
            : List<TicketTypeInfo>.from(
                json["ticketTypeInfos"].map((x) => TicketTypeInfo.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "emailAddress": emailAddress == null ? null : emailAddress,
        "eventId": eventId == null ? null : eventId,
        "ticketTypeInfos": ticketTypeInfos == null
            ? null
            : List<dynamic>.from(ticketTypeInfos!.map((x) => x.toMap())),
        "date": date == null ? null : date!.toIso8601String(),
        "invitationCode": invitationCode == null ? null : invitationCode,
      };
}

class TicketTypeInfo {
  TicketTypeInfo({
    this.type,
    this.quantity,
  });

  final int? type;
  final int? quantity;

  factory TicketTypeInfo.fromMap(Map<String, dynamic> json) => TicketTypeInfo(
        type: json["type"] == null ? null : json["type"],
        quantity: json["quantity"] == null ? null : json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "type": type == null ? null : type,
        "quantity": quantity == null ? null : quantity,
      };
}
