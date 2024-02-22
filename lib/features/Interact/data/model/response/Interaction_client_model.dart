import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/Interact/domain/entity/Interaction_client_entity.dart';
import 'package:starter_application/features/like/domain/entity/like_client_entity.dart';

class InteractionClientModel extends BaseModel<InteractionClientEntity> {
  InteractionClientModel({
    required this.imageUrl,
    required this.name,
    required this.phoneNumber,
    required this.emailAddress,
    this.id,
    this.points,
  });

  final String? imageUrl;
  final String name;
  final String phoneNumber;
  final String emailAddress;
  final int? id;
  final int? points;

  factory InteractionClientModel.fromMap(Map<String, dynamic> json) => InteractionClientModel(
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        name: json["name"] == null ? null : json["name"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        emailAddress:
            json["emailAddress"] == null ? null : json["emailAddress"],
        id: json["id"] == null ? null : json["id"],
        points: json["points"] == null ? null : json["points"],
      );

  Map<String, dynamic> toMap() => {
        "imageUrl": imageUrl,
        "name": name,
        "phoneNumber": phoneNumber,
        "emailAddress": emailAddress,
        "id": id == null ? null : id,
      };

  @override
  InteractionClientEntity toEntity() {
    return InteractionClientEntity(
        imageUrl: imageUrl,
        name: name,
        phoneNumber: phoneNumber,
        emailAddress: emailAddress,
        points: points,
        id: id);
  }
}
