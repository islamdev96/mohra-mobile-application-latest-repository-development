import 'dart:convert';

import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/shop/domain/entity/check_coupon_entity.dart';

class CheckCouponModel extends BaseModel<CheckCouponEntity> {
  final bool isFreeShipping;
  final int discountPercentage;
  final int shopId;
  CheckCouponModel({
    required this.isFreeShipping,
    required this.discountPercentage,
    required this.shopId,
  });

  Map<String, dynamic> toMap() {
    return {
      'isFreeShipping': isFreeShipping,
      'discountPercentage': discountPercentage,
      'shopId': shopId,
    };
  }

  factory CheckCouponModel.fromMap(Map<String, dynamic> map) {
    return CheckCouponModel(
      isFreeShipping: boolV(map['isFreeShipping']),
      discountPercentage: numV(map['discountPercentage']) ?? 0,
      shopId: numV(map['shopId']) ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CheckCouponModel.fromJson(String source) =>
      CheckCouponModel.fromMap(json.decode(source));

  @override
  CheckCouponEntity toEntity() {
    return CheckCouponEntity(
      isFreeShipping: isFreeShipping,
      discountPercentage: discountPercentage,
      shopId: shopId
    );
  }
}
