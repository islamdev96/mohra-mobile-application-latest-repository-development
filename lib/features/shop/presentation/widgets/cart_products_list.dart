import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/provider/cart.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/cart_screen_notifier.dart';
import 'package:starter_application/features/shop/presentation/widgets/select_item_card.dart';

class CartProductsList extends StatelessWidget {
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onSelectAllTap;
  final Function(int index)? onItemTap;
  final List<CartProduct> items;
  final CartScreenNotifier sn;

  const CartProductsList({
    Key? key,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
    this.onItemTap,
    this.onSelectAllTap,
    required this.items,
    required this.sn,
  }) : super(key: key);

  /// Getters and Setters

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return SelectItemCard(
          height: 200.h,
          sn: sn,
          color: Colors.white,
          product: items[index],
          onTap: () => onItemTap?.call(index),

        );
      },
      separatorBuilder: (context, index) {
        return Gaps.vGap10;
      },
      itemCount: items.length,
    );
  }
}
