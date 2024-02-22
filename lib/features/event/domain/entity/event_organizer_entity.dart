import 'package:starter_application/core/entities/base_entity.dart';

class EventOrganizerEntity extends BaseEntity {
  EventOrganizerEntity({
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

  @override
  List<Object?> get props => [];
}
