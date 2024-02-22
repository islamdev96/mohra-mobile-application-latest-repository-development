import 'package:starter_application/core/entities/base_entity.dart';

class ProductItemEntity extends BaseEntity {
  ProductItemEntity({
    this.quantity,
    this.minRequestQuantity,
    this.imageUrl,
    this.description,
    this.price,
    this.shopId,
    this.shop,
    this.classificationId,
    this.classificationName,
    this.gallery,
    this.offerPrice,
    this.isFeatured,
    this.rate,
    this.ratesCount,
    this.reviews,
    this.soldCount,
    this.isFavorite,
    this.colors,
    this.sizes,
    this.combinations,
    this.attributes,
    this.isActive,
    this.alreadyPurchasedBefore ,
    this.name,
    this.id,
  });

  int? quantity;
  int? minRequestQuantity;
  String? imageUrl;
  String? description;
  double? price;
  int? shopId;
  ShopProductItemEntity? shop;
  int? classificationId;
  String? classificationName;
  List<String>? gallery;
  double? offerPrice;
  bool? isFeatured;
  double? rate;
  int? ratesCount;
  int? reviews;
  int? soldCount;
  bool? isFavorite;
  String? colors;
  String? sizes;
  List<CombinationProductItemEntity>? combinations;
  List<AttributesProductItemEntity>? attributes;
  bool? isActive;
  bool? alreadyPurchasedBefore;
  String? name;
  int? id;

  @override
  List<Object?> get props => [
        this.quantity,
        this.minRequestQuantity,
        this.imageUrl,
        this.description,
        this.price,
        this.shopId,
        this.shop,
        this.classificationId,
        this.classificationName,
        this.gallery,
        this.offerPrice,
        this.isFeatured,
        this.rate,
        this.ratesCount,
        this.reviews,
        this.soldCount,
        this.isFavorite,
        this.colors,
        this.sizes,
        this.combinations,
        this.attributes,
        this.isActive,
        this.alreadyPurchasedBefore,
        this.name,
        this.id,
      ];

  ProductItemEntity copyWith({
    int? quantity,
    int? minRequestQuantity,
    String? imageUrl,
    String? description,
    double? price,
    int? shopId,
    ShopProductItemEntity? shop,
    int? classificationId,
    String? classificationName,
    List<String>? gallery,
    double? offerPrice,
    bool? isFeatured,
    double? rate,
    int? ratesCount,
    int? reviews,
    int? soldCount,
    bool? isFavorite,
    String? colors,
    String? sizes,
    List<CombinationProductItemEntity>? combinations,
    List<AttributesProductItemEntity>? attributes,
    bool? isActive,
    bool? alreadyPurchasedBefore,
    String? name,
    int? id,
  }) {
    return ProductItemEntity(
      quantity: quantity ?? this.quantity,
      minRequestQuantity: minRequestQuantity ?? this.minRequestQuantity,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      price: price ?? this.price,
      shopId: shopId ?? this.shopId,
      shop: shop ?? this.shop,
      classificationId: classificationId ?? this.classificationId,
      classificationName: classificationName ?? this.classificationName,
      gallery: gallery ?? this.gallery,
      offerPrice: offerPrice ?? this.offerPrice,
      isFeatured: isFeatured ?? this.isFeatured,
      rate: rate ?? this.rate,
      reviews: reviews ?? this.reviews,
      ratesCount: ratesCount ?? this.ratesCount,
      soldCount: soldCount ?? this.soldCount,
      isFavorite: isFavorite ?? this.isFavorite,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
      combinations: combinations ?? this.combinations,
      attributes: attributes ?? this.attributes,
      isActive: isActive ?? this.isActive,
      alreadyPurchasedBefore: alreadyPurchasedBefore ?? this.alreadyPurchasedBefore,
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }
}

class AttributesProductItemEntity extends BaseEntity {
  AttributesProductItemEntity({
    this.key,
    this.value,
  });

  String? key;
  String? value;

  @override
  List<Object?> get props => [];
}

class CombinationProductItemEntity extends BaseEntity {
  CombinationProductItemEntity({
    this.productId,
    this.uniqueId,
    this.price,
    this.quantity,
    this.colorId,
    this.sizeId,
    this.colorName,
    this.colorCode,
    this.sizeName,
    this.id,
  });

  int? productId;
  String? uniqueId;
  double? price;
  int? quantity;
  int? colorId;
  int? sizeId;
  String? colorName;
  String? colorCode;
  String? sizeName;
  int? id;

  @override
  List<Object?> get props => [];
}

class ShopProductItemEntity extends BaseEntity {
  ShopProductItemEntity({
    this.id,
    this.logoUrl,
    this.coverUrl,
    this.name,
    this.description,
    this.followersCount,
    this.isFollowed,
  });

 final  int? id;
 final  String? logoUrl;
 final  String? coverUrl;
 final  String? name;
 final  String? description;
 final  int? followersCount;
 final  bool? isFollowed;

  @override
  List<Object?> get props => [
        this.id,
        this.logoUrl,
        this.coverUrl,
        this.name,
        this.description,
        this.followersCount,
        this.isFollowed,
      ];

  ShopProductItemEntity copyWith({
    int? id,
    String? logoUrl,
    String? coverUrl,
    String? name,
    String? description,
    int? followersCount,
    bool? isFollowed,
  }) {
    return ShopProductItemEntity(
      id: id ?? this.id,
      logoUrl: logoUrl ?? this.logoUrl,
      coverUrl: coverUrl ?? this.coverUrl,
      name: name ?? this.name,
      description: description ?? this.description,
      followersCount: followersCount ?? this.followersCount,
      isFollowed: isFollowed ?? this.isFollowed,
    );
  }
}
