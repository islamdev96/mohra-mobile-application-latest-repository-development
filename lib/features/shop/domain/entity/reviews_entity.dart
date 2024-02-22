import 'package:starter_application/core/entities/base_entity.dart';

class ReviewsEntity extends BaseEntity {
  ReviewsEntity({
    this.items,
  });

  List<ItemReviewsEntity>? items;

  @override
  List<Object?> get props => [];
}

class ItemReviewsEntity extends BaseEntity {
  ItemReviewsEntity(
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
  ReviewerReviewsEntity? reviewer;
  int? refId;
  int? refType;
  int? id;
  List<dynamic>? images;

  @override
  List<Object?> get props => [];
}

class ReviewerReviewsEntity extends BaseEntity {
  ReviewerReviewsEntity({
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
  @override
  List<Object?> get props => [];
}
