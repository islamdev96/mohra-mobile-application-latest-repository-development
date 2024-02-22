import 'package:starter_application/core/params/base_params.dart';

class GetSliderImagesParam extends BaseParams {
  final int? shopId;
  final int? productId;
  GetSliderImagesParam({
    this.shopId,
    this.productId,
  });
  // : assert((shopId != null) ^ (productId != null));

  @override
  Map<String, dynamic> toMap() => {
        if (shopId != null) "ShopId": shopId,
        if (productId != null) "ProductId": productId,
      };
}
