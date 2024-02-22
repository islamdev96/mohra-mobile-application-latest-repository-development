import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/shop/domain/entity/productItem_entity.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/reviewProduct_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

import 'reviewProduct_screen_content.dart';

class ReviewProductScreen extends StatefulWidget {
  static const String routeName = "/ReviewProductScreen";
  const ReviewProductScreen({Key? key}) : super(key: key);

  @override
  _ReviewProductScreenState createState() => _ReviewProductScreenState();
}

class _ReviewProductScreenState extends State<ReviewProductScreen> {
  late ReviewProductScreenNotifier sn;

  @override
  void initState() {
    sn = ReviewProductScreenNotifier(1);
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var productItem =
        ModalRoute.of(context)!.settings.arguments as ProductItemEntity;
    sn.idProduct = productItem.id;
    return ChangeNotifierProvider<ReviewProductScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildCustomAppbar(titleText: Translation.of(context).Review),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeder(productItem),
            Expanded(child: CreateReviewProductScreenContent()),
          ],
        ),
      ),
    );
  }
}

Widget _buildHeder(ProductItemEntity productItem) {
  return Padding(
    padding: EdgeInsets.only(top: 20.h, right: 50.w, left: 50.w),
    child: Container(
      height: 230.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              height: 200.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  image: DecorationImage(
                      image: NetworkImage(productItem.imageUrl!))),
            ),
          ),
          Gaps.hGap64,
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(productItem.name!,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w800)),
                Text(
                  '${Translation.current.SAR} ${productItem.price!.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.red),
                ),
                Text(
                  productItem.shop!.name!,
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
