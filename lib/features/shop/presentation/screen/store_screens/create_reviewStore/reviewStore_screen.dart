import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/shop/domain/entity/shops_list_entity.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/single_store_screen.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/reviewStore_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

import 'reviewStore_screen_content.dart';

class ReviewStorScreen extends StatefulWidget {
  static const String routeName = "/ReviewStorScreen";
  const ReviewStorScreen({Key? key}) : super(key: key);

  @override
  _ReviewProductScreenState createState() => _ReviewProductScreenState();
}

class _ReviewProductScreenState extends State<ReviewStorScreen> {
  late ReviewStoreScreenNotifier sn;

  @override
  void initState() {
    sn = ReviewStoreScreenNotifier(1);
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

 late SingleStorePageParam argall;
  @override
  Widget build(BuildContext context) {
    argall = ModalRoute.of(context)!.settings.arguments as SingleStorePageParam;
    ShopEntity store = argall.topStore;

    sn.idStore = store.id;
    return ChangeNotifierProvider<ReviewStoreScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildCustomAppbar(titleText: Translation.of(context).Review),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeder(store),
            Expanded(child: CreateReviewStoreScreenContent(argall)),
          ],
        ),
      ),
    );
  }
}

Widget _buildHeder(ShopEntity productItem) {
  return Padding(
    padding: EdgeInsets.only(top: 20.h, right: 50.w, left: 50.w),
    child: Container(
      height: 200.h,
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
                      image: NetworkImage(productItem.logoUrl!))),
            ),
          ),
          Gaps.hGap64,
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(productItem.name!,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w800)),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
