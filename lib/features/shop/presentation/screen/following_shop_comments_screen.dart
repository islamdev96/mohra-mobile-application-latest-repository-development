import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/following_shop_comments_screen_notifier.dart';
import 'following_shop_comments_screen_content.dart';



class FollowingShopCommentsScreen extends StatefulWidget {
  static const String routeName = "/FollowingShopCommentsScreen";
  int shopId;
   FollowingShopCommentsScreen({Key? key , required this.shopId}) : super(key: key);

  @override
  _FollowingShopCommentsScreenState createState() => _FollowingShopCommentsScreenState();
}

class _FollowingShopCommentsScreenState extends State<FollowingShopCommentsScreen> {
  final sn = FollowingShopCommentsScreenNotifier();

  @override
  void initState() {
    sn.shopId = widget.shopId;
    sn.getFirstComments();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
       return ChangeNotifierProvider<FollowingShopCommentsScreenNotifier>.value(
        value: sn,
        child: Scaffold(
          appBar: buildCustomAppbar(
            titleText: Translation.current.comments
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: FollowingShopCommentsScreenContent(),
      ),
      );
    }


}
  

 


