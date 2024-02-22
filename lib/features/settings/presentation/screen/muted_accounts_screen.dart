import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/muted_accounts_screen_notifier.dart';
import 'muted_accounts_screen_content.dart';



class MutedAccountsScreen extends StatefulWidget {
  static const String routeName = "/MutedAccountsScreen";

  const MutedAccountsScreen({Key? key}) : super(key: key);

  @override
  _MutedAccountsScreenState createState() => _MutedAccountsScreenState();
}

class _MutedAccountsScreenState extends State<MutedAccountsScreen> {
  final sn = MutedAccountsScreenNotifier();

  @override
  void initState() {
    sn.getMutedFriends();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
       return ChangeNotifierProvider<MutedAccountsScreenNotifier>.value(
        value: sn,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            elevation:  0,
            title:  Text(Translation.current.muted_accounts),
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
          body: MutedAccountsScreenContent(),
      ),
      );
    }


}
  

 


