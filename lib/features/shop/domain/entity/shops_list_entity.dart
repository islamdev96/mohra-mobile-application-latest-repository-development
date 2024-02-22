import 'package:starter_application/core/entities/base_entity.dart';

class ShopsListEntity extends BaseEntity {
  ShopsListEntity({
    this.items,
  });

  List<ShopEntity>? items;

  @override
  List<Object?> get props => [];
}

class ShopEntity extends BaseEntity {
  ShopEntity({
    required this.name,
    required this.logoUrl,
    required this.coverUrl,
    required this.followersCount,
    required this.id,
    required this.rate,
    required this.ratings,
    required this.description,
    required this.isFollowed,
    required this.interactionsCount,
    required this.commentsCount,
    required this.comments,
    required this.verified,
  });

  final String? name;
  final String description;
  final String? logoUrl;
  final String? coverUrl;
  final int? id;
  final double? rate;
  final Map<String, int>? ratings;
  bool isFollowed;
  int? followersCount;
  final int commentsCount;
  final List<CommentOnShopEntity> comments;
  final int interactionsCount;
  final bool verified;

  @override
  List<Object?> get props => [
        this.name,
        this.logoUrl,
        this.coverUrl,
        this.followersCount,
        this.id,
        this.rate,
        this.ratings,
        this.description,
        this.isFollowed,
    this.verified,
      ];

  ShopEntity copyWith({
    String? name,
    String? description,
    String? logoUrl,
    String? coverUrl,
    int? followersCount,
    int? id,
    double? rate,
    Map<String, int>? ratings,
    bool? isFollowed,
    int? commentsCount,
    List<CommentOnShopEntity>? comments,
    int? interactionsCount,
    bool? verified
  }) {
    return ShopEntity(
      name: name ?? this.name,
      description: description ?? this.description,
      logoUrl: logoUrl ?? this.logoUrl,
      coverUrl: coverUrl ?? this.coverUrl,
      followersCount: followersCount ?? this.followersCount,
      id: id ?? this.id,
      rate: rate ?? this.rate,
      ratings: ratings ?? this.ratings,
      isFollowed: isFollowed ?? this.isFollowed,
      comments:  comments ?? this.comments,
      commentsCount:  commentsCount ?? this.commentsCount,
      interactionsCount:  interactionsCount ?? this.interactionsCount,
      verified:verified??this.verified,
    );
  }
}



class CommentOnShopEntity extends BaseEntity   {
  CommentOnShopEntity({
    required this.text,
    required this.refId,
    required this.refType,
    required this.creationTime,
    required this.clientId,
    required this.id,
  });

  String text;
  String refId;
  int refType;
  DateTime creationTime;
  int clientId;
  int id;

  @override
  // TODO: implement props
  List<Object?> get props => [];


}