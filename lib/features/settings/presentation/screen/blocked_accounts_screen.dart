import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/blocked_accounts_screen_notifier.dart';
import 'blocked_accounts_screen_content.dart';



class BlockedAccountsScreen extends StatefulWidget {
  static const String routeName = "/BlockedAccountsScreen";

  const BlockedAccountsScreen({Key? key}) : super(key: key);

  @override
  _BlockedAccountsScreenState createState() => _BlockedAccountsScreenState();
}

class _BlockedAccountsScreenState extends State<BlockedAccountsScreen> {
  final sn = BlockedAccountsScreenNotifier();

  @override
  void initState() {
    sn.getBlockedFriends();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
       return ChangeNotifierProvider<BlockedAccountsScreenNotifier>.value(
        value: sn,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            elevation:  0,
            title:  Text(Translation.current.blocked_accounts),
            titleTextStyle: TextStyle(
              fontSize: 55.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            leading: IconButton(
              onPressed: () => Nav.pop(),
              icon: Icon(
                AppConstants.getIconBack(),
                color:  AppColors.mansourBackArrowColor,
                size: 20,
              ),
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: BlockedAccountsScreenContent(),
      ),
      );
    }


}
  

 


