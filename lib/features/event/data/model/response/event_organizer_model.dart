import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/event/domain/entity/event_organizer_entity.dart';

class EventOrganizerModel extends BaseModel<EventOrganizerEntity> {
  EventOrganizerModel({
    required this.licenseUrl,
    this.bankId,
    required this.accountNumber,
    required this.companyWebsite,
    required this.imageUrl,
    required this.isLive,
    required this.name,
    required this.surname,
    required this.phoneNumber,
    required this.emailAddress,
    required this.isActive,
    required this.userName,
    this.registrationDate,
    this.id,
  });

  final String licenseUrl;
  final int? bankId;
  final String accountNumber;
  final String companyWebsite;
  final String imageUrl;
  final bool isLive;
  final String name;
  final String surname;
  final String phoneNumber;
  final String emailAddress;
  final bool isActive;
  final String userName;
  final DateTime? registrationDate;
  final int? id;

  factory EventOrganizerModel.fromMap(Map<String, dynamic> json) =>
      EventOrganizerModel(
        licenseUrl: stringV(json["licenseUrl"]),
        bankId: json["bankId"] == null ? null : json["bankId"],
        accountNumber: stringV(json["accountNumber"]),
        companyWebsite: stringV(json["companyWebsite"]),
        imageUrl: stringV(json["imageUrl"]),
        isLive: boolV(json["isLive"]),
        name: stringV(json["name"]),
        surname: stringV(json["surname"]),
        phoneNumber: stringV(json["phoneNumber"]),
        emailAddress: stringV(json["emailAddress"]),
        isActive: boolV(json["isActive"]),
        userName: stringV(json["userName"]),
        registrationDate: json["registrationDate"] == null
            ? null
            : DateTime.parse(json["registrationDate"]),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "licenseUrl": licenseUrl,
        "bankId": bankId == null ? null : bankId,
        "accountNumber": accountNumber,
        "companyWebsite": companyWebsite,
        "imageUrl": imageUrl,
        "isLive": isLive,
        "name": name,
        "surname": surname,
        "phoneNumber": phoneNumber,
        "emailAddress": emailAddress,
        "isActive": isActive,
        "userName": userName,
        "registrationDate": registrationDate == null
            ? null
            : registrationDate!.toIso8601String(),
        "id": id == null ? null : id,
      };

  @override
  EventOrganizerEntity toEntity() {
    return EventOrganizerEntity(
        licenseUrl: licenseUrl,
        accountNumber: accountNumber,
        companyWebsite: companyWebsite,
        imageUrl: imageUrl,
        isLive: isLive,
        name: name,
        surname: surname,
        phoneNumber: phoneNumber,
        emailAddress: emailAddress,
        isActive: isActive,
        userName: userName,
        id: id,
        bankId: bankId,
        registrationDate: registrationDate);
  }
}
