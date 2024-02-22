import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/like/domain/entity/like_client_entity.dart';

class LikeClientModel extends BaseModel<LikeClientEntity> {
  LikeClientModel({
    required this.imageUrl,
    required this.name,
    required this.phoneNumber,
    required this.emailAddress,
    this.id,
  });

  final String imageUrl;
  final String name;
  final String phoneNumber;
  final String emailAddress;
  final int? id;

  factory LikeClientModel.fromMap(Map<String, dynamic> json) => LikeClientModel(
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        name: json["name"] == null ? null : json["name"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        emailAddress:
            json["emailAddress"] == null ? null : json["emailAddress"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "imageUrl": imageUrl,
        "name": name,
        "phoneNumber": phoneNumber,
        "emailAddress": emailAddress,
        "id": id == null ? null : id,
      };

  @override
  LikeClientEntity toEntity() {
    return LikeClientEntity(
        imageUrl: imageUrl,
        name: name,
        phoneNumber: phoneNumber,
        emailAddress: emailAddress,
        id: id);
  }
}
