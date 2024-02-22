import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/provider/cart.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/features/shop/domain/entity/productItem_entity.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/cart_screen.dart';
import 'package:starter_application/generated/l10n.dart';

import 'add_to_cart_bottomsheet.dart';

class AddToCartButton extends StatelessWidget {
  final ProductItemEntity product;
  final Radius? borderRadius;

  AddToCartButton({
    Key? key,
    required this.product,
    this.borderRadius,
  }) : super(key: key);
  final cart = AppConfig().appContext.read<Cart>();

  @override
  Widget build(BuildContext context) {
    return CustomMansourButton(
      onPressed: () {
       // int isFound =  cart.getIDProduct(product.id!);
        if((product.quantity??0) > 0) {
          onAddToCartTap(context);
        }else{
          showSnackbar(AppConfig().isLTR ? "The product could not be added to the cart. There are not enough items for this product. Sorry":"لا يمكن إضافة المنتج الى السلة, لا يوجد عدد كافي من هذا المنتج, عذراً");
        }
      },
      titleText: Translation.of(context).Add_To_Cart,
    );
  }

  void onAddToCartTap(BuildContext context) async {
    print("prodcutPrice${product.price}");
   bool isNotUpdate = await cart.addProduct(
      CartProduct(
        productId: product.id!,
        productName: product.name!,
        productCombinationId: product.combinations!.first.id!,
        productImage: product.imageUrl ?? '',
        price: product.price ?? 0,
        store: CartStore(
          shopId: product.shopId!,
          shopName: product.shop?.name ?? '',
          shopImage: product.shop?.logoUrl ?? '',
          followersCount: product.shop?.followersCount ?? 0,
        ),
        quantity: 1,
        extraInformation: '',
        allQuantity: product.quantity??0,
      ),
    );
if(isNotUpdate) {
  showAddToCartBottomSheet(
      context: context,
      Items: [
        product,
      ],
      onNav: () {
        Nav.pop();
        Nav.to(CartScreen.routeName);
      });
}else{
  showSnackbar(AppConfig().isLTR ? "No modification has been made due to the allowed number":"لم يتم التعديل بسبب العدد المسموح");
}
  }
}
