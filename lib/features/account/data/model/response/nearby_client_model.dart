import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/account/domain/entity/nearby_client_entity.dart';

class NearbyClientModel extends BaseModel<NearbyClientEntity> {
  NearbyClientModel(
      {required this.imageUrl,
      required this.name,
      required this.phoneNumber,
      required this.emailAddress,
      this.points,
      this.id,
      required this.isFriend});

  final String imageUrl;
  final String name;
  final String phoneNumber;
  final String emailAddress;
  final int? points;
  final int? id;
  final bool isFriend;

  factory NearbyClientModel.fromMap(Map<String, dynamic> json) =>
      NearbyClientModel(
        imageUrl: stringV(json["imageUrl"]),
        name: stringV(json["name"]),
        phoneNumber: stringV(json["phoneNumber"]),
        emailAddress: stringV(json["emailAddress"]),
        points: json["points"] == null ? null : json["points"],
        id: json["id"] == null ? null : json["id"],
        isFriend: boolV(json["isFriend"]),
      );

  Map<String, dynamic> toMap() => {
        "imageUrl": imageUrl,
        "name": name,
        "phoneNumber": phoneNumber,
        "emailAddress": emailAddress,
        "points": points == null ? null : points,
        "id": id == null ? null : id,
        "isFriend": isFriend,
      };

  @override
  NearbyClientEntity toEntity() {
    return NearbyClientEntity(
        imageUrl: imageUrl,
        name: name,
        phoneNumber: phoneNumber,
        emailAddress: emailAddress,
        id: id,
        points: points,
        isFriend: isFriend);
  }
}
