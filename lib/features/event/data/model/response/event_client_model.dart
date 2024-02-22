import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/event/domain/entity/event_client_entity.dart';
import 'package:starter_application/features/personality/data/model/response/get_my_avatar_response.dart';

class EventClientModel extends BaseModel<EventClientEntity> {
  EventClientModel({
    required this.imageUrl,
    required this.name,
    required this.phoneNumber,
    required this.emailAddress,
    this.points,
    this.avatarMonth,
    this.hasAvatar,
    this.avatar,
    this.gender,
    this.id,
  });

  final String imageUrl;
  final String name;
  final String phoneNumber;
  final String emailAddress;
  final int? points;
  final int? avatarMonth;
  final bool? hasAvatar;
  final ClinetAvatarModel? avatar;
  final int? gender;
  final int? id;

  factory EventClientModel.fromMap(Map<String, dynamic> json) =>
      EventClientModel(
        imageUrl: stringV(json["imageUrl"]),
        name: stringV(json["name"]),
        phoneNumber: stringV(json["phoneNumber"]),
        emailAddress: stringV(json["emailAddress"]),
        id: json["id"] == null ? null : json["id"],
        points: json["points"] == null ? null : json["points"],
          avatarMonth : json['avatarMonth'],
          hasAvatar : json['hasAvatar'],
          avatar :
      json['avatar'] != null ? new ClinetAvatarModel.fromMap(json['avatar']) : null,
  gender : json['gender'],
      );

  Map<String, dynamic> toMap() => {
        "imageUrl": imageUrl,
        "name": name,
        "phoneNumber": phoneNumber,
        "emailAddress": emailAddress,
        "points": points,
        "id": id == null ? null : id,
      };

  @override
  EventClientEntity toEntity() {
    return EventClientEntity(
        imageUrl: imageUrl,
        name: name,
        phoneNumber: phoneNumber,
        emailAddress: emailAddress,
        id: id,
        points: points,
        avatar: avatar != null ?avatar!.toEntity() : null
    );
  }
}
class ClinetAvatarModel extends BaseModel<ClinetAvatarEntity>{
  String? image;
  String? avatarUrl;
  String? arDescription;
  String? enDescription;
  String? description;
  int? gender;
  int? month;
  bool? isActive;
  String? arName;
  String? enName;
  String? name;
  int? id;

  ClinetAvatarModel(
      {this.image,
        this.avatarUrl,
        this.arDescription,
        this.enDescription,
        this.description,
        this.gender,
        this.month,
        this.isActive,
        this.arName,
        this.enName,
        this.name,
        this.id});
  factory ClinetAvatarModel.fromMap(Map<String, dynamic> json) =>
      ClinetAvatarModel(
          image :  json['image'],
          avatarUrl:  json['avatarUrl'],
          arDescription :  json['arDescription'],
      enDescription : json['enDescription'],
      description :  json['description'],
      gender :  json['gender'],
      month : json['month'],
      isActive :  json['isActive'],
      arName :  json['arName'],
      enName : json['enName'],
      name :  json['name'],
          id : json['id'],
      );

  @override
  ClinetAvatarEntity toEntity() {
    return ClinetAvatarEntity(avatarUrl: this.avatarUrl,image: this.image,isActive: this.isActive,id: this.id,arName: this.arName,enName: this.enName,name: this.name,gender: this.gender,arDescription: this.arDescription,description: this.description,enDescription: this.enDescription,month: this.month,);
  }
}