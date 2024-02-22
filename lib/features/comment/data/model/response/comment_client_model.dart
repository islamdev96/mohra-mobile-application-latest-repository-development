import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/comment/domain/entity/comment_client_entity.dart';

class CommentClientModel extends BaseModel<CommentClientEntity> {
  CommentClientModel({
    required this.imageUrl,
    required this.name,
    required this.phoneNumber,
    required this.emailAddress,
    required this.fullName,
    required this.id,
  });

  final String imageUrl;
  final String name;
  final String phoneNumber;
  final String emailAddress;
  final String fullName;

  final int? id;

  factory CommentClientModel.fromMap(Map<String, dynamic> json) =>
      CommentClientModel(
        imageUrl: stringV(json["imageUrl"]),
        name: stringV(json["name"]),
        fullName: stringV(json["fullName"]),
        phoneNumber: stringV(json["phoneNumber"]),
        emailAddress: stringV(json["emailAddress"]),
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
  CommentClientEntity toEntity() {
    return CommentClientEntity(
        imageUrl: imageUrl,
        name: name,
        fullName: fullName,
        phoneNumber: phoneNumber,
        emailAddress: emailAddress,
        id: id);
  }
}
