// To parse this JSON data, do
//
//     final topStoreEndety = topStoreEndetyFromMap(jsonString);

import 'dart:convert';
import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/shop/domain/entity/reviews_entity.dart';

import '/core/common/extensions/base_model_list_extension.dart';

ReviewsModel topStoreEndetyFromMap(String str) =>
    ReviewsModel.fromMap(json.decode(str));

String topStoreEndetyToMap(ReviewsModel data) => json.encode(data.toMap());

class ReviewsModel extends BaseModel<ReviewsEntity> {
  ReviewsModel({
    this.items,
  });

  List<ItemReviewsModel>? items;

  factory ReviewsModel.fromMap(Map<String, dynamic> json) => ReviewsModel(
        items: json["items"].isNotEmpty
            ? List<ItemReviewsModel>.from(
                json["items"].map((x) => ItemReviewsModel.fromMap(x)))
            : [],
      );

  Map<String, dynamic> toMap() => {
        "items": List<dynamic>.from(items!.map((x) => x.toMap())),
      };

  @override
  ReviewsEntity toEntity() {
    return ReviewsEntity(items: items?.toListEntity());
  }
}

class ItemReviewsModel extends BaseModel<ItemReviewsEntity> {
  ItemReviewsModel(
      {this.rate,
      this.comment,
      this.creationTime,
      this.reviewerId,
      this.reviewer,
      this.refId,
      this.refType,
      this.id,
      this.images});

  int? rate;
  String? comment;
  DateTime? creationTime;
  int? reviewerId;
  ReviewerReviewsModel? reviewer;
  int? refId;
  int? refType;
  int? id;
  List<dynamic>? images;

  factory ItemReviewsModel.fromMap(Map<String, dynamic> json) =>
      ItemReviewsModel(
        rate: json["rate"],
        comment: stringV(json["comment"]),
        creationTime: DateTime.parse(json["creationTime"]),
        reviewerId: json["reviewerId"],
        reviewer: json["reviewer"] != null
            ? ReviewerReviewsModel.fromMap(json["reviewer"])
            : ReviewerReviewsModel(),
        refId: json["refId"],
        refType: json["refType"],
        images: json["images"].isNotEmpty ? json["images"] : [],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "rate": rate,
        "comment": comment,
        "creationTime": creationTime!.toIso8601String(),
        "reviewerId": reviewerId,
        "reviewer": reviewer!.toMap(),
        "refId": refId,
        "images": images,
        "refType": refType,
        "id": id,
      };

  @override
  ItemReviewsEntity toEntity() {
    return ItemReviewsEntity(
        id: id,
        rate: rate,
        images: images,
        comment: comment,
        refType: refType,
        creationTime: creationTime,
        reviewerId: reviewerId,
        reviewer: reviewer?.toEntity(),
        refId: refId);
  }
}

class ReviewerReviewsModel extends BaseModel<ReviewerReviewsEntity> {
  ReviewerReviewsModel({
    this.imageUrl,
    this.name,
    this.phoneNumber,
    this.emailAddress,
    this.id,
  });

  String? imageUrl;
  String? name;
  String? phoneNumber;
  String? emailAddress;
  int? id;

  factory ReviewerReviewsModel.fromMap(Map<String, dynamic> json) =>
      ReviewerReviewsModel(
        imageUrl: stringV(json["imageUrl"]),
        name: stringV(json["name"]),
        phoneNumber: stringV(json["phoneNumber"]),
        emailAddress: stringV(json["emailAddress"]),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "imageUrl": imageUrl,
        "name": name,
        "phoneNumber": phoneNumber,
        "emailAddress": emailAddress,
        "id": id,
      };

  @override
  ReviewerReviewsEntity toEntity() {
    return ReviewerReviewsEntity(
        imageUrl: imageUrl,
        id: id,
        name: name,
        phoneNumber: phoneNumber,
        emailAddress: emailAddress);
  }
}
