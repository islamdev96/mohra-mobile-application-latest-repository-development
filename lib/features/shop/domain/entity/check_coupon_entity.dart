import 'package:starter_application/core/entities/base_entity.dart';

class CheckCouponEntity extends BaseEntity{
  final bool isFreeShipping;
  final int discountPercentage;
  final int shopId;
  CheckCouponEntity({
    required this.isFreeShipping,
    required this.discountPercentage,
    required this.shopId,
  });

  @override
  List<Object?> get props => [isFreeShipping,discountPercentage,shopId];
}
